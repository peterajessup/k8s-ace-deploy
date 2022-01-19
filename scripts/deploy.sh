oc project ace

oc delete Configuration key.jks
oc delete Configuration es-cert-ace.jks
oc delete Configuration scramparms
oc delete Configuration kafkapolicy
oc delete Configuration httpsconf
oc delete Configuration mqpolicy

set -e

bash -x createConfig.sh serverconf httpsconf config/server.conf.yaml
bash -x createConfig.sh keystore key.jks config/key.jks
bash -x createConfig.sh truststore es-cert-ace.jks config/es-cert-ace.jks
bash -x createConfig.sh setdbparms scramparms config/setdbparms.txt
bash -x createConfig.sh policyproject kafkapolicy config/eventstreamspolicyproject.zip
bash -x createConfig.sh policyproject mqpolicy config/MQPolicy.zip

oc apply -f yaml/aceIVTDeploy.yaml
