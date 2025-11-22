Instr_Dic = {
    "lsl": {"opcode": "11010011011"},
    "lsr": {"opcode": "11010011010"},
    "LSL": {"opcode": "11010011011"},
    "LSR": {"opcode": "11010011010"}
}

def main():
    import sys, os
    list_instr = []
    # allow passing input file as first arg, otherwise use shift.s next to script
    if len(sys.argv) > 1:
        infile = sys.argv[1]
    else:
        infile = os.path.join(os.path.dirname(__file__), "shift.s")

    try:
        with open(infile, "r") as file:
            for new_line in file:
                if not new_line.strip():
                    continue
                # normalize separators
                line = new_line.replace(",", " ").split()
                # skip empty or comment lines
                if len(line) == 0 or line[0].startswith('#'):
                    continue
                print("parsing:", line)

                instr = line[0]
                # default Rm (used by some encodings) if not provided
                rm_line = 31

                # expect formats like: LSL Xd, Xn, #imm  -> tokens: [LSL, Xd, Xn, #imm]
                if len(line) < 4:
                    raise ValueError(f"Line has unexpected format: {new_line.strip()}")

                shamt_token = line[3]
                # strip leading '#' if present
                if shamt_token.startswith('#'):
                    shamt_token = shamt_token.lstrip('#')
                # also allow numeric immediates with commas/spaces
                shamt_line = int(shamt_token, 0)

                rn_line = register_number(line[2])
                rd_line = register_number(line[1])

                opcode = Instr_Dic.get(instr)
                if opcode is None:
                    raise ValueError(f"Unknown instruction: {instr}")
                opcode = opcode["opcode"]

                rm = format(int(rm_line), "05b")
                shamt = format(int(shamt_line) & 0x3F, "06b")
                rn = format(int(rn_line) & 0x1F, "05b")
                rd = format(int(rd_line) & 0x1F, "05b")

                instr_binary = opcode + rm + shamt + rn + rd
                instr_assemble = format(int(instr_binary, 2), "x")
                list_instr.append(instr_assemble)

        # write output file next to input file
        outpath = os.path.splitext(infile)[0] + ".hex"
        with open(outpath, "w") as outf:
            for instr in list_instr:
                lineout = "32'h" + instr + ",\n"
                outf.write(lineout)
                print(lineout.strip())
        print(f"Wrote {len(list_instr)} instructions to {outpath}")

    except FileNotFoundError:
        print(f"Error: input file not found: {infile}")
    except Exception as e:
        print(f"An error occurred: {e}")


def register_number(reg):
    return int(reg[1:])

if __name__ == "__main__":
    main()
