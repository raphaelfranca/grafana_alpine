FROM alpine:3.7

LABEL maintainer "Raphael França <raphaelfrancabsb@gmail.com>"

RUN apk update \
	&& apk --no-cache add ca-certificates openssl curl \ 
	&& curl -o /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \	
	&& curl -LO https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-4.6.3.linux-x64.tar.gz \
	&& apk --no-cache -X http://apkproxy.heroku.com/sgerrand/alpine-pkg-glibc add glibc glibc-bin \
	&& tar xzvf grafana-4.6.3.linux-x64.tar.gz \
	&& mv grafana-4.6.3/ grafana/ \
	&& mkdir -p grafana/data/plugins \
	&& ./grafana/bin/grafana-cli plugins install grafana-clock-panel \
	&& rm -rf grafana-4.6.3.linux-x64.tar.gz \	
	&& apk del curl openssl 

WORKDIR /grafana

EXPOSE 3000

CMD ["./bin/grafana-server"]
