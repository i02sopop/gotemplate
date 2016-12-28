package go_template

import (
	"testing"
)

func BenchmarkExample(t *testing.B) {
	for i := 0; i < t.N; i++ {
		// Benchmark test
		GoTemplate()
	}
}
