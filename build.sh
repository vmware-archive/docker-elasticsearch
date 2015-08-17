#!/bin/sh

echo "Starting build at: $(date +%Y%m%d)"

#
cd $(dirname $0)
docker build --rm=true -t vmware-opencloud/elasticsearch .

echo "Completed build at: $(date +%Y%m%d)"
