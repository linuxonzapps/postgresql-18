#!/bin/bash
set -e -o pipefail
read -ra arr <<< "$@"
version=${arr[1]}
trap 0 1 2 ERR
# Ensure sudo is installed
current_dir="$PWD"
sed -E -i '/sudo useradd|sudo passwd/d' /tmp/linux-on-ibm-z-scripts/PostgreSQL/${version}/build_postgresql.sh
bash /tmp/linux-on-ibm-z-scripts/PostgreSQL/${version}/build_postgresql.sh -y
cd $PWD/postgresql-${version}/tmp_install/ && tar cvfz postgresql-${version}-linux-s390x.tar.gz initdb-template usr
mv postgresql-${version}-linux-s390x.tar.gz ${current_dir}
exit 0
