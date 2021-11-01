docker build . -t tp
docker run -p 23128:8888 --name=tp -v $(pwd)/conf/:/usr/local/etc/:z tp
docker rm -fv tp
