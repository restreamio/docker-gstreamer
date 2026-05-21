# docker-gstreamer
[![Docker Pulls](https://img.shields.io/docker/pulls/restreamio/gstreamer)](https://hub.docker.com/r/restreamio/gstreamer)

Ubuntu 26.04-LTS-based container images with upstream GStreamer and plugins pre-installed

Following components are present:
* GStreamer
* gst-plugins-base
* gst-plugins-good
* gst-plugins-bad (with `msdk`)
* gst-plugins-ugly
* gst-libav
* gstreamer-va
* libnice
* gstcefsrc

GStreamer and components are tracking upstream master branches (with minor fixes on top) and are usually updated a few times a month.
There are also builds of stable upstream releases available as well.

Base OS is Ubuntu 26.04 LTS

NOTE:
* 1.18.2.0 images and older were based on Ubuntu 20.04 
* 2020-12-30T23-16-11Z images and older were based on Ubuntu 20.04
* 1.18.4.0 images and older were based on Ubuntu 20.10 
* 2021-06-08T14-12-58Z images and older were based on Ubuntu 20.10
* 2026-05-07T12-07-24Z images and older were based on Ubuntu 22.04

# Builds on Docker Hub
Builds use Restream-specific patches by default, but there are also vanilla upstream builds available.

There are 4 kinds of images pushed to Docker Hub:
* restreamio/gstreamer:x86_64-latest-dev-with-source - includes unoptimized build with debug symbols and even source code it was built with
* restreamio/gstreamer:x86_64-latest-dev - same as above, but without source code for development purposes
* restreamio/gstreamer:x86_64-latest-prod - optimized (`-O3` and `LTO`) build without debug symbols for production purposes
* restreamio/gstreamer:x86_64-latest-prod-dbg - optimized (`-O2` only) build with debug symbols included for production purposes with better debugging experience

For Linux/ARM64 builds, replace `x86_64` with `aarch64` in the Docker tags. For
further convenience, multi-arch images aggregating both builds are available as
well, just remove the `$ARCH-` prefix from docker labels.

There are also above tags prefixed with build date for stable reference.

Finally, starting with `1.18.1` there are also vanilla builds using stable upstream releases with no patches applied, whose tags you can also find on Docker Hub.
Stable released have 2 tags:
* regular like `1.18.1` that is a latest build of that upstream release
* stable reference with one more number after regular `major.minor.patch` that starts with 0 and is incremented if there are multiple builds for the same upstream stable version (like `1.18.1.0`)

## Chromium MemoryInfra SIGILL workaround

glibc's deprecated `mallinfo()` returns `int` fields that overflow once heap addresses exceed 2 GiB. Chromium's MemoryInfra collector still calls it and crashes with SIGILL as soon as a long-running CEF process grows its heap past that threshold. See [chromiumembedded/cef#3963](https://github.com/chromiumembedded/cef/issues/3963).

Image bundles `/usr/lib/libfakemallinfo.so`, a tiny shared library that overrides `mallinfo()` with a stub returning a zeroed `struct mallinfo`. Preload it via `LD_PRELOAD` when starting your binary. In a Dockerfile:

```dockerfile
ENV LD_PRELOAD=/usr/lib/libfakemallinfo.so
```

The shim is a no-op for callers that don't use `mallinfo()`, so it's safe to leave preloaded for the whole process tree.

## Contribution
Feel free to create issues and send pull requests, they are highly appreciated!

## License
Zero-Clause BSD

https://opensource.org/licenses/0BSD

https://tldrlegal.com/license/bsd-0-clause-license
