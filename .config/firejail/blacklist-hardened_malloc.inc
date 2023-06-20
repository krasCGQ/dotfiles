# Include this file for application profiles where using hardened_malloc (both default and light)
# will break app functionality or crash immediately, due to allocator tripping or something else
# which we might not immediately know the root cause.
#
# Apps with bundled jemalloc like all versions and forks of Firefox (including Thunderbird), as
# well as rustc are known to be incompatible with hardened_malloc.
#
# Related GitHub issues:
# Firefox: https://github.com/GrapheneOS/hardened_malloc/issues/123
# rustc: https://github.com/rust-lang/rust/issues/107410 (a wontfix)
#
# Starting from Mesa 23.1, some DRI drivers might be incompatible with hardened_malloc, but can be
# workarounded by attempting to preload an invalid library, launch desired application that loads a
# Mesa DRI driver and close it afterwards, then switch to preload the correct library.

# This is defined in globals.local
ignore env LD_PRELOAD=/$LIB/libhardened_malloc.so

# Just in case preloading is still attempted
rmenv LD_PRELOAD

# We should be okay with just blacklisting the libraries outright
blacklist-nolog /usr/lib/libhardened_malloc.so
blacklist-nolog /usr/lib/libhardened_malloc-light.so
