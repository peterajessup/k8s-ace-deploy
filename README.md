# cp4idemoace

This repository is to be used for creating an ACE Integration Server on OCP, version 4.4.x, with IBM's Cloudpak for Integration Installed (verison 2020.2.1 or higher).

The artifacts include a BuildConfig, an Integration Server Custom resource definition, a Dockerfile for the image build, and configuration objects which allow the server to connect via the supplied message flow into EventStreams and MQ.

There are two policy projects which are delivered by the supplied scripts into the overrides directory so it is possible to modify the policy zip projects to suit your own environment for an MQ Queue Manager and an Event Streams cluster.

There are some hard dependancies on the external components, such as an MQ queue called IVT.Q running in an mq deployemnt called 'mq1', and a Event Streams topic called ivt1. 

For details of how the queue manager is configured see the github repo https://github.com/peterajessup/ibm-mq-custom-ivt

Note that the es-cert-ace-.p12 file will need to be replaced with the one supplied by the Event Streams instance to which you wish to connect. Make sure the name of the p12 cert matches the name of the configuration object you create.

Also note the eventstreampolicyproject zip will need to be uncompressed, and the eventstreamspolicy.policyxml modified to refelct your Event Streams cluster's bootsrapserver address, and the name of the certificate from the event Streams instance (usually es-cert.p12). You will then re-compress this file and update the git repo.

The setdbparms truststore entry file will also need to be modified with the password for this same cert file, and the kafka::myKafkaId entry changed to reflect the scram unsername and password.

To retrieve the configuration paramters from your event Streams instance and configure it ready for the ace flow:

•	Navigate to the Event Streams instance home page
•	Click on the Create a topic page and enter the topic name ivt1
•	Click on Next 3 times and then Create topic to finalise the configuration
•	Click on the Home button  , then on the Connect to this Cluster tile
•	Copy the External connection string and save away  

•	Click on the Generate Scram credentials, give the credentials a name and click Next 4 times. Save the Scram username and password away.

•	Locate the PKCS12 certificate and click Download the Certificate, then save it.

•	Take note of the certificate password and save this away


The configuration assumes an ImageStream object named 'demoace' exists on the cluster, in the ace namespace, and the docker secret for the image repository of the cluster is also specific to the cluster used for deployment of the Integration Server (hint: modify the aceIVTDeploy.yaml to add your own docker image pull secret).
The source file for the barfile is also included for reference.


A sample script for the full deployment is as follows:
Note the script is written to ignore deletion errors of objects on the target cluster in case they don't exist. This permits 
a build script in, say Jenkins, to be based on this supplied script.
```

oc project ace
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
