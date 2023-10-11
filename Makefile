IMAGE_TAG ?= action-doctum

# All: linux/amd64,linux/arm64/v8,linux/riscv64,linux/ppc64le,linux/s390x,linux/386,linux/mips64le,linux/mips64,linux/arm/v7,linux/arm/v6
PLATFORM ?= linux/amd64

ACTION ?= load
PROGRESS_MODE ?= plain

.PHONY: update-tags update-branches push-branches docker-build docker-push

docker-build:
	# https://github.com/docker/buildx#building
	docker buildx build \
		--tag $(IMAGE_TAG) \
		--progress $(PROGRESS_MODE) \
		--platform $(PLATFORM) \
		--build-arg VCS_REF=`git rev-parse HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--$(ACTION) \
		./docker

docker-push:
	docker push $(IMAGE_TAG)

update-tags:
	git checkout 5.x
	git tag -s -f -a -m "5.x series" v5
	git checkout -
	git checkout dev
	git tag -s -f -a -m "dev series" dev
	git checkout -
	git checkout main
	git tag -s -f -a -m "latest series" latest
	git checkout -
	git push origin refs/tags/v5 -f
	git push origin refs/tags/dev -f
	git push origin refs/tags/latest -f

update-branches:
	git checkout 5.x
	git merge main
	git checkout -
	git checkout dev
	git merge main
	git checkout -

push-branches:
	git push origin refs/heads/5.x
	git push origin refs/heads/dev
	git push origin refs/heads/main
