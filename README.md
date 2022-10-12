# cp4idemoace

This repository is to be used for creating an ACE Integration Server on OCP, version 4.10.x, with IBM's Cloudpak for Integration Installed (verison 2020.2.1 or higher).

The artifacts include an Integration Server Custom resource definition and configuration objects which allow the server to connect via the supplied message flow to MQ.

The deployment relies on another repository which provides a remote default queue manager for the integration server. Please see https://github.com/peterajessup/mq-is2-qm for that queue manager's configuration.

There are two policy projects which are delivered by the supplied scripts into the overrides directory so it is possible to modify the policy zip projects to suit your own environment for an MQ Queue Manager.


For details of how the queue manager is configured see the github repo https://github.com/peterajessup/ibm-mq-custom-ivt


The source file for the barfile is also included for reference.


```
