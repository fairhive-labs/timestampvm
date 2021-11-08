FROM golang as plugin
ENV VM_NAME "tGas3T58KzdjLHhBDMnH2TvrddhqTji5iZAMZ3RXs2NLpSnhH"
WORKDIR /go/src/
COPY . .
RUN go build -o build/${VM_NAME} main/*.go

FROM avaplatform/avalanchego:v1.6.2
WORKDIR /avalanchego/build
COPY --from=plugin /go/src/build/ plugins/