// LD_PRELOAD shim that replaces glibc's deprecated mallinfo() with a stub
// returning a zeroed struct. Works around a Chromium bug where MemoryInfra
// crashes with SIGILL once heap addresses exceed 2 GiB, because mallinfo()'s
// int fields overflow.
// @see https://github.com/chromiumembedded/cef/issues/3963

#include <malloc.h>

struct mallinfo mallinfo(void) {
    struct mallinfo m = {0};
    return m;
}
