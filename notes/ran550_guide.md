# Setting up and running srsRAN gNB with Benetel 550

Consult the srsRAN [docs](https://docs.srsran.com/projects/project/en/latest/tutorials/source/oranRU/source/index.html) for running the srsRAN gNB and Benetel.

## Configuration

There are three things to configure. The Falcon-RX switch, the srsRAN CU/DU, and finally the benetel RU. Additionally PTP should be run to ensure synchronization.

### Falcon-RX

To configure the switch, plug an ethernet adapter from the mgmt port on the switch directly to your PC. Then configure that interface with IP `192.168.1.1` and netmask `255.255.255.0`. Finally visit the IP `192.168.1.90` in your browser. The default username is `moose` with password `1234`.


Follow this guide exactly for how do configure VLANs and PTP. [https://docs.srsran.com/projects/project/en/latest/tutorials/source/oranRU/source/switches/falcon.html](https://docs.srsran.com/projects/project/en/latest/tutorials/source/oranRU/source/switches/falcon.html) 

Finally, connect an SFP+ cable to both your PC and the Benetel 550, fibre optic cables are recommended.

### PTP

Install PTP like so:
```bash
git clone http://git.code.sf.net/p/linuxptp/code linuxptp
cd linuxptp/
make
sudo make install
```

The ptp configuration can be found [here](https://raw.githubusercontent.com/oran-testing/ran-tester-ue/main/configs/split_7_2/ptp_default.cfg). The commands to run are as follows.
```bash
ifconfig <eth0> mtu 9600 up
./ptp4l -2 -i <eth0> -f ptp_default.cfg -m
./phc2sys -s <eth0> -w -m -R 8 -f ptp_default.cfg
```

Replace `eth0` with your desired NIC, which is connected to the switch.

Make sure the output of ptp4l is something like this:
```bash
ptp4l[329430.027]: rms   23 max   45 freq  -6911 +/-  20 delay    76 +/-   0
ptp4l[329431.153]: rms   11 max   16 freq  -6957 +/-   9 delay    75 +/-   1
ptp4l[329432.278]: rms    8 max   13 freq  -6966 +/-   4 delay    74 +/-   1
ptp4l[329433.402]: rms    4 max    6 freq  -6967 +/-   3 delay    75 +/-   0
ptp4l[329434.528]: rms    3 max    6 freq  -6958 +/-   3 delay    74 +/-   1
```

Make sure the output of phc2sys is something like this:
```bash
phc2sys[329540.023]: CLOCK_REALTIME phc offset        87 s2 freq   +2238 delay   1302
phc2sys[329540.149]: CLOCK_REALTIME phc offset        54 s2 freq   +2231 delay   1303
phc2sys[329540.274]: CLOCK_REALTIME phc offset        15 s2 freq   +2209 delay   1283
phc2sys[329540.399]: CLOCK_REALTIME phc offset        28 s2 freq   +2226 delay   1273
phc2sys[329540.524]: CLOCK_REALTIME phc offset        56 s2 freq   +2262 delay   1292
phc2sys[329540.649]: CLOCK_REALTIME phc offset        68 s2 freq   +2291 delay   1282
```


### srsRAN CU/DU

First, build the gnb:
```bash
git clone https://github.com/srsran/srsRAN_Project
cd srsRAN_Project
mkdir build && cd build
cmake ..
make -j$(nproc)
sudo make install
sudo ldconfig
```

Configuration files can be found in this [repo](https://github.com/oran-testing/ran-tester-ue/) in the folder `configs/split_7_2`. The following is an explanation of what must be changed in your unique case.

Change the following section of your yaml config:
```yaml
cells:
  - network_interface: enp8s0f0 # Use the interface name of your NIC using ifconfig
    ru_mac_addr: 70:b3:d5:e1:5c:ce  # Use the MAC address of your RU by running ifconfig in ssh
    du_mac_addr: 50:7c:6f:66:ec:28  # Use the MAC address of your NIC (ensure it is for the right port in this case 0)
    vlan_tag_cp: 2 # VLAN tags can be any value, so long as it corresponds the RU
    vlan_tag_up: 2
    prach_port_id: [4,5] # dont change these
    dl_port_id: [0,1] # dont change these
    ul_port_id: [0,1] # dont change these
```

In addition to the above changes, modify your plmn, tac, and/or band depending on what UE you will connect.


### Benetel 550

To ssh into the RU, plug it into the switch. Configure the NIC going to the switch on your PC with IP `10.0.0.0` and netmask `255.0.0.0`. Then you should be able to ping `10.10.0.100`. Then simply ssh with the following:
```bash
ssh root@10.10.0.100
```

Next secure copy the eaxc configs from `configs/split_7_2`:
```bash
scp ./configs/split_7_2/eaxc* root@10.10.0.100:/etc/
```

Then do the same for the `ru_config.cfg`:
```bash
scp ./configs/split_7_2/ru_config.cfg root@10.10.0.100:/etc/ru_config.cfg
```

Finally copy `tdd.xml`:
```bash
scp ./configs/split_7_2/tdd.xml root@10.10.0.100:/etc/
```

Edit the following lines in the script `/usr/sbin/radio_setup_a.sh` in the RU:
```bash
LOG_INFO "Set expected DU MAC Address for C-Plane Traffic (C0319/C031A)"
/usr/bin/registercontrol -w C031A -x 0x507c                      
/usr/bin/registercontrol -w C0319 -x 0x6f66ec28
                                       
LOG_INFO "Set expected DU MAC Address for U-Plane Traffic (C0315/C0316)"            
/usr/bin/registercontrol -w C0316 -x 0x507c                          
/usr/bin/registercontrol -w C0315 -x 0x6f66ec28                                         
                                                                                                                                        
LOG_INFO "Set required DU VLAN Tag Control Information for uplink U-Plane Traffic (C0318)"
/usr/bin/registercontrol -w C0318 -x 0xe002                                   
                                                                                                         
LOG_INFO "Set expected DU VLAN Tag Control Information for downlink U-Plane Traffic (C0330)"
/usr/bin/registercontrol -w C0330 -x 0x2                                 
                                                                      
LOG_INFO "Set expected DU VLAN Tag Control Information for downlink C-Plane Traffic (C0331)"
/usr/bin/registercontrol -w C0331 -x 0x2
```

Set the MAC addresses to the MAC addresses of your NIC and RU (get them using `ifconfig`).

Set the vlan tag to the hex value of whatever is in your config. In this case it is 2.

If you have followed every step of the process, your RU should be configured correctly. Run the following to ensure the radio has started:
```bash
tail -n 10 /tmp/logs/radio_status

...
[INFO] Launching o_ru_app
```


## Running

Start Open5GS:
```bash
cd srsRAN_Project/docker
sudo docker compose up --build 5gc
```

the file `open5gs/open5gs.env` and `open5gs/subscriber_db.csv` may need to be modified, depending on the UEs IMSI.

After starting PTP on the DU server, run the following:
```bash
sudo gnb -c gnb_20MHz_2x2_ran550.yml
```

If you run `kpi.sh` you should see an output like the following:
```bash
 SAMPLE_TIME          | RX_TOTAL             | RX_ON_TIME           | RX_EARLY             | RX_LATE              | RX_ON_TIME_C         | RX_EARLY_C           | RX_LATE_C            | TX_TOTAL             
 20:11:13.517307      | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   
 20:11:14.498377      | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   
 20:11:15.498895      | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   
 20:11:16.494124      | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   
 20:11:17.488109      | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   
 20:11:18.488234      | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   | -0                   
 20:11:19.487402      | 40998                | 38462                | -0                   | 4                    | 3296                 | -0                   | -0                   | -0                   
 20:11:20.489194      | 45040                | 41626                | -0                   | -0                   | 3400                 | -0                   | -0                   | -0                   
 20:11:21.485865      | 45008                | 41566                | -0                   | -0                   | 3398                 | -0                   | -0                   | -0                   
 20:11:22.499291      | 45048                | 41622                | -0                   | -0                   | 3416                 | -0                   | -0                   | -0                   
 20:11:23.529230      | 45033                | 41612                | -0                   | -0                   | 3424                 | -0                   | -0                   | -0                   
 20:11:24.498858      | 45055                | 41600                | -0                   | -0                   | 3370                 | -0                   | -0                   | -0                   
 20:11:25.489588      | 45052                | 41600                | -0                   | -0                   | 3396                 | -0                   | -0                   | -0                   
 20:11:26.489868      | 45031                | 41600                | -0                   | -0                   | 3400                 | -0                   | -0                   | -0                   
 20:11:27.489069      | 45048                | 41600                | -0                   | -0                   | 3400                 | -0                   | -0                   | -0                   
 20:11:28.488944      | 45039                | 41614                | -0                   | -0                   | 3400                 | -0                   | -0                   | -0                   
 20:11:29.500912      | 45039                | 41596                | -0                   | -0                   | 3420                 | -0                   | -0                   | -0                   
 20:11:30.494684      | 45040                | 41590                | -0                   | -0                   | 3390                 | -0                   | -0                   | -0
```
