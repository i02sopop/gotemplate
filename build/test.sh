#!/bin/sh
#
# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

export CGO_ENABLED=0

TARGETS=$(for d in "$@"; do go list ./$d/... | grep -v /vendor/; done)

echo "Running tests:"
go test -i -installsuffix "static" ${TARGETS}

echo
echo "Code coverage"
go test -cover -covermode=count -installsuffix "static" ${TARGETS}

echo
echo "Tests"
go test ${TARGETS} -installsuffix "static"

for TARGET in ${TARGETS}; do
	echo
	echo "Profiling for ${TARGET}"
	LOG=`echo ${TARGET} | cut -d'/' -f 3`
	go test -bench=${TARGET} -benchmem -memprofile=mem-${LOG}.log -installsuffix "static"
	go test -bench=${TARGET} -benchmem -blockprofile=block-${LOG}.log -installsuffix "static"
	go test -bench=${TARGET} -benchmem -cpuprofile=cpu-${LOG}.log -installsuffix "static"
done
echo

echo -n "Checking gofmt: "
ERRS=$(find "$@" -type f -name \*.go | grep -v /vendor/ | xargs gofmt -l 2>&1 || true)
if [ -n "${ERRS}" ]; then
    echo "FAIL - the following files need to be gofmt'ed:"
    for e in ${ERRS}; do
        echo "    $e"
    done
    echo
    exit 1
fi
echo "PASS"
echo

echo -n "Checking go vet: "
ERRS=$(go vet ${TARGETS} 2>&1 || true)
if [ -n "${ERRS}" ]; then
    echo "FAIL"
    echo "${ERRS}"
    echo
    exit 1
fi
echo "PASS"
echo
