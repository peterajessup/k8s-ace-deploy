
bash -x createConfig.sh serverconf httpsconf config/server.conf.yaml
bash -x createConfig.sh keystore key.jks config/key.jks



/var/jenkins_home/kubectl apply -f yaml/aceIVTDeploy.yaml -n ace
/var/jenkins_home/kubectl apply -f yaml/isivt-ingress.yaml -n ace
/var/jenkins_home/kubectl apply -f yaml/isivt-admin.yaml -n ace
/var/jenkins_home/kubectl set env deployment/ivtis-is MQSI_OVERRIDE_HOSTNAME=ace-ivtis.upstream-1-25-6-643d6b687ab93581d24420becac24aae-0000.au-syd.containers.appdomain.cloud MQSI_OVERRIDE_HTTPS_PORT=443 -n ace 

