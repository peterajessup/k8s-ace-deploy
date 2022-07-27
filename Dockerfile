# FROM cp.icr.io/cp/appc/ace-server-prod@sha256:f31b9adcfd4a77ba8c62b92c6f34985ef1f2d53e8082f628f170013eaf4c9003
FROM cp.icr.io/cp/appc/ace-server-prod@sha256:7eb8483de45c1634d09e24521b9d2f89a9e4d0c9b89a1a5d52cc4fd37a091234
# Copy in the bar file  
COPY ./ace/binary /home/aceuser/initial-config/bars
# COPY ./ace/webusers /home/aceuser/initial-config/webusers

# RUN ace_compile_bars.sh
