FROM cp.icr.io/cp/appc/ace-server-prod@sha256:8df2fc5e76aa715e2b60a57920202cd000748476558598141a736c1b0eb1f1a3

# Copy in the bar file 
COPY ./acesoe/binary /home/aceuser/initial-config/bars
# COPY ./acesoe/webusers /home/aceuser/initial-config/webusers

# RUN ace_compile_bars.sh
RUN ace_compile_bars.sh
