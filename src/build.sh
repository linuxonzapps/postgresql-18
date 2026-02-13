#!/bin/bash
set -e -o pipefail
read -ra arr <<< "$@"
version=${arr[1]}
trap 0 1 2 ERR
# Ensure sudo is installed
apt-get update && apt-get install sudo -y
# Extract DISTRO details for tagging
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO="$ID-$VERSION_ID"
    if [ "$VERSION_CODENAME" != "" ]; then
        DISTRO="$ID-$VERSION_CODENAME"
    fi
fi
current_dir="$PWD"
echo $DISTRO > .distro_zab.txt
bash /tmp/linux-on-ibm-z-scripts/PostgreSQL/${version}/build_postgresql.sh -y
cd /usr/local/pgsql/ && tar cvfz postgresql-${version}-linux-s390x.tar.gz *
mv postgresql-${version}-linux-s390x.tar.gz ${current_dir}
exit 0
