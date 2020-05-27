# docker-gstreamer
Ubuntu 20.04-based container images with upstream GStreamer and plugins pre-installed

Following components are present:
* GStreamer
* gst-plugins-base
* gst-plugins-good
* gst-plugins-bad
* gst-plugins-ugly
* gst-libav
* libnice (newer version from git)
* libusrsctp (newer version from git)

GStreamer and components are tracking upstream master branches (sometimes with minor patches) and are usually updated a few times a month.
There is a chance that after 1.18 release there will be additional builds against stable releases as well, we'll see.

Base OS is Ubuntu 20.04 LTS.

There are 4 images pushed to Docker Hub:
* restreamio/gstreamer:latest-dev-with-source - includes unoptimized build with debug symbols and even source code it was built with
* restreamio/gstreamer:latest-dev - same as above, but without source code for development purposes
* restreamio/gstreamer:latest-prod - optimized (`-O3` and `LTO`) build without debug symbols for production purposes
* restreamio/gstreamer:latest-prod-dbg - optimized (`-O2` only) build with debug symbols included for production purposes with better debugging experience

There are also above tags prefixed with build date for stable reference.

## Contribution
Feel free to create issues and send pull requests, they are highly appreciated!

## License
Zero-Clause BSD

https://opensource.org/licenses/0BSD

https://tldrlegal.com/license/bsd-0-clause-license
