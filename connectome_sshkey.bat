@echo off

set id=%1

ssh-keygen -t rsa
type "%systemdrive%%homepath%\.ssh\id_rsa.pub" | ssh %id%@147.47.200.169 -o StrictHostKeyChecking=no "umask 077; rm -r ~/.ssh; mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"

ssh -T -A -o StrictHostKeyChecking=no %id%@147.47.200.169 "nodes=(master node1 node2 storage); for node in ${nodes[@]}; do cat ~/.ssh/authorized_keys | ssh %id%@$node -o StrictHostKeyChecking=no 'umask 077; rm -r ~/.ssh; mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys'; done"
