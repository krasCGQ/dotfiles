# Normally, apps jailed using firejail must preload hardened_malloc using rules defined in
# globals.local. However, some apps are known to have issues with the default variant but otherwise
# works as normal (or near-normal) with the light variant.
#
# This file can be inherited within the profile of affected apps to instead preload light variant of
# hardened_malloc to at least still offer some sort of security.

# Ignore and blacklist the default variant
ignore env LD_PRELOAD=/$LIB/libhardened_malloc.so
blacklist-nolog /usr/lib/libhardened_malloc.so

# Make it so we preload the light variant
env LD_PRELOAD=/$LIB/libhardened_malloc-light.so
