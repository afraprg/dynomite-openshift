
# Dynomite With Openshift

As you might know Master-Master replication is only available for Redis labs enterprise version of Redis, however for doing master-master replication in open source redis cluster we can use Dynomite which is a tool created by Netflix.

# Introduction

This repository is created for having a Redis Master-Master with using Dynomite, also in this repository you have a redis-exporter for the monitor in Grafana.

# Configuration

we have two files in the openshift.yaml > ConfigMap (redis_node1.yml, redis_node2.yml) you should change this config based on your requirement and you can get help from [the main Dynomite repository](https://github.com/Netflix/dynomite/tree/dev/conf), also you have to create a key file with this command and put file paths to configMap

    openssl req -x509 -newkey rsa:4096 -keyout dynomite.pem -out cert.pem -days 10000 -nodes

# Running

Finally, you can deploy the project with these commands, also you need to change these variables (SECOND_DATACENTER_IP,SECOND_DATACENTER_TOKEN, FIRST_DATACENTER_IP,FIRST_DATACENTER_TOKEN,DYNOMITE_CONFIG_FILE,EXTERNAL_IP) and put real values


    oc process -f openshift.yaml --param SERVICE_NAME=dynomite --param SECOND_DATACENTER_IP=your_ip --param SECOND_DATACENTER_TOKEN=your_token --param FIRST_DATACENTER_IP=your_ip --param FIRST_DATACENTER_TOKEN=your_token --param DYNOMITE_CONFIG_FILE=your_config_map_file EXTERNAL_IP=your_external_ip | oc apply -f -
    
    oc rollout latest dc/dynomite || oc rollout status dc/dynomite
