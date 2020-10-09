# cp4idemoace

This repository is to be used for creating an ACE Integration Server on OCP, version 4.4.x, with IBM's Cloudpak for Integration Installed (verison 2020.2.1 or higher).

The artifacts include a BuildConfig, an Integration Server Custom resource definition, a Dockerfile for the image build, configuration objects which allow the server to connect via the supplied message flow into EventStreams and MQ.

There are two policy projects which are delivered by the supplied scripts into the overrides directory so it is possible to modify the supplied zip projects to suit your own environment for an MQ Queue Manager and an Event Streams Cluster.

There are some hard dependancies on the external components, such as a queue called IVT.Q, and a Event Streams topic called ivt1. 

For details of how the queue manager is configured see the github repo https://github.com/peterajessup/ibm-mq-custom-ivt

The configuration assumes an ImageStream object named demoace exists on the cluster, in the ace namespace, and the docker secret for the image repository of the cluster is also specific to the cluster used for deployment of the Integration Server (hint: modify the aceIVTDeploy.yaml).

A sample script for the full deployment is as follows:
Note the script is written to ignore deletion errors of objects on the target cluster in case they don't exist. This permits 
a build script in, say Jenkins, to be based on this supplied script.
```

set +e
oc delete BuildConfig aceivt
set -e
oc create -f yaml/aceIVTConfig.yaml

# refresh ace configurations 
set +e
oc delete Configuration key.jks
oc delete Configuration es-cert-ace.p12
oc delete Configuration scramparms
oc delete Configuration kafkapolicy
oc delete Configuration httpsconf
oc delete Configuration mqpolicy
set -e
set tw=0

bash -x createConfig.sh serverconf httpsconf config/server.conf.yaml
bash -x createConfig.sh keystore key.jks config/key.jks
bash -x createConfig.sh truststore es-cert-ace.p12 config/es-cert-ace.p12
bash -x createConfig.sh  setdbparms scramparms config/setdbparms.txt
bash -x createConfig.sh policyproject kafkapolicy config/eventstreamspolicyproject.zip
bash -x createConfig.sh policyproject mqpolicy config/MQPolicy.zip


oc start-build aceivt

 # delete the existing deployment and re-deploy
set +e
oc delete IntegrationServer is2
set -e
oc apply -f yaml/aceIVTDeploy.yaml
```
