
const int N = 4096;
double X[N], Y[N], Z[N], alpha;

void daxpy() {
    for (int i = 0; i < N; ++i) {
        Z[i] = alpha * X[i] + Y[i];
    }
}

int main() {
    daxpy();
    return 0;
}