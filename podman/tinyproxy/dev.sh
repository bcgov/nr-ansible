docker build . -t tp
docker run --rm -p 23128:8888 --name=tp -v $(pwd)/conf/:/usr/local/etc/tinyproxy/:z tp
