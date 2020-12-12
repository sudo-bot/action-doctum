.PHONY: update-tags docker-build

docker-build:
	docker build ./docker \
		--build-arg VCS_REF=`git rev-parse HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"`

update-tags:
	git checkout main
	git tag -s -f -a -m "latest series" latest
	git checkout -
	git checkout 5.x
	git tag -s -f -a -m "5.x series" 5.x
	git checkout -
	git push origin refs/tags/latest -f
	git push origin refs/tags/5.x -f
