FROM golang:1.21-bookworm as builder
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -v -o /greet

FROM scratch
COPY --from=builder /greet /greet
EXPOSE 8080
CMD ["/greet"]