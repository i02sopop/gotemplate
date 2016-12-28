package go_template

import (
	"testing"
)

func BenchmarkGoTemplate(t *testing.B) {
	for i := 0; i < t.N; i++ {
		// Benchmark test
		GoTemplate()
	}
}

func TestGoTemplate(t *testing.T) {
	GoTemplate()
	t.Logf("Test passed")
}

func ExampleGoTemplate() {
	GoTemplate()
}
