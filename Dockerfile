FROM alpine:3.7

LABEL maintainer "Raphael França <raphaelfrancabsb@gmail.com>"

RUN apk update \
	&& apk --no-cache add ca-certificates wget curl \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk \
	&& apk add glibc-2.28-r0.apk \	
	&& curl -LO https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-4.6.3.linux-x64.tar.gz \	
	&& tar xzvf grafana-4.6.3.linux-x64.tar.gz \
	&& mv grafana-4.6.3/ grafana/ \
	&& mkdir -p grafana/data/plugins \
	&& ./grafana/bin/grafana-cli plugins install grafana-clock-panel \
	&& rm -rf grafana-4.6.3.linux-x64.tar.gz \	
	&& apk del curl openssl

WORKDIR /grafana

EXPOSE 3000

CMD ["./bin/grafana-server"]
