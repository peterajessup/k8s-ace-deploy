set +e

oc project ace

oc delete BuildConfig aceivt

oc create -f yaml/aceIVTConfig.yaml

oc start-build aceivt --wait
