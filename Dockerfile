# Builder
FROM golang:1.19-alpine3.15 as builder
RUN apk add --update --no-cache build-base
WORKDIR /github.com/jsfpdn/congenial-sniffle
COPY . ./
RUN --mount=type=cache,target=/go/pkg/mod \
--mount=type=cache,target=/root/.cache/go-build \
GOMODCACHE=/go/pkg/mod \
GOCACHE=/root/.cache/go-build \
make build

# Runtime
FROM alpine:3.15 as runtime
RUN apk add --update --no-cache bash
WORKDIR /
COPY --from=builder /github.com/jsfpdn/congenial-sniffle/my_bin /bin/my_bin
ENTRYPOINT ["my_bin"]

# Dockerfile-release.arch per architecture.
# It merely copies binary from the ./dist/ directory, e.g.
# https://github.com/etcd-io/etcd/blob/main/Dockerfile-release.amd64

