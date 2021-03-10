#!/bin/bash

id=$1
pw=$2
nodes="master node1 node2 storage"

ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub | ssh $id@147.47.200.169 -o StrictHostKeyChecking=no 'umask 077;mkdir ~/.ssh;cat >> ~/.ssh/authorized_keys'

sshpass -p $pw ssh -T -A -o StrictHostKeyChecking=no $id@147.47.200.169 << EOF
bash
nodes="$nodes"
for node in \$nodes; do 
  cat ~/.ssh/authorized_keys | sshpass -p $pw ssh $id@\$node -o StrictHostKeyChecking=no 'umask 077;mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys' 
done
EOF
