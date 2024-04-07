APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=dmazek
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
#TARGETOS=windows #linux darwin windows
#TARGETARCH=arm64 #amd64

format:
	gofmt -s -w ./

lint: 
	golint

test:
	go test -v

get:
	go get

linux: format
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -v -o kbot -ldflags "-X="github.com/dmazepa/kbot/cmd.appVersion=${VERSION}

windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o kbot -ldflags "-X="github.com/dmazepa/kbot/cmd.appVersion=${VERSION}

macOS:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o kbot -ldflags "-X="github.com/dmazepa/kbot/cmd.appVersion=${VERSION}


image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}

clean:
	docker rmi ${REGISTRY}/${APP}:${VERSION}
