# TinyProxy Container

### Build

Build the image.

```
docker build . -t tinyproxy
```

### Run

Run the image.  Changing the default port with `-p` is recommended.

```
docker run -p 23128:8888 tinyproxy
```

### Custom Config

Optionally, use a mount to consume custom config.

```
docker run -p 23128:8888 --name=tinyproxy -v $(pwd)/conf/:/usr/local/etc/tinyproxy/:z tinyproxy
```

Note: SELinux (e.g. RedHat) requires `:z` to be addewd to volumnes.
