FROM registry.access.redhat.com/ubi8/ubi-minimal

# Vars
ARG tpVersion 1.10.0
ARG tpRelease tinyproxy-${tpVersion}

# Default port
EXPOSE 8888/tcp

# Packages
RUN microdnf install tar make wget gzip gcc shadow-utils && \
	microdnf clean all

# Download, decompress, install and clean up
RUN wget https://github.com/tinyproxy/tinyproxy/releases/download/${tpVersion}/${tpRelease}.tar.gz && \
	tar xzvf ${tpRelease}.tar.gz -C /tmp && \ 
  cd /tmp/${tpRelease} && \
	./configure && \
	make && \
	make install && \
	cd .. && \
	rm -rf ${tpRelease} ${tpRelease}.tar.gz

# Configuration
RUN sed -i /usr/local/etc/tinyproxy/tinyproxy.conf \
	-e "s/^#Filter/Filter/" \
	-e "s/^#FilterURLs/FilterURLs/" \
	-e "s/^#FilterExtended/FilterExtended/" \
	-e "s/^#FilterDefaultDeny/FilterDefaultDeny/"

# Startup
USER 1001
CMD ["tinyproxy", "-d"]
