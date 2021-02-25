# connectome_server_sshkey_setting
This repository is intended for current users (2021/2/20) of the Connetome LAB server.   
Users must access the server through RSA key instead of password.   
This code generates an RSA key and uploads the public key to each server(gateway/master/node1/node2/storage).
Only Linux client!

### Prepare
nope!

### Run
```bash
./connectome_sshkey.sh {id}
```

### Check
```bash
ssh -A {id}@147.47.200.169
ssh -A master
ssh -A node1
ssh -A node2
ssh -A storage
```

### Issue
RSA Key Problem (Too many authentication failures)   
Do this!
```bash
ssh-add -D 
```
