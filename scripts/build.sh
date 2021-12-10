set +e

oc project ace


oc delete BuildConfig aceivt

oc create -f yaml/aceIVTConfig.yaml


oc delete Configuration key.jks
oc delete Configuration es-cert-ace.p12
oc delete Configuration scramparms
oc delete Configuration kafkapolicy
oc delete Configuration httpsconf
oc delete Configuration mqpolicy

set -e

bash -x createConfig.sh serverconf httpsconf config/server.conf.yaml
bash -x createConfig.sh keystore key.jks config/key.jks
bash -x createConfig.sh truststore es-cert-ace.p12 config/es-cert-ace.p12
bash -x createConfig.sh setdbparms scramparms config/setdbparms.txt
bash -x createConfig.sh policyproject kafkapolicy config/eventstreamspolicyproject.zip
bash -x createConfig.sh policyproject mqpolicy config/MQPolicy.zip


oc start-build aceivt --wait
