FROM ubuntu:24.04 AS stone

ARG build_time_proxy
ENV http_proxy=${build_time_proxy}
ENV https_proxy=${build_time_proxy}

RUN : configure proxy for apt \
  && if [ -n "$build_time_proxy" ]; then echo 'acquire::http::proxy "'"$build_time_proxy"'";' >> /etc/apt/apt.conf; fi

RUN : install required packages \
  && apt update \
  && apt install -y gcc make libssl-dev

ADD http://www.gcd.org/sengoku/stone/stone-2.4.tar.gz stone.tar.gz

RUN : compile stone \
  && tar zxf stone.tar.gz \
  && cd stone-*/ \
  && make linux \
  && cp stone /usr/bin/stone

ENTRYPOINT ["/usr/bin/stone"]
