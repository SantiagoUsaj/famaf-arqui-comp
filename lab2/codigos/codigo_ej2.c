const int N = 64;
const int n_iter = 10;
const int fc_x ,fc_y;

float fc_temp, sum, x[N*N], x_tmp[N*N], t_amb;

void initialize_matrix() {
	// Esta parte inicializa la matriz, solo es necesaria para verificar el código
	for (int i = 0; i < N*N; ++i) {
		x[i] = t_amb;
	}
	x[fc_x*N + fc_y] = fc_temp;
}

void iterate_matrix() {
	for (int k = 0; k < n_iter; ++k) {
		for (int i = 0; i < N; ++i) {
			for (int j = 0; j < N; ++j) {
				if ((i*N + j) != (fc_x*N + fc_y)) {
					sum = 0;
					if (i + 1 < N)
						sum = sum + x[(i + 1)*N + j];
					else
						sum = sum + t_amb;
					if (i - 1 >= 0)
						sum = sum + x[(i - 1)*N + j];
					else
						sum = sum + t_amb;
					if (j + 1 < N)
						sum = sum + x[i*N + j + 1];
					else
						sum = sum + t_amb;
					if (j - 1 >= 0)
						sum = sum + x[i*N + j - 1];
					else
						sum = sum + t_amb;
					x_tmp[i*N + j] = sum / 4;
				}
			}
		}
		for (int i = 0; i < N*N; ++i)
			if (i != (fc_x*N + fc_y))
				x[i] = x_tmp[i];
	}
}

int main() {
	initialize_matrix();
	iterate_matrix();
	return 0;
}