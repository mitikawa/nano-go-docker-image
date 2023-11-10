FROM golang:alpine as builder
WORKDIR /app
COPY . .
# CGO_ENABLED=0 results in static libray
# -s no debug
# -w no DWARF symbol table
RUN CGO_ENABLED=0 go build -o hello -ldflags="-s -w"

FROM scratch
COPY --from=builder /app/hello /hello
ENTRYPOINT ["/hello"]
