FROM alpine:3.12
RUN adduser -D -u 10001 app
USER 10001
CMD ["echo", "hello from sample-app"]
