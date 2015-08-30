#!/bin/sh
#
#  Copyright 2015 VMware, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

ELASTIC_ROOT=/usr/share/elasticsearch

if [ -z "${CLUSTERNAME}" ]; then
	CLUSTERNAME="default_clustername"
fi
if [ -z "${BINDHOST}" ]; then
	BINDHOST=0.0.0.0
fi
if [ -z "${PUBLISHHOST}" ]; then
	PUBLISHHOST=0.0.0.0
fi
if [ -z "${SERVICENAME}" ]; then
	SERVICENAME="elasticsearch-9300.service.consul"
fi
if [ -z "${LOGLEVEL}" ]; then
	LOGLEVEL="INFO"
fi

hosts=`dig $SERVICENAME SRV | awk "/^$SERVICENAME/ {print \\$8\":\"\\$7}" | sed 's/.:/:/g;' | sed ':a;N;$!ba;s/\n/,/g;'`; echo $hosts

exec /docker-entrypoint.sh elasticsearch \
  -Des.cluster.name=$CLUSTERNAME \
  -Des.discovery.zen.ping.unicast.hosts=$hosts \
  -Des.network.publish_host=$PUBLISHHOST \
  -Des.discovery.zen.ping.multicast.enabled=false \
  -Des.logger.level=$LOGLEVEL \
  "$@"
