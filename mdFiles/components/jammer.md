# Jamming Attack

## Introduction

Jamming is the intentional disruption of a wireless signal by
transmitting a strong interference on the same frequency, blocking or
degrading the intended communication. The primary jamming methods are:

1.  Spot Jamming (implemented in this system)
2.  Sweep Jamming
3.  Barrage Jamming
4.  Deceptive Jamming

**Spot jamming** is a type of noise jamming where a jammer concentrates
its power on a single frequency, aiming to disrupt communication or
radar systems operating on that specific frequency.

## Configuration

**Controller Configuration:** Add the following to the
[processes]{.title-ref} list in the controller configuration located at
`ran-tester-ue/configs/default.yaml`:

``` yaml
processes:
 - type: "jammer"
   id: "jammer_1"
   config_file: "configs/basic_jammer.yaml"
   rf:
      type: "b200"
      images_dir: "/usr/share/uhd/images/"
```

**Jammer Configuration:** The jammer configuration file is located at
`ran-tester-ue/jammer/configs/basic_jammer.yaml`. Refer to the parameter
reference for details:

``` yaml
parameter: default_value        # Parameter description
```

```yaml
amplitude: 0.7                  # specifies the amplitude of the sinusoidal wave being generated
amplitude_width: 0.05           # specifies the upper and lower limit of the amplitude range for random sampling
center_frequency: 1.842e9       # sets the central frequency of the wave
bandwidth: 80e6                 # specifies the frequency bandwidth around the central frequency for random sampling and jamming
initial_phase: 0                # sets the initial angle for the sinusoidal wave
sampling_freq: 40e6             # specifies how many samples are generated per second
num_samples: 20000              # sets the number of IQ samples to generate from the sinusoidal wave
output_iq_file: "output.fc32"   # specifies the name of the IQ file for outputting IQ values
output_csv_file: "output.csv"   # specifies the name of the CSV file for plotting IQ values
write_iq: false                 # enables or disables writing IQ values to a file
write_csv: true                 # enables or disables writing IQ values to a CSV file
device_args: "type=b200"        # specifies the type of USRP device used for jamming     
tx_gain: 70                     # sets the transmitter power level
```

## Attack Metrics

-   UE connection failures
-   Degraded channel quality
-   gNB overload or crash
-   UE detach events

## Running the Test

Start the Jamming attack in the requested environment with real-time
metrics displayed in Grafana:

``` bash
sudo docker compose --profile system up
```

Access Grafana dashboard at <http://localhost:3300>.
