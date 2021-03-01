FROM cp.icr.io/cp/appc/ace-server-prod@sha256:8598eef24c097e467bfa33499e62fe0dcfbfd817d877bd2347c857870b47b8fa

# Copy in the bar file 
COPY ./ace/binary /home/aceuser/initial-config/bars
# COPY ./ace/webusers /home/aceuser/initial-config/webusers

RUN ace_compile_bars.sh
