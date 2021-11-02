# TinyProxy Container

### View logs

View the logs for a currently running container.

```
podman logs tinyproxy
```

Tail the logs:

```
podman logs -f tinyproxy
```

### Restart

Restart a container (eg after updating configuration file(s))

```
podman restart tinyproxy
```

### Run Custom Config (typical use)

Run with custom config, mounted in a volume.  The -v command is copying the contents of the conf directory into the container, before tinyproxy starts.
TODO: Address networking so tinyproxy is able to apply IP filtering for incoming requests.

```
podman run --name=tinyproxy -p 23128:8888 -v $(pwd)/conf/:/usr/local/etc/tinyproxy/:z tinyproxy
```

Note: SELinux distros (e.g. Red Hat, CentOS, Fedora) require `:z` for all volumes.

### Build

Build and tag an image.  As supplied, the command is to be run in the directory where the Dockerfile exists:

```
podman build . -t tinyproxy
```

### Stop

Stop a container, due to change(s) that require new container.

```
podman stop tinyproxy
```

### Start

Start an existing container.

```
podman start tinyproxy
```

### Run

Run a container.  Change the default port with `-p`.

```
podman run --name=tinyproxy -p 23128:8888 tinyproxy
```