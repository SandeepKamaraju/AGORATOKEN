# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang:alpine
RUN apk add git ca-certificates --update

# fetch dependancies from github (Gin and Agora Token Service)
RUN go get github.com/gin-gonic/gin
# RUN go get github.com/AgoraIO-Community/agora-token-service
ADD . /go/src/github.com/AgoraIO-Community/agora-token-service

ENV APP_ID="734c3d6d010f4a96a27f29329ce91242"
ENV APP_CERTIFICATE="425ebcd1c85f4d6db13aeba0c930a7a6"

# move to the working directory
WORKDIR $GOPATH/src/github.com/AgoraIO-Community/agora-token-service
# Build the token server command inside the container.
RUN go build
# RUN go run main.go
# Run the token server by default when the container starts.
ENTRYPOINT ./agora-token-service

# Document that the service listens on port 8080.
EXPOSE 8080