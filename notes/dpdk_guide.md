## What driver to use

The first thing to do when running DPDK is to check what driver works best for your use case. Here are some things to consider about the two most common:

**igb_uio**

- creates multiple device files, which can be helpful when you want two processes to access the same NIC
- works with more NICs
- is simpler to use and does not require all devices in the IOMMU group to be bound

**vfio-pci**

- generally better and faster
- used by most people
- only creates one device file
- only works with certain motherboard layouts, due to IOMMU

## Binding the driver

For uio, clone and build the repo. For vfio-pci, install the drivers and load them. Use this command to check for each

```bash
lsmod | grep uio
lsmod | grep vfio
```

Then run the following:

```bash
sudo dpdk-devbind -s
```

Then use the PCI addresses with the following

```bash
sudo dpdk-devbind -u 0000:05:00.0 0000:05:00.1
sudo dpdk-devbind -b vfio-pci 0000:05:00.0 0000:05:00.1
```

Then the correct drivers will be bound. You can use testpmd to check if the NICs are operating properly.

```bash
sudo testpmd
show port info all
```

## Running with EAL

Once the drivers are configured, move on to run the application with EAL. This involves passing the required arguments like so:

- `--lcores`: specify how many threads run on each core
- `--file-prefix`: use this if multiple processes are using DPDK on the same machine
- `-b`: block a given port. Can be useful in some circumstances
- `-a`: attach to a specific port
- `--iova`: specify IOVA mode of PA or VA. In most occasions this is not used
- `--numa`: specify to use NUMA explicitly

> [!NOTE]
> If using NUMA ensure that /sys/class/pci_bus/0000:00/device/numa_node has a valid numa node

Keep in mind that for DPDK to work there must by an SFP+ cable in the required port. Otherwise the link will be set to down.
