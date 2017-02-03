/* Copyright (C) 2016-2017 Pablo Alvarez de Sotomayor Posadillo <palvarez@ritho.net>

   This file is part of Gotemplate.

   Gotemplate is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   Gotemplate is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with Gotemplate. If not, see <http://www.gnu.org/licenses/>.
*/
package gotemplate

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
