# connectome_server_sshkey_setting 
## For window users
This repository is intended for current users (2021/2/20) of the Connetome LAB server.   
Users must access the server through RSA key instead of password.   
This code generates an RSA key and uploads the public key to each server(gateway/master/node1/node2/storage).   
제가 아래 방법 정상 작동함을 확인해봤습니다.

### Prepare
[1] PuTTY Installation   
https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html 에서 버전에 맞는 putty 설치   

[2] RSA Key Generation   
1. PuTTYgen 검색 후 실행   
1. Generate button   
1. Keypassphtase,  Confirm passphrase에 원하는 키 암호 입력   
1. Save public key button (`C:\Users\{user}\.ssh\id_rsa.pub` 권장)   
1. Save private key button (`C:\Users\{user}\.ssh\id_rsa` 권장)   
1. (cmd) notpad C:\Users\{user}\.ssh\id_rsa.pub   
1. `ssh-rsa AAAAB.........`(한줄, 나머지 싹 지워주세요) 형식으로 고쳐서 저장

[3] PuTTy Setting   
1. Putty 검색 후 실행
1. Connection/data/Login deteails/Auto -login username에 server user id 입력
1. Connection/SSH/Auth/Privat Key file for authentication 에 저장한 경로 입력   
1. Session/Saved Sessions 에 원하는 이름 입력 후 저장
1. (cmd) connectome_sshkey.bat {userid} {pw} 실행

### Check
CMD or Powershell
```
putty.exe -ssh -A {id}1@147.47.200.169 
ssh -A master
ssh -A node1
ssh -A node2
ssh -A storage 
```
비밀번호 없이 접속 확인

### Issue
