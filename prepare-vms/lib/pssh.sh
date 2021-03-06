# This file can be sourced in order to directly run commands on 
# a batch of VMs whose IPs are located in ips.txt of the directory in which
# the command is run.

pssh () {
    HOSTFILE="ips.txt"

    [ -f $HOSTFILE ] || {
        >/dev/stderr echo "No hostfile found at $HOSTFILE"
        return
    }

    echo "[parallel-ssh] $@"
    export PSSH=$(which pssh || which parallel-ssh)

    $PSSH -h $HOSTFILE -l ubuntu \
    --par 100 \
    -O LogLevel=ERROR \
    -O UserKnownHostsFile=/dev/null \
    -O StrictHostKeyChecking=no \
    -O ForwardAgent=yes \
    "$@"
}
