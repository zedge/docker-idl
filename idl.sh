#!/bin/sh

if [ -n "$(type -path idl)" ]; then
    exec idl "$@"
fi
repo_root="$(git rev-parse --show-toplevel)"

if [ -n "$DOCKER_MACHINE_NAME" ]; then
    # This contortion is for preserving your ssh-agent into a container running in a VM.
    # Only tested with local VirtualBox-based Docker Machines.
    ssh_key=$HOME/.docker/machine/machines/${DOCKER_MACHINE_NAME}/id_rsa
    ssh_host=$(docker-machine inspect ${DOCKER_MACHINE_NAME} | jq -r .Driver.IPAddress)
    ssh_port=$(docker-machine inspect ${DOCKER_MACHINE_NAME} | jq -r .Driver.SSHPort)
    ssh_user=$(docker-machine inspect ${DOCKER_MACHINE_NAME} | jq -r .Driver.SSHUser)
    ssh -A -o NoHostAuthenticationForLocalhost=yes -i ${ssh_key} -p ${ssh_port} -l ${ssh_user} localhost \
        "docker run -v \$SSH_AUTH_SOCK:\$SSH_AUTH_SOCK -e SSH_AUTH_SOCK=\$SSH_AUTH_SOCK -u 1000 \
                    -e HOME=$HOME -v $HOME/.idl:$HOME/.idl -v $repo_root:$repo_root -w $(pwd) \
                    zedge/idl $@"
else
    uid=$(id)
    uid=${uid#uid=}
    uid=${uid%%(*}
    docker run -v ${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK} -e SSH_AUTH_SOCK=${SSH_AUTH_SOCK} -u ${uid} \
                -e HOME=$HOME -v $HOME/.idl:$HOME/.idl -v ${repo_root}:${repo_root} -w $(pwd) \
                zedge/idl $@

fi
