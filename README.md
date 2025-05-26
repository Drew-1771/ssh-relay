# ssh-relay
This Docker container is designed to establish an SSH tunnel that acts as a relay for forwarding network traffic (TCP protocol only) between a local machine and a remote server. 

This container:
  - Automatically sets up the tunnel.
  - Automatically attempts to re-establish a lost connection.

# setup
## local machine
- First, clone this repo using `git clone https://github.com/Drew-1771/ssh-relay`
- For auto-ssh to work, you need to establish a known_hosts file, which is usually found under `~/.shh/known_hosts`. This can be done by connecting to the remote machine on your current machine, using regular ssh, and using the known_hosts file generated (if you already have a known_hosts file, you can make a backup of it and delete it to keep things simple and clean)
- If you do not have ssh keys to use, generate them: https://docs.oracle.com/en/cloud/cloud-at-customer/occ-get-started/generate-ssh-key-pair.html
- Once you have your known_hosts and private ssh key, move them into the ssh/ directory
## remote machine
Enable the two settings in the `/etc/ssh/sshd_config` file of the remote machine. You will either need to restart the ssh service (`sudo systemctl restart ssh`) or the remote machine for these to take affect.
- `AllowTcpForwarding`
- `GatewayPorts` 

# deploy
- `docker compose up -d` in the same directory as the `docker-compose.yml` file to run the container in the background.
- The auto-ssh table runs in verbose mode, so you may use `docker logs -f {CONTAINER ID}` to verify your connection is successful

# errors:
`debug1: Remote: Forwarding listen address "localhost" overridden by server GatewayPorts`
`debug1: remote forward failure for: listen 1234, connect localhost:5678`
`Warning: remote port forwarding failed for listen port 1234`
- Connection failed / This port is already in use by a ssh tunnel or similar service, make sure you don't already have a tunnel for this port