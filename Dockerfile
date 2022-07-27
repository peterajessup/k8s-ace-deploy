# FROM cp.icr.io/cp/appc/ace-server-prod@sha256:f31b9adcfd4a77ba8c62b92c6f34985ef1f2d53e8082f628f170013eaf4c9003
FROM cp.icr.io/cp/appc/ace:12.0.5.0-r1
# Copy in the bar file  
# COPY ./ace/binary /home/aceuser/initial-config/bars
# COPY ./ace/webusers /home/aceuser/initial-config/webusers

# RUN ace_compile_bars.sh
