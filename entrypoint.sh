#!/bin/bash
set -e

# ensure SSH key exists
if [ ! -f "/root/.ssh/${SSH_FILE_NAME}" ]; then
    echo "Error: SSH key /root/.ssh/${SSH_FILE_NAME} not found!"
    exit 1
fi

# read only permissions
chmod 600 "/root/.ssh/${SSH_FILE_NAME}"

# SSH tunnel
autossh -v -M 0 -N -R ${REMOTE_PORT}:localhost:${TARGET_PORT} ${REMOTE_USER}@${REMOTE_SERVER} -i "/root/.ssh/${SSH_FILE_NAME}" -o ServerAliveInterval=${SERVER_ALIVE_INTERVAL} -o ServerAliveCountMax=${SERVER_ALIVE_COUNT}

# ensure container running
exec /usr/sbin/sshd -D
