# Day04

# 1. FTP 다시 설치하기

- FTP 삭제 명령어
    - yum remove -y vsftpd
    - 주요 설정 파일은 rpmsave로 완전히 삭제 안됨!
        - rm -f /etc/vsftpd/vsftpd.conf.rpmsave
- FTP 설치
    - yum install -y vsftpd
- FTP 설정파일 수정
    - vi /etc/vsftpd/vsftpd.conf
    
    ```
    umask
    	디렉토리 777, 파일 666
    	디렉토리 실행하기 위해서는 반드시 실행 권한이 있어야 함
    	파일은 굳이 실행 권한이 없어도 됨! => sh 명령어를 사용하면 파일을 실행할 수 있다.
    
    57 xferlog
    	로그인 관련 내용이 아닌 파일 실행 유무에 관한 로그
    
     87 banner_file
    	배너 파일 중요! 실습에서는 파일을 따로 만들어서 내용을 작성
    	원격 접속 시 배너 메시지로 warning 메시지를 무조건 보여줘야 하기 때문!
    
    128 tcp_wrappers
    
    129 allow_writeable_chroot
    	무언가 하기 위해서는 이 설정이 반드시 필요! -> 뭐였는지 추후에 확인
    ```
    
    - 이렇게 sh 명령어를 사용하면 파일은 실행시킬 수 있기 때문에 파일은 666이다.
    
    ![Untitled](https://user-images.githubusercontent.com/55968079/184309185-c32e709e-d2da-4d24-9c0d-05b8e7e7d0a9.png)
    
- 사용자 만들기
    - 사용자를 만들면 /home 밑에 사용자명 파일이 생성된다. → /home/a 이런 식으로
    - 어제 만든거 삭제하기
        - userdel a
        - userdel -r b
        
        ![Untitled 1](https://user-images.githubusercontent.com/55968079/184308844-e90c9857-d0b5-4c33-a63c-2f36fba8308c.png)
        
        - -r 옵션을 주지 않으면 이렇게 완전히 삭제되지 않음
        - 있는 상태에서 동일한 이름으로 다시 생성하게 되면 b를 만들고 a를 만들면 a의 소유주가 b로 되므로 나중에 강제로 삭제해줘야지만 된다. 따라서 **사용자를 삭제할 때 반드시 -r 옵션을 주고 삭제**한다!
    - 다시 재생성하기
        - useradd aa
        - useradd bb
        - ls -al /home 명령어로 사용자 목록 확인 가능
- 파일 생성하기
    - dd if=/dev/zero of=/home/aa/aa1.txt bs=300M count=1
    - dd if=/dev/zero of=/home/bb/bb1.txt bs=300M count=1
    - 생성된 파일 확인하기
        - ls -lah /home/aa
        - ls -lah /home/bb
- 필요 디렉토리, 파일 생성하기
    - yum install -y tree : 디렉토리 구조 2차원으로 편하게 다 보기 위해 설치
    - mkdir -p : *p 옵션*을 주면 생성되지 않은 디렉토리까지 다 생성하여 최종 만들고 싶은 디렉토리까지 만들 수 있다.
    - tree를 설치하면 이렇게 2차원적으로 더 보기 쉽게 디렉토리 구조를 확인할 수 있다.
    
    ![Untitled 2](https://user-images.githubusercontent.com/55968079/184309040-1f12d59a-88cb-49f0-b07f-2de759205398.png)
    
    - 배너 메시지 생성
        - vi /ftp/ftp
            - 경고 메시지 내용 작성
    - chroot 파일 생성
        - 사용자 이름만 작성

# 2. FTP 서버 실행하기

- ftp 서버 실행
    - systemctl start vsftpd
    - 방화벽 포트 열어주기
        - firewall-cmd —add-port=21/tcp
        - firewall-cmd —add-port=20/tcp
    - dhcp 서버 실행시키기
        - systemctl enable dhcpd : enable 옵션을 넣어주면 시스템 부팅될 때마다 자동 실행
- 비밀번호 설정
    - FTP 서버 접속할 때 사용자 이름과 비밀번호가 필요!
    - 서버에서 다음과 같은 과정을 거쳐 유저의 비밀번호를 설정

![Untitled 3](https://user-images.githubusercontent.com/55968079/184309110-af270bff-50e9-46e3-ab64-9114a56c3d6a.png)

- FTP 서버에 접속해 파일 송수신하기 - Client에서 실행
    - ftp 접속 → 로그인 → 파일 수신(get), 파일 송신(put)
    - 클라이언트에서 파일을 보내면 서버에서 수신된 파일 목록을 확인할 수 있다.
    
    ![Untitled 4](https://user-images.githubusercontent.com/55968079/184309114-2b38a0cd-85dc-44e2-ac7c-2a1814fb8dc6.png)
    
    ![Untitled 5](https://user-images.githubusercontent.com/55968079/184309121-609c0056-5ef6-48e9-939d-3c0459743c03.png)
    
    ![Untitled 6](https://user-images.githubusercontent.com/55968079/184309125-4ea4c333-c948-4179-8464-ecb92446baa5.png)
    

# 3. FTP Passive mode

- Passive Mode란?
    - Active 모드의 단점을 보완하고자 사용한다.
    - 데이터 포트 번호를 특별하게 지정하지 않고 1024 ~ 65535 중 사용 가능한 임의 포트를 사용한다. 하나 뿐만 아니라 범위도 지정 가능하다.
    - Active 모드와 반대로 클라이언트가 접속하면 서버가 사용 가능한 포트 번호를 알려주고 클라이언트는 이 포트 번호로 데이터를 요청한다!
    - 따라서 DATA 포트는 요청 시 마다 서버가 응답한 포트 번호를 사용한다.

- FTP 서버 동일하게 재설치
    - ftp 설정파일 추가 부분
    
    ![Untitled 7](https://user-images.githubusercontent.com/55968079/184309128-45eefe71-36c9-4d1a-8500-ed9f6b68e786.png)
    
    - 포트 설정
    
    ![Untitled 8](https://user-images.githubusercontent.com/55968079/184309129-3aa265b8-fc74-4cf6-89ce-e86e47407a9d.png)
    
    - 네트워크 설정 확인하기
        - netstat -nat : tcp만
        - netstat -natp : 프로세스 번호까지
    
    ![Untitled 9](https://user-images.githubusercontent.com/55968079/184309131-4fb7ae4e-a0e7-4840-97eb-47f232395f6a.png)
    
- 클라이언트에서 파일 전송
    - 새 호스트 생성하고 접속 → 로그인 후 파일 송수신

![Untitled 10](https://user-images.githubusercontent.com/55968079/184309135-7d9bd7b7-f714-43ee-9d46-c5f3ec82a81e.png)

![Untitled 11](https://user-images.githubusercontent.com/55968079/184309138-9016ff95-6a67-4bb4-a7a2-ee4e3ba04f67.png)

# 4. DNS

- Domain Name Service, System, Server
- URL → IP Address
- Protocol : UDP, TCP
- Port : 53
    - TCP

- 역방향, 정방향 조회

![Untitled 12](https://user-images.githubusercontent.com/55968079/184309140-b2ce0b22-85d8-48e2-b413-4012adec9476.png)

- DNS 수동 설정

![Untitled 13](https://user-images.githubusercontent.com/55968079/184309142-eb95843b-d9f2-4d5b-80df-03925d7053ad.png)

![Untitled 14](https://user-images.githubusercontent.com/55968079/184309145-4ad358ba-9152-4dbd-bc96-04b924306105.png)

![Untitled 15](https://user-images.githubusercontent.com/55968079/184309147-cf3dc5ee-111f-4690-bb74-1420501805fc.png)

- public DNS 서버로 가기까지의 3단계
    - Cache 확인
        - 한 번이라도 검색을 했으면 메모리에 남아있는다. → 1시간 내에, 정보가 남아있기 때문에 캐시에서 조회
    - /etc/hosts 확인
        - 캐시에 없다면 hosts 파일에 등록을 해서 사용한 적 있는지 확인한다.
    - public DNS에 가서 확인
        - 여기에도 없으면 전 세계에 13대 밖에 없는 root DNS 서버로 간다.
    
    ![Untitled 16](https://user-images.githubusercontent.com/55968079/184309148-fa8eae8c-4daa-4e39-a223-54b059bddd58.png)
    

# 5. DNS 서버 구축

- DNS 서버 설치
    - yum install -y bind bind-utils bind-libs
- DNS 서버 설정 파일 수정
    - vi /etc/named.conf
    
    ![Untitled 17](https://user-images.githubusercontent.com/55968079/184309156-949c935e-b998-4774-be90-edf4a8098533.png)
    
    - vi /etc/named.rfc1912.zones
    
    ![Untitled 18](https://user-images.githubusercontent.com/55968079/184309161-1d5d1a8e-087d-4cbf-9df2-99e6cecbd117.png)
    
    - vi /var/named.rfc1912.zones
    
    ![Untitled 19](https://user-images.githubusercontent.com/55968079/184309165-7011c9c2-c934-48d1-b4a6-6c47371c0fff.png)
    
- 생성한 파일 cyahn.com에 others에게 읽기 권한을 부여해준다.
    
    ![Untitled 20](https://user-images.githubusercontent.com/55968079/184309168-81c19dae-42d2-4337-8849-134b53444a53.png)
    
- 서버 실행
    - systemctl start named
- 포트 열어주기
    
    ![Untitled 21](https://user-images.githubusercontent.com/55968079/184309171-d83a5fb0-0d2b-440f-82d1-3d113c674d22.png)
    
- 테스트
    - cyahn.com, www.cyahn.com, ftp.cyahn.com, ns1.cyahn.com, [mail.cyahn.com](http://mail.cyahn.com)
    - 10.0.0.1로 설정되어있으면 됨

![Untitled 22](https://user-images.githubusercontent.com/55968079/184309174-a97640b4-0098-4f7b-91e9-f39e14a05fba.png)

- 웹 서버 설치 및 포트 오픈

![Untitled 23](https://user-images.githubusercontent.com/55968079/184309176-5aae5a7e-1e5f-4d8a-a98f-b425730d4d37.png)

- 결과

![Untitled 24](https://user-images.githubusercontent.com/55968079/184309183-588b0905-1e31-4d55-abdc-90ada8256904.png)
