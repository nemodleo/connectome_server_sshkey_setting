# connectome_server_sshkey_setting 
This repository is intended for current users (2021/8/04) of the Connetome LAB server.   
Users must access the server through RSA key instead of password.   
본 레포지토리에 있는 코드는 예전에 비밀번호가 있을 때, key를 업로드하기 위한 코드입니다. 참고 안하셔도 됩니다. 
추후 이미 키 설정되어 있는 경우 또다른 키를 한번에 코드를 공개하겠습니다.
문제 발생 시 서버 관리인에게 문의!
Only Linux client! **Window users should use Window branch!**

### 1. Generate Key

[1] RSA Key Generation
1. ssh-keygen으로 key pair 생성 ```ssh-keygen -t rsa```
2. key file 경로 및 이름 지정 (key이름이 id_rsa가 아니어도 됩니다.)
3. passphrase 입력 

### 2. Key upload & check
1. userID, First_Lastname(ex. Hyun_Park) 그리고 public key(ex. id_rsa.pub)내용을 Server administrator에게 전달
2. Server administrator에게 유저 생성 및 키 업로드 완료 응답 받은 경우, 아래 방법 및 명령어로 서버 접속 확인

```bash
ssh -A {id}@147.47.200.138
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
