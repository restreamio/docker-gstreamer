# docker-gstreamer
[![Docker Pulls](https://img.shields.io/docker/pulls/restreamio/gstreamer)](https://hub.docker.com/r/restreamio/gstreamer)

Ubuntu 22.04-based container images with upstream GStreamer and plugins pre-installed

Following components are present:
* GStreamer
* gst-plugins-base
* gst-plugins-good
* gst-plugins-bad (with `msdk`)
* gst-plugins-ugly
* gst-libav
* gstreamer-vaapi
* libnice (newer version from git)
* WPE WebKit (newer version from upstream release)

GStreamer and components are tracking upstream master branches (with minor fixes on top) and are usually updated a few times a month.
There are also builds of stable upstream releases available as well.

Base OS is Ubuntu 22.04.

NOTE:
* 1.18.2.0 images and older were based on Ubuntu 20.04 
* 2020-12-30T23-16-11Z images and older were based on Ubuntu 20.04
* 1.18.4.0 images and older were based on Ubuntu 20.10 
* 2021-06-08T14-12-58Z images and older were based on Ubuntu 20.10

## SCCache support

The sysroot includes WPEWebKit, which is a huge project and requires a good
build machine. However in case you have access to a
[SCCache](https://github.com/mozilla/sccache) scheduler online, you can use it
to build WPEWebKit:

```bash
export SCCACHE_SCHEDULER=https://sccache.corp.com
export SCCACHE_AUTH_TOKEN=s3cr3t
export WEBKIT_USE_SCCACHE=1
./build-latest.sh
```

The configuration template stored in `sccache.toml` is filled with the scheduler
address and authentication token supplied through the corresponding environment
variables.

# Builds on Docker Hub
Builds use Restream-specific patches by default, but there are also vanilla upstream builds available.

There are 4 kinds of images pushed to Docker Hub:
* restreamio/gstreamer:latest-dev-with-source - includes unoptimized build with debug symbols and even source code it was built with
* restreamio/gstreamer:latest-dev - same as above, but without source code for development purposes
* restreamio/gstreamer:latest-prod - optimized (`-O3` and `LTO`) build without debug symbols for production purposes
* restreamio/gstreamer:latest-prod-dbg - optimized (`-O2` only) build with debug symbols included for production purposes with better debugging experience

There are also above tags prefixed with build date for stable reference.

Finally, starting with `1.18.1` there are also vanilla builds using stable upstream releases with no patches applied, whose tags you can also find on Docker Hub.
Stable released have 2 tags:
* regular like `1.18.1` that is a latest build of that upstream release
* stable reference with one more number after regular `major.minor.patch` that starts with 0 and is incremented if there are multiple builds for the same upstream stable version (like `1.18.1.0`)

## Contribution
Feel free to create issues and send pull requests, they are highly appreciated!

## License
Zero-Clause BSD

https://opensource.org/licenses/0BSD

https://tldrlegal.com/license/bsd-0-clause-license
