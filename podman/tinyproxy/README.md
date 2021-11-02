# TinyProxy Container

### Build

Build and tag an image.

```
docker build . -t tinyproxy
```

### Run

Run a container.  Change the default port with `-p`.

```
docker run --name=tinyproxy -p 23128:8888 tinyproxy
```

### Custom Config

Run with custom config mounted in a volume.

```
docker run --name=tinyproxy -p 23128:8888 -v $(pwd)/conf/:/usr/local/etc/tinyproxy/:z tinyproxy
```

Note: SELinux distros (e.g. Red Hat, CentOS, Fedora) require `:z` for all volumnes.
