# Quickstart

## Machine and OS Recommendations

The RAN Tester UE is tested on `Ubuntu 24.04`. However, any Linux distro or macOS machine should be able to run the software with few issues. If problems occur on these platforms, feel free to open an issue.

```{tip}
We recommend using the Ubuntu real-time kernel, available from Canonical. Alternatively, you can use the low-latency kernel, which is free.

A powerful machine is recommended, as many attacks are resource-intensive.
```

## Required Dependencies

Install the following on your system before running the software:

- Docker Engine
-   Docker Compose
-   UHD utilities (for downloading firmware images)

## Running a Test

1. First, clone the core repository:

```bash
git clone https://github.com/oran-testing/ran-tester-ue.git
```

2. Navigate to the directory and run the system setup script:

```bash
cd ran-tester-ue
./scripts/system_setup.sh
```

3. Next, pull the system containers from our registry:

```bash
sudo docker compose pull  # Grafana, InfluxDB, and Controller
```

Alternatively, you can build the images yourself:

```bash
sudo docker compose build
```

4. Finally, modify the configuration to run a test:

The test specification is defined in the YAML config file `ran-tester-ue/spec.yaml`.
This configuration tells the controller which services to run and in what order, enabling fully automated tests with multiple components.

```yaml
enable_cli: true

build_spec:
  - component: "sni5gect"
    docker_image: "ghcr.io/oran-testing/sni5gect"
    pull: false

run_spec:
  - component: "rtue"
    name: "rtue_uhd_1"
    config_file: "configs/srsran/ue_uhd.conf"
    rf:
      type: "b200"
  - component: "sni5gect"
    name: "downlink_sniffer"
    config_file: "configs/sni5gect/srsgnb_band3.yaml"
    rf:
      type: "b200"
```

The above configuration will run a sni5gect sniffer and UE with the requested environment, writing all data to InfluxDB and displaying metrics in real-time with Grafana.

5. To start the system, run:

```bash
sudo docker compose up
```

The Grafana dashboard can be accessed at <http://localhost:3300>.
