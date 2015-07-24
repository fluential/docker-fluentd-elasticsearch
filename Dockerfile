# DOCKER-VERSION 1.6.2
# VERSION        0.2

FROM openfirmware/fluentd
MAINTAINER James Badger <james@jamesbadger.ca>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade && apt-get install -y -q libcurl4-openssl-dev make

RUN /usr/lib/fluent/ruby/bin/fluent-gem install fluent-plugin-elasticsearch -V

ADD run.sh /run.sh
ADD setup_plugin.sh /setup_plugin.sh
RUN chmod 755 /*.sh
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 24224
EXPOSE 8888

ENTRYPOINT ["/run.sh"]
CMD ["-v"]
