# Configuration Reference

The following is a complete list of all optional and required configuration parameters for the system configuration file. By default, the file to edit is ``spec.yaml``.

```yaml
   enable_cli: true # OPTIONAL: should the controller look for commands from a TTY, default: false

   external_targets:           # OPTIONAL: list of external machines for running certain components
     - name: "sni5gect_runner" # REQUIRED: name of the external target
       token: "testing_token"  # REQUIRED: token to supply to the control API of the runner
       host: "192.168.0.10"    # REQUIRED: IP of the target machine
       port: 1343              # REQUIRED: Port of the control API running on the target

   build_spec:                                       # OPTIONAL: list of components to build before starting the test
     - component: "sni5gect"                         # REQUIRED: the module name of the component
       docker_image: "ghcr.io/oran-testing/sni5gect" # REQUIRED: the image name of the component (should match registry)
       pull: false                                   # OPTIONAL: should the docker image be pulled from the registry, default: true

   autorun: false # OPTIONAL: start all components in run_spec automatically, default: true

   run_spec:                                     # OPTIONAL: list of components to configure
     - component: "rtue"                         # REQUIRED: the name of the component module to run
       name: "rtue_uhd_1"                        # REQUIRED: the name to give the component once started
       config_file: "configs/srsran/ue_uhd.conf" # OPTIONAL: the config file to pass to the component
       rf:                                       # REQUIRED: configuration of the RF frontend to use
         type: "b200"                            # REQUIRED: type of RF driver, allowed: ['b200', 'zmq']
               gateway: ""                       # REQUIRED (zmq): the ZMQ gateway IP for routing traffic
               tcp_subnet: ""                    # REQUIRED (zmq): the subnet to use for ZMQ transmission

   api_auth:                      # OPTIONAL: list of API scopes for other machines on the network
     - name: "swarm_master_token" # REQUIRED: name of the auth scope
       token: "testing_token"     # REQUIRED: token value expected for requests
       scopes:                    # REQUIRED: list of endpoints to allow access to
         - list
         - logs
         - get
         - healthcheck
         - start
       allowed_components:        # REQUIRED: list of components to allow access to
         - sni5gect
         - rtue
         - jammer
         - ssb-spoofer
       pass_to:                   # OPTIONAL: list of component IDs which should be given the token
         - sni5gect_uhd_1

   external_influx:                                                            # OPTIONAL: Triggers the system to use influx database on another machine
     token: "605bc59413b7d5457d181ccf20f9fda15693f81b068d70396cc183081b264f3b" # REQUIRED: influxDB token
     org: "rtu"                                                                # REQUIRED: influxDB org
     bucket: "rtusystem"                                                       # REQUIRED: influxDB bucket to write to
     port: 8086                                                                # REQUIRED: influxDB port on target machine
     host: "192.168.0.9"                                                       # REQUIRED: IP of target machine
```
