# pulsewire
 Automatic script to switch between PulseAudio and PipeWire

 ### Installation

 Download and symlink script

 ```bash
 curl -sSL -o ~/.scripts/pulsewire.sh  https://github.com/tmiland/pulsewire/raw/main/pulsewire.sh
 ```

 Symlink:
   ```bash
    ln -sfn ~/.scripts/pulsewire.sh ~/.local/bin/pulsewire
   ```
   Now use 
```bash
$ pulsewire -pw
```
or
```bash
$ pulsewire -pa
```

### Usage
```bash
Usage: [options]

--PulseAudio  |-pa     use PulseAudio
--PipeWire    |-pw     use PipeWire

```

#### Disclaimer 

*** ***Use at own risk*** ***

### License

[![MIT License Image](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/MIT_logo.svg/220px-MIT_logo.svg.png)](https://github.com/tmiland/pulsewire.sh/blob/master/LICENSE)

[MIT License](https://github.com/tmiland/pulsewire.sh/blob/master/LICENSE)