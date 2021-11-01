FROM registry.access.redhat.com/ubi8/ubi-minimal

ENV tpVersion 1.10.0
ENV tpRelease tinyproxy-${tpVersion}

EXPOSE 8888/tcp

# Packages
RUN microdnf install tar make wget gzip gcc shadow-utils && \
	microdnf clean all

#Fetch tinyproxy tarball to /tmp, untar, delete tarball
RUN wget https://github.com/tinyproxy/tinyproxy/releases/download/${tpVersion}/${tpRelease}.tar.gz && \
	tar xzvf ${tpRelease}.tar.gz -C /tmp && \ 
  cd /tmp/${tpRelease} && \
	./configure && \
	make && \
	make install && \
	cd .. && \
	rm -rf ${tpRelease} ${tpRelease}.tar.gz

#Configuration updates, uncommenting...
RUN sed -i /usr/local/etc/tinyproxy/tinyproxy.conf \
	-e "s/^#Filter/Filter/" \
	-e "s/^#FilterURLs/FilterURLs/" \
	-e "s/^#FilterExtended/FilterExtended/" \
	-e "s/^#FilterDefaultDeny/FilterDefaultDeny/"

# # Start tinyproxy
USER 1001
CMD ["tinyproxy", "-d"]
