#!/bin/bash
set -e -o pipefail
read -ra arr <<< "$@"
version=${arr[1]}
trap 0 1 2 ERR
# Ensure sudo is installed
apt-get update && apt-get install sudo -y
current_dir="$PWD"
bash /tmp/linux-on-ibm-z-scripts/PostgreSQL/${version}/build_postgresql.sh -y
cd /usr/local/pgsql/ && tar cvfz postgresql-${version}-linux-s390x.tar.gz *
mv postgresql-18-${version}-linux-s390x.tar.gz ${current_dir}
exit 0
