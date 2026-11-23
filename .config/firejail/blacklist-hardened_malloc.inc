#
# Include this file for app profiles where using hardened_malloc will break app functionality
# or crash it immediately, because the allocator trips or of something else where the root cause
# might not be obvious outright.
#
# Apps with bundled jemalloc like all versions and forks of Firefox (including Thunderbird), as
# well as rustc are known to be incompatible with hardened_malloc.
#
# Glycin set RLIMIT_AS to limit memory usage on its sandboxed process, which conflicts with the way
# hardened_malloc works and kills the sandbox instead. A method making use of systemd and cgroups
# to achieve similar goal is currently a work-in-progress.
#
# Related GitHub issues:
# Firefox: https://github.com/GrapheneOS/hardened_malloc/issues/123
# Glycin: https://gitlab.gnome.org/GNOME/glycin/-/work_items/209
# rustc: https://github.com/rust-lang/rust/issues/107410 (a wontfix)
#

# This is defined in globals.local
ignore env LD_PRELOAD=/$LIB/libhardened_malloc.so

# Just in case preloading is still attempted
rmenv LD_PRELOAD

# We should be okay with just blacklisting the libraries outright
blacklist-nolog /usr/lib/libhardened_malloc.so
blacklist-nolog /usr/lib/libhardened_malloc-desktop.so
blacklist-nolog /usr/lib/libhardened_malloc-light.so
