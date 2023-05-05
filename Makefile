test-regular:
	docker pull localhost:5000/multi-stage-test-regular || true
	docker build \
		--cache-from localhost:5000/multi-stage-test-regular \
		-t localhost:5000/multi-stage-test-regular \
		.
	docker push localhost:5000/multi-stage-test-regular 

test-inline-cache:
	docker build \
		--cache-from localhost:5000/multi-stage-test-inline \
		-t localhost:5000/multi-stage-test-inline \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		.
	docker push localhost:5000/multi-stage-test-inline 

test-registry-cache:
	docker buildx build \
		--push \
		--cache-to type=registry,ref=localhost:5000/multi-stage-test-registry-cache,mode=max \
		--cache-from type=registry,ref=localhost:5000/multi-stage-test-registry-cache,mode=max \
		-t localhost:5000/multi-stage-test-registry \
		.

prune:
	docker builder prune -af
	docker buildx prune -af
	docker image prune -af

