
bash -x createConfig.sh serverconf httpsconf config/server.conf.yaml
bash -x createConfig.sh keystore key.jks config/key.jks



kubectl apply -f yaml/aceIVTDeploy.yaml -n ace
kubectl apply -f yaml/isivt-ingress.yaml -n ace
