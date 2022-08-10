
### [Port]

1. well known port : 0번 ~ 1023번
2. registered port : 1024번 ~ 49151번
3. dynamic port : 49152번 ~ 65535번, 임의대로 사용할 수 있다.

### [꼭 알고 있어야 할 Port들]

- FTP : 파일 전송 프로토콜
    - 20번 : 데이터 전송 담당, active mode와 passive mode가 있다.
    - 21번 : 제어 모드

- Telnet
    - 23번 : 암호화되지 않은 텍스트 통신, 요즘 잘 사용하지 않는다.

- SMTP(Simple Mail Transfer Protocol)
    - 25번 : 이메일 전송에 사용
    
- DNS(Domain Name System)
    - 53번
    - 전세계에 root DNS 서버는 13대 밖에 없다.
    - TCP, UDP 둘 다 사용한다.
     - TCP만 사용하는 경우
      - 메시지 사이즈가 512 byte 이상인 경우
      - 영역 전송 : 안정성을 위해 두 개 이상의 DNS 서버를 이용할 경우

- DHCP
    - IP를 자동으로 할당해주는 기능 담당
    - 67번, 68번

- HTTP
    - TCP, UDP 둘 다 사용
    - 80번

- 메일 전송
    - 110번 : POP3, 전자우편 가져오기에 사용
     - 메일을 읽으면 client에 다운된다. → 용량을 신경써야 한다.
    - 143번 : IMAP4(인터넷 메시지 접속 프로토콜 4), 이메일 가져오기에 사용
     - 서버에 데이터가 저장되어 있다 → 전용 단말이 없어도 된다.
     - 하지만 개인 메일 사서함 용량을 신경써야 한다. → 하지만 요새는 용량이 커져서 신경 안써도 된다!

- 보안 취약한 port
    - 139번 : 넷바이오스
    - 445번 : Microsoft-DS
    - 사용하지 않는게 좋다.

- SSL 위
    - 993번 : IMAP4에 SSL 적용
    - 995번 : POP3에 SSL 적용
