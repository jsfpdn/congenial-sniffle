BIN = my_bin

# VERSION = $(shell git ls-remote --tags origin || \$\(git rev-parse HEAD | cut -c 1-7\) && \$\(tail -n 1 | cut -d '/' -f3 | cut -d 'v' -f2\))
VERSION = 1.2.3-rc1
LDFLAGS = -X github.com/jsfpdn/congenial-sniffle/cmd.Version=$(VERSION)

.PHONY: all
all: clean $(BIN)

$(BIN): **/*.go
	go build -ldflags="${LDFLAGS}" -o $(BIN) .


.PHONY: clean
clean:
	$(RM) $(BIN)
