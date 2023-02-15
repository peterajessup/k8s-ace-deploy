
bash -x createConfig.sh serverconf httpsconf config/server.conf.yaml
bash -x createConfig.sh keystore key.jks config/key.jks



/var/jenkins_home/kubectl apply -f yaml/aceIVTDeploy.yaml -n ace
/var/jenkins_home/kubectl apply -f yaml/isivt-ingress.yaml -n ace
