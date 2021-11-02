FROM registry.access.redhat.com/ubi8/ubi-minimal

# Vars
ENV tpVersion 1.10.0
ENV tpRelease tinyproxy-${tpVersion}

# Default port
EXPOSE 8888/tcp

# Download, decompress, install and clean up
RUN microdnf install gcc make gzip tar && \
	curl -L -o tinyproxy.tar.gz https://github.com/tinyproxy/tinyproxy/releases/download/${tpVersion}/${tpRelease}.tar.gz && \
	tar xzvf tinyproxy.tar.gz -C /tmp && \
	cd /tmp/${tpRelease} && \
	./configure && \
	make && \
	make install && \
	cd .. && \
	rm -rf ${tpRelease} ${tpRelease}.tar.gz && \
	microdnf remove gcc make gzip tar wget && \
	microdnf clean all

# Configuration
COPY ./conf/ /usr/local/etc/tinyproxy/

# Startup
USER 1001
CMD ["tinyproxy", "-d"]
