BIN = my_bin
LDFLAGS = -X github.com/jsfpdn/congenial-sniffle/cmd.Version=$(VERSION)
CGO_ENABLED ?= 1

.PHONY: all
all: clean build

.PHONY: build-release
build-release: VERSION = $(shell git ls-remote --tags origin | tail -n 1 | cut -d '/' -f3 | cut -d 'v' -f2)
build-release: $(BIN)

.PHONY: build
build: VERSION ?= $(shell git rev-parse --short HEAD)
build: $(BIN)

$(BIN): **/*.go
	test $(VERSION) || (echo "version not set"; exit 1)
	CGO_ENABLED=$(CGO_ENABLED) go build -ldflags="$(LDFLAGS)" -o $(BIN) .

.PHONY: clean
clean:
	$(RM) $(BIN)
