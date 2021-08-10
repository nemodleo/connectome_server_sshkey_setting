# connectome_server_sshkey_setting 
### For window users
This repository is intended for current users (2021/8/04) of the Connetome LAB server.   
Users must access the server through RSA key instead of password.   
본 레포지토리에 있는 코드는 예전에 비밀번호가 있을 때, key를 업로드하기 위한 코드입니다. 참고 안하셔도 됩니다. 
추후 이미 키 설정되어 있는 경우 또다른 키를 한번에 코드를 공개하겠습니다.
문제 발생 시 서버 관리인에게 문의!

---

### 1. Generate Key
#### Method A. PuTTY
[1] PuTTY Installation   
1. https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html 에서 버전에 맞는 putty 설치   

[2] RSA Key Generation (.ppk .pub pair)  
1. PuTTYgen 검색 후 실행   
1. Generate button   
1. Keypassphtase,  Confirm passphrase에 원하는 키 암호 입력   
1. Save public key button (`C:\Users\{user}\.ssh\id_rsa.pub` 권장)   
1. Save private key button (`C:\Users\{user}\.ssh\id_rsa.ppk` 권장)   
1. (cmd) `notpad C:\Users\{user}\.ssh\id_rsa.pub` 
1. `ssh-rsa AAAAB3Nz...{생략}6jv9Uw== rsa-key-2021{comment part}`(한줄, 나머지 싹 지워주세요) 형식으로 고쳐서 저장   

#### Method B. Keygen (OpenSSH)
[1] RSA Key Generation
1. ssh-keygen으로 key pair 생성 ```ssh-keygen -t rsa```
2. key file 경로 및 이름 지정 (key 경로의 '\\' '/' 차이는 무시해도 됩니다. key이름이 id_rsa가 아니어도 됩니다.)
3. passphrase 입력 
4. ssh config file 생성
```
cd .\.ssh\
fsutil file createnew config 0
notepad config
```
5. 아래 내용을 config에 입력 후 저장
```
Host connectome
  HostName 147.47.200.138
  Port 22
  User {your user id}
	IdentityFile ~/.ssh/id_rsa
	IdentitiesOnly yes
	ForwardAgent yes
```

혹은
```
Host 147.47.200.138
  IdentityFile ~/.ssh/id_rsa
  ForwardAgent yes
```

6. ssh-add key 등록
```
ssh-agent -s
ssh-add $HOME/.ssh/id_rsa
```
---

### 2. Key upload & check
1. userID, First_Lastname(ex. Hyun_Park)  그리고 public key(ex. id_rsa.pub)내용을 Server administrator에게 전달
2. Server administrator에게 유저 생성 및 키 업로드 완료 응답 받은 경우, 아래 방법 및 명령어로 서버 접속 확인

#### Method A. PuTTY
#### [check 1]
`C:\Users\{user}\.ssh\id_rsa.ppk` 더블 클릭 및 암호 입력!   
New CMD or Powershell
```
putty.exe -ssh -A {id}@147.47.200.138
ssh -A master
ssh -A node1
ssh -A node2
ssh -A storage 
```
비밀번호 없이 접속 확인
#### [check 2]
[Session 저장]
1. PuTTY 실행
1. Session > Specify the destination you want to connect to > Host Name (or IP address)  : 147.47.200.138
1. Connection > Data > Login details > Auto-login username : {서버에 등록된 유저이름}
1. Connection > SSH > Auth > Authentication parameters > Allow agent forwarding 체크
1. Connection > SSH > Auth > Authentication parameters > Private key file for authentication : {Privat key 경로 지정}
1. Session > Load. save or delete a stored session > Saved Sessions : {원하는 세션 이름}
1. Session > Load. save or delete a stored session > Save

[Session 실행]
1. PuTTY 실행
1. Session > Load. save or delete a stored session > {저장한 세션 이름} 더블 클릭
1. 이후 PuTTY 생성된 창에서 비밀번호 없이 접속
```
ssh -A master
ssh -A node1
ssh -A node2
ssh -A storage
```


#### Method B. OpenSSH
```
//윈도우 전원키면 ssh-agent 자동 실행 안되는 것 같습니다
ssh-agent

//config에 저장한 host로 접근, -A 윈도우에서 작동하지 않습니다.
ssh connectome
ssh {id}@147.47.200.138

ssh -A master
ssh -A node1
ssh -A node2
ssh -A storage
```

---

### Issue
RSA Key Problem (Too many authentication failures)   
```bash
ssh-add -D 
```

**config가 작동 하지 않는 경우(PuTTY 제외)**
보통의 경우 1만해도 해결됩니다.
1. ```ssh-agent``` 
2. ```ssh-add -k```
3. ```ssh-add -l```
4. ssh-add key 재등록



#### [Tip] ssh key name
다음을 자동으로 먼저 찾아서 이용합니다. 되도록 이를 키 이름으로 지정하는 것이 좋습니다.
```
debug1: Trying private key: /Users/{user}/.ssh/id_rsa
debug1: Trying private key: /Users/{user}/.ssh/id_dsa
debug1: Trying private key: /Users/{user}/.ssh/id_ecdsa
debug1: Trying private key: /Users/{user}/.ssh/id_ed2551
```

