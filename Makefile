APP=testing-app
REGISTRY=dmazek
VERSION=v1.0.1
TARGETOS=linux #linux darwin windows
TARGETARCH=arm64 #amd64

test:
	ls

build:
	ls -

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
	
clean:
	ls -r