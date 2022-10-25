TOPDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
BIN := gotemplate
PKG := github.com/i02sopop/$(BIN)
VERSION := $(shell git describe --tags --always --dirty)
BASEIMAGE := alpine
IMAGE := $(REGISTRY)/$(BIN):$(VERSION)

.PHONY: build
build: build-dirs
	@GOARCH="${ARCH}" go build -ldflags "-X ${PKG}/pkg/version.VERSION=${VERSION}" -o $(TOPDIR)/bin/$(BIN) ./cmd/$(BIN)/...

DOTFILE_IMAGE = $(subst /,_,$(IMAGE))-$(VERSION)

.PHONY: container
container:
	@sed \
	    -e 's|ARG_BIN|$(BIN)|g' \
	    -e 's|ARG_ARCH|$(ARCH)|g' \
	    -e 's|ARG_FROM|$(BASEIMAGE)|g' \
	    $(TOPDIR)/Dockerfile.in > $(TOPDIR)/.dockerfile-$(ARCH)
	@docker build -t $(IMAGE):$(VERSION) -f $(TOPDIR)/.dockerfile-$(ARCH) .
	@docker images -q $(IMAGE):$(VERSION) > $@

.PHONY: container-name
container-name:
	@echo "container: $(IMAGE):$(VERSION)"

.PHONY: version
version:
	@echo $(VERSION)

.PHONY: test
test: build-dirs
	@go test -v ./... -race -coverprofile cover.out
	@go tool cover -func "cover.out"

.PHONY: test-update
test-update:
	@go test -v ./... -race -tags=update

.PHONY: lint
lint:
	@golangci-lint run -c $(PWD)/.golangci.yaml

.PHONY: update-lint
update-lint:
	@curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sudo sh -s -- -b /usr/local/bin

.PHONY: build-dirs
build-dirs:
	@mkdir -p $(TOPDIR)/bin

.PHONY: clean
clean:
	@rm -rf $(TOPDIR)/bin
	@rm -fr $(TOPDIR)/cpu-*.log $(TOPDIR)/mem-*.log block-*.log $(TOPDIR)/gotemplate.test

.PHONY: run
run:
	@bin/$(BIN) -alsologtostderr=true
