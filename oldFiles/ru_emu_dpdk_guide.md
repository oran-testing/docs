# Setting up and running RU emulator with DPDK

Here are the srsRAN [docs](https://docs.srsran.com/projects/project/en/latest/tutorials/source/testmode/source/index.html) for running the emulator

## Configuration

For dpdk, I recommend running the emulator and the gNB on the same machine and the same NIC, using different ports.

### gNB

Before configuring, ensure that `igb_uio` is loaded on each port of the NIC. For more info read [this guide](./notes_on_dpdk.md)

`vlan`: tag can be any number so long as it is the same for both
`mac`: get the MAC address of each port on the NIC using lspci -vvv
`prach ports`: these can remain the same

```yaml
cells:
  - network_interface: 0000:08:00.1
    du_mac_addr: 90:e3:ba:00:12:23
    ru_mac_addr: 90:e3:ba:00:12:22
    vlan_tag_cp: 33
    vlan_tag_up: 33
    prach_port_id: [4, 5]
    dl_port_id: [0, 1, 2, 3]
    ul_port_id: [0, 1, 2, 3]
```

### RU Emulator

For the emulator keep all parameters the same, but use the PCI address of the other port

```yaml
ru_emu:
  cells:
    - bandwidth: 100 # Bandwidth of the cell
      network_interface: 0000:08:00.0
      ru_mac_addr: 90:e3:ba:00:12:22
      du_mac_addr: 90:e3:ba:00:12:23
      enable_promiscuous: false # Promiscuous mode flag
      vlan_tag: 33 # VLAN tag
      dl_port_id: [0, 1, 2, 3] # Port IDs for downlink
      ul_port_id: [0, 1, 2, 3] # Port IDs for uplink
      prach_port_id: [4, 5] # Port IDs for PRACH
      compr_method_ul: "bfp" # Compression method for uplink
      compr_bitwidth_ul: 9 # Compression bitwidth for uplink
      t2a_max_cp_dl: 470 # T2a maximum value for downlink Control-Plane
      t2a_min_cp_dl: 350 # T2a minimum value for downlink Control-Plane
      t2a_max_cp_ul: 200 # T2a maximum value for uplink Control-Plane
      t2a_min_cp_ul: 90 # T2a minimum value for uplink Control-Plane
      t2a_max_up: 345 # T2a maximum value for User-Plane
      t2a_min_up: 70 # T2a minimum value for User-Plane
```

When you run `dpdk-devbind -s` you should see the two ports with these PCI addresses listed as DPDK compatible.

Run `ls /dev/uio*` and verify that uio0 and uio1 exist.

### Testmode config

You can find the testmode config [here](https://github.com/srsran/srsRAN_Project) in the configs folder

## Running

To run the emulator use the following commands:

```bash
sudo ./ru_emulator -c emu.yaml
sudo ./apps/gnb/gnb -c gnb_ru_ran550_tdd_n78_100mhz_4x4.yml -c testmode.yml
```

This should show a trace with mostly RX_ON_TIME_C packets. To get TX_TOTAL packets run with a test ue.
