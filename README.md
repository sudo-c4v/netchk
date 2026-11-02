```text
                           /$$               /$$       /$$      
                          | $$              | $$      | $$      
     /$$$$$$$   /$$$$$$  /$$$$$$    /$$$$$$$| $$$$$$$ | $$   /$$
    | $$__  $$ /$$__  $$|_  $$_/   /$$_____/| $$__  $$| $$  /$$/
    | $$  \ $$| $$$$$$$$  | $$    | $$      | $$  \ $$| $$$$$$/ 
    | $$  | $$| $$_____/  | $$ /$$| $$      | $$  | $$| $$_  $$ 
    | $$  | $$|  $$$$$$$  |  $$$$/|  $$$$$$$| $$  | $$| $$ \  $$
    |__/  |__/ \_______/   \___/   \_______/|__/  |__/|__/  \__/
                                                               
                 Super simple Linux network utility
```

A small bash wrapper around common Linux networking commands.

## Features
- List network interfaces and addresses
- Ping a host
- Resolve DNS records
- Show listening sockets

## Requirements
- Linux with `iproute2` (`ip`, `ss`)
- `ping`
- `dig` (from `dnsutils` / `bind-utils`)
- Root is optional; it's only needed to see process names in `ss`

## Install
```bash
git clone https://github.com/sudo-c4v/netchk.git
cd netchk
chmod +x netchk.sh
```

## Usage
```bash
./netchk.sh -i              # list interfaces
./netchk.sh -p 1.1.1.1      # ping
./netchk.sh -d example.com  # resolve DNS
./netchk.sh -l              # listening sockets
```

## Why I built it
A project to get comfortable with bash scripting, git, and
version control.

## License
MIT
