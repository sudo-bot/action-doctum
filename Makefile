.PHONY: update-tags docker-build

docker-build:
	docker build ./docker \
		--build-arg VCS_REF=`git rev-parse HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"`

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
	git push origin refs/heads/v5
	git push origin refs/heads/dev
	git push origin refs/heads/latest
