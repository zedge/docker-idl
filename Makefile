all: build

DOCKER=docker
REPO=zedge/idl
TAG=latest

build:
	$(DOCKER) build -t $(REPO):$(TAG) docker/

push: build
	$(DOCKER) push $(REPO):$(TAG)
