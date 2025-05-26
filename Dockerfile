FROM debian:latest

# packages for SSH tunneling
RUN apt-get update && apt-get install -y autossh openssh-server net-tools && rm -rf /var/lib/apt/lists/*

# SSH directory and set permissions
RUN mkdir -p /run/sshd
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# enty script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
