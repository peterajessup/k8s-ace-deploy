FROM cp.icr.io/cp/appc/ace-server-prod@sha256:bdeb8b839be9e095bf3c74be8b9f02f54cf6c0a740b8f45f93d01265549d9e83

# Copy in the bar file 
COPY ./ace/binary/ivtk.bar /home/aceuser/initial-config/bars
# COPY ./ace/webusers /home/aceuser/initial-config/webusers

RUN ace_compile_bars.sh
