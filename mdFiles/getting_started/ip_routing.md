# IP Routing Configuration

## Prerequisites

IP routing configuration and testing require **iperf3**. Please install it beforehand:

**Ubuntu/Debian:**

```bash
sudo apt install iperf3
```

**Fedora/CentOS/RHEL:**

```bash
sudo dnf install iperf3
```

## gNB Machine Setup

1.  Add downlink route to UE network:

    ```bash
    sudo ip route add 10.45.0.0/16 via 10.53.1.2
    ping 10.45.1.2  # Verify downlink connection
    ```

```{important}
For single-machine ZMQ setups, prepend all UE network commands with
`ip netns exec ue1`.
```


## UE Container Configuration

1.  First, get the container ID and access the container bash:

    ```bash
    sudo docker ps
    sudo docker exec -it <container_id> bash
    ```

2.  Inside the container, identify TUN interface IP:

    ```bash
    ip a show tun_rtue | grep 'inet'
    ```

3.  Establish uplink routing:

    ```bash
    ip route add 10.53.0.0/16 via <tun_rtue_ip> dev tun_rtue
    ping 10.53.1.1  # Validate uplink connection
    ```

## iPerf3 Performance Testing

1.  Server side (gNB):

    ```bash
    iperf3 -s -i 1 -p <port_number>
    ```

2.  Client side (UE Container):

    ```bash
    # TCP
    iperf3 -c 10.53.1.1 -i 1 -t 60 -p <port_number>
    # UDP
    iperf3 -c 10.53.1.1 -i 1 -t 60 -u -b 10M -p <port_number>
    ```
