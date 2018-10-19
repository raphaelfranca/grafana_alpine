FROM alpine:3.7

LABEL maintainer "Carlos Augusto Malucelli <malucellicarlos@gmail.com>"

RUN apk update \
	&& apk add openssl curl \ 
	&& curl -o /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
	&& curl -LO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk \
	&& curl -LO https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-4.6.3.linux-x64.tar.gz \
	&& apk add glibc-2.28-r0.apk \
	&& tar xzvf grafana-4.6.3.linux-x64.tar.gz \
	&& mv grafana-4.6.3/ grafana/ \
	&& mkdir -p grafana/data/plugins \
	&& ./grafana/bin/grafana-cli plugins install grafana-clock-panel \
	&& rm -rf grafana-4.6.3.linux-x64.tar.gz \
	&& rm -rf glibc-2.28-r0.apk \
	&& apk del curl openssl 

WORKDIR /grafana

EXPOSE 3000

CMD ["./bin/grafana-server"]
