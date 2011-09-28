#! /bin/sh

### BEGIN TASK INFO
# Provides:		SELinuxAutorelabel
# RunBefore:            UmountImage
# RunAfter:             MountImage
# Short-Description:	Force the system to relabel at next boot
### END TAST INFO

set -e
. /usr/share/snf-image/common.sh

if [ -z "$SNF_IMAGE_TARGET" ]; then
	log_error "Target dir is missing"	
fi

if [ "$SNF_IMAGE_TYPE" != "extdump" ]; then
    exit 0
fi

distro=$(get_base_distro $SNF_IMAGE_TARGET)

if [ "$distro" = "redhat" ]; then
    # we have to force a filesystem relabeling for SELinux after messing
    # around with the filesystem in redhat derived OSs
    echo "Enforce an automatic relabeling in the initial boot process..."
    touch $SNF_IMAGE_TARGET/.autorelabel
fi

exit 0

# vim: set sta sts=4 shiftwidth=4 sw=4 et ai :