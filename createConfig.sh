set tw=0
crtype=$1
crname=$2
crfile=$3
echo "apiVersion: appconnect.ibm.com/v1beta1" > oc.dat
echo "kind: Configuration" >> oc.dat
echo "metadata:" >> oc.dat
echo "  name: ${crname}" >> oc.dat
echo "spec:" >> oc.dat
(echo -n "  contents: "; base64 ${crfile}) | cut -c-$(tput cols)  >> oc.dat
echo "  type: ${crtype}" >> oc.dat
echo "---" >> oc.dat 
oc apply -f ./oc.dat

