#!/bin/bash
timestamp=$(date +%Y%m%d_%H%M%S) 
host_volume_path=`pwd`
container_volume_path=/mnt/jmeter
results_folder=${host_volume_path}/results
container_results_folder=${container_volume_path}/results/${timestamp}
mkdir -p $results_folder

echo "Specyfying mounts on container runtime"
echo "host : ${host_volume_path}"
echo "container : ${container_volume_path}"
docker run \
	--volume "${host_volume_path}":${container_volume_path} \
	jmeter -n -t ${container_volume_path}/google.jmx \
	       -l ${container_results_folder}/results.jtl \
	       -e -o ${container_results_folder}/report \
	       -j ${container_results_folder}/log.log
