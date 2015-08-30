# docker-elasticsearch

Builds a docker image for running elasticsearch in container.

## Requirements

A working Docker setup and a valid shell (e.g., bash).

To join an existing cluster, run a registrator container beside this container
and pass in the SERVICENAME="elasticsearch-9300.service.consul" or similar for
the elastic search service pool.

## Getting Started
Build the container and run it.

```
./build.sh
docker run -d vmware-opencloud/elasticsearch
```

By default, we join any running containers in elasticsearch-9300.service.consul
running with CLUSTERNAME="default&#95;clustername".  We use DNS SRV records
to identify the nodes in the cluster to join. Set SERVICENAME environment variable
to a SVR record, or to the consul service name for the pool, which is the same thing.

The first container up will be registered with consul via the registrator
container.  The second one up will query consul for members of
elasticsearch-9300.service.consul (or SERVICENAME if specified) and
attempt to join with them.

Use env LOGLEVEL=(INFO|DEBUG|...) to alter logging.

## Example

```
docker run -d gliderlabs/registrator:master
docker run -d vmware-opencloud/elasticsearch

curl -s 'http://127.0.0.1:9200/_cat/nodes?h=ip,port,heapPercent,name'
curl -s 'http://127.0.0.1:9200/_cluster/health?pretty=true'
# you'll see info about the running node once it is ready

sleep 10 # or a bit until the first one comes up
docker run -d vmware-opencloud/elasticsearch

curl -s 'http://127.0.0.1:9200/_cat/nodes?h=ip,port,heapPercent,name'
curl -s 'http://127.0.0.1:9200/_cluster/health?pretty=true'
# you should now see the second node in the cluster

```

# License and Copyright
 
Copyright 2015 VMware, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Author Information

This role was created in 2015 by [Tom Scanlan / VMware](http://www.vmware.com/).
