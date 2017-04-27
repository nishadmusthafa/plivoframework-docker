FROM ubuntu:14.04
MAINTAINER Marconi Moreto Jr. <me@marconijr.com>

COPY plivo_install.sh /
RUN apt-get update && \
	apt-get install -y wget && \
	bash plivo_install.sh /usr/local/plivo

EXPOSE 8084 8088 8089

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD /usr/local/plivo/bin/plivo start && \
	/usr/local/plivo/bin/plivo-cache -d -c /usr/local/plivo/etc/plivo/cache/cache.conf && \
	tail -f /usr/local/plivo/tmp/plivo-rest.log \
		 -f /usr/local/plivo/tmp/plivo-outbound.log
