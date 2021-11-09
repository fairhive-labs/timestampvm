FROM golang as plugin
ENV VM_NAME "n6B2UdbyGWn8modJUZQ1RivVUbVdn5hwcFKnE9bf1KLZGPjNX"
WORKDIR /go/src/
COPY . .
RUN go build -o build/${VM_NAME} main/*.go

FROM avaplatform/avalanchego:v1.6.4
WORKDIR /avalanchego/build
COPY --from=plugin /go/src/build/ plugins/