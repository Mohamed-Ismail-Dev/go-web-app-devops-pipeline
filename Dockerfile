FROM golang:1.22.5-alpine as builder

WORKDIR /app

COPY . .

RUN go mod download

RUN go build -o main .

FROM scratch

COPY --from=builder /app/main .
COPY --from=builder /app/static ./static

EXPOSE 8080

CMD ["./main"]