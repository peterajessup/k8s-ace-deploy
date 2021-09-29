FROM cp.icr.io/cp/appc/ace-server-prod@sha256:eed0750a788047982b3f7ddcf6f6762d46e6c54aca3098dff8ddd25197bcebbc

# Copy in the bar file  
COPY ./ace/binary /home/aceuser/initial-config/bars
# COPY ./ace/webusers /home/aceuser/initial-config/webusers

RUN ace_compile_bars.sh
