FROM debian AS build-0
RUN apt-get update && apt-get install -y gcc
COPY test-0.c test-0.c
RUN mkdir output && gcc test-0.c -o output/test-0

FROM debian AS build-1
RUN apt-get update && apt-get install -y gcc
COPY test-1.c test-1.c
RUN mkdir output && gcc test-1.c -o output/test-1

FROM debian
RUN mkdir /opt/test
COPY --from=build-0 output/test-0 /opt/test/test-0
COPY --from=build-1 output/test-1 /opt/test/test-1
