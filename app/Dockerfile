FROM golang:1.21-bookworm as builder
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY . ./
RUN go build -v -o greet

FROM scratch
COPY --from=builder /app/greet /app/greet
ENTRYPOINT ["/app/greet"]