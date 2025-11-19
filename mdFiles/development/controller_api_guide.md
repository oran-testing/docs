# RAN Tester UE Controller API Guide

## Controller API Overview

The Controller API enables the creation and monitoring of custom Docker
containers. A **worker thread**, started by the controller's main
process, manages one Docker container containing desired software. This
thread implements specific methods expected by the controller.

## Worker Thread Methods

### \_\_init__() Method

**Parameters:**

-   **influxdb_client**: Instance of InfluxDBClient class
    for writing data to InfluxDB
-   **docker_client**: Instance of DockerClient class for
    managing Docker containers

**Tasks:**

-   Store parameters for later use

### start() Method

**Parameters:**

-   **config** (default: \"\"): Path to the config file
    for containerized software (if any)
-   **args** (default: \[ \]): List of arguments passed to
    the containerized software on startup (if any)

**Tasks:**

-   Start the software in a Docker container
-   Launch a thread to collect and send data

### stop() Method

**Tasks:**

-   Stop and destroy the Docker container
-   Cleanup threads and resources
