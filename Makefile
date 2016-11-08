all: build

DOCKER=docker
TMP_IMAGE=idl
REPO=zedge/idl
TAG=latest

build:
	$(DOCKER) build -t $(TMP_IMAGE) docker/

tag: build
	version=$$($(DOCKER) run $(TMP_IMAGE) version); \
	echo "tagged idl version $$version"; \
	$(DOCKER) tag $(TMP_IMAGE) $(REPO):$$version; \
	$(DOCKER) tag $(TMP_IMAGE) $(REPO):latest

push: tag
	version=$$($(DOCKER) run $(TMP_IMAGE) version); \
	echo "push idl version $$version"; \
	$(DOCKER) push $(REPO):$$version; \
	$(DOCKER) push $(REPO):latest
