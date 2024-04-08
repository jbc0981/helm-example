FROM public.ecr.aws/docker/library/golang:1.19-alpine AS builder

RUN apk --no-cache add build-base
RUN mkdir /app
ADD . /app/
WORKDIR /app
# Main build
RUN go build -o main .
# Copy artifacts into lightweight container
FROM public.ecr.aws/docker/library/golang:1.19-alpine
RUN apk --no-cache add openssl
RUN mkdir /app
WORKDIR /app
COPY --from=builder /app .
CMD ["/app/main"]