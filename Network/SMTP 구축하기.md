
# 1. 메일 서버 구축

- sendmail, dovecot 설치

![Untitled](https://user-images.githubusercontent.com/55968079/185590085-555b774c-e560-4907-9cb2-34b2edc079e1.png)

- [sendmail.mc](http://sendmail.mc) 파일 수정
    - vi /etc/mail/sendmail.mc

![Untitled 1](https://user-images.githubusercontent.com/55968079/185590096-2a1ba0a9-6dcd-419e-9873-f818c29f42dd.png)

![Untitled 2](https://user-images.githubusercontent.com/55968079/185590103-03527c5c-c540-42d4-ba50-f597dea55400.png)

- vi /etc/mail/local-host-names
    - 사용할 도메인 이름 등록

![Untitled 3](https://user-images.githubusercontent.com/55968079/185590115-6fc57b3f-8e48-4c0d-96f2-326aeb626e77.png)

- vi /etc/mail/access
    - IP, 도메인 등 접근 허용을 위한 설정 파일 수정 작업
    - 마지막
        - 이 아이피 영역에 있는 것들은 모두 허용하겠다는 의미!

![Untitled 4](https://user-images.githubusercontent.com/55968079/185590123-2414d53c-b13a-4066-af01-c2ed63aa55a9.png)

- sendmail 설정 완료
    - 설정 파일 수정 및 makemap hash라는 툴을 이용해 파일을 만들어낸다.
    - < : 파일 입력 받는 명령어

![Untitled 5](https://user-images.githubusercontent.com/55968079/185590135-1f4c59aa-8196-47d2-abe2-61cb90e5f2cc.png)

- 사용자 추가
    - vi /etc/group
    - mail에 사용자 a,b를 추가해줘야 한다.

- sendmail 서버 실행
    - systemctl start sendmail
    - sendmail : 메일 보내는 서버!
    
- dovecot 설정
    - dovecot : 메일 받는 서버

![Untitled 6](https://user-images.githubusercontent.com/55968079/185590159-e36d8a88-458f-4933-8029-98584bb25da4.png)

- vi /etc/dovecot/dovecot.conf
    - 24, 30번째 줄 주석 제거
    - 30번째 줄은 모두 받겠다는 의미
        - 포트 수정할 때에는 conf.d/master.conf. 에서 수정하라는 뜻
- vi /etc/dovecot/conf.d/l10-auth.conf
    - 평문 인증 처리 사용해야 하기 때문에 no로 설정

![Untitled 7](https://user-images.githubusercontent.com/55968079/185590191-17fc1d78-24d2-4850-a431-039aaefb86f8.png)

- 메일 사서함 위치 설정
    - vi /etc/dovecot/conf.d/10-mail.conf
    - 사용해야 하기 때문에 주석 제거

![Untitled 8](https://user-images.githubusercontent.com/55968079/185590224-daa1029c-852e-407a-a789-e419b5276d8b.png)

- vi /etc/dovecot/conf.d/10-master.conf
    - 포트 지정 - 19번째 줄 143, 40번째 줄 110
    
    ![Untitled 9](https://user-images.githubusercontent.com/55968079/185590244-98471921-f4da-41e8-b5b0-de10348e0611.png)
    
- vi /etc/dovecot/conf.d/10-ssl.conf
    - ssl(암호화)를 사용하지 않기 위해 ssl = no로 설정해준다.

![Untitled 10](https://user-images.githubusercontent.com/55968079/185590257-eef75114-34cd-4026-a4ee-94ff3fb4329c.png)

- dovecot 실행
    - systemctl start dovecot
- 방화벽 설정
    - firewall-cmd --permanent --add-port={25,110,143}/tcp
    - firewall-cmd —reload : reload 필수!!
    
- 결과

![Untitled 11](https://user-images.githubusercontent.com/55968079/185590268-0510ce33-b8f3-4604-8982-a78ad0f89b0c.png)

![Untitled 12](https://user-images.githubusercontent.com/55968079/185590285-77eb144e-673e-425c-a003-1bb9cb9cd3b2.png)

# 2. 클라우드 환경에서 구축하기 - 네이버 클라우드

- 네이버 클라우드 서버 환경 구성도

![Untitled 13](https://user-images.githubusercontent.com/55968079/185590298-5f9d0b2a-9cc2-4ed6-8ffc-ae2aee70e225.png)

- 네이버 클라우드 플랫폼 사용
    - Server 두 개 구축

![Untitled 14](https://user-images.githubusercontent.com/55968079/185590314-589f1a7b-db3c-48b5-ade6-dc2ddf8232ef.png)

- 구성도대로 Web, DNS, Blog, Intra, Mail,, FTP 동일하게 구축 진행하면 됨
    - Web
        
      ![Untitled 15](https://user-images.githubusercontent.com/55968079/185590435-06ad056c-4618-430b-a4c2-2ed446f9aab3.png)
        
    - DNS
        
        ![Untitled 16](https://user-images.githubusercontent.com/55968079/185590460-6c04bacb-a083-4506-a05d-2506c8e9b81f.png)
        
    - Intra
        
        ![Untitled 17](https://user-images.githubusercontent.com/55968079/185590487-4ab2489b-b7c2-44a4-99a0-73f2efb48ede.png)
        
    - Mail
        
        ![Untitled 18](https://user-images.githubusercontent.com/55968079/185590509-4cffa09a-f0f9-4758-95c4-3782a0431b03.png)
        
        - 클라우드 서버에 메일 서버 구축 시 주의 해야 할 설정들이 존재
            - vi /etc/mail/access
            - localhost, 도메인 주소, 클라우드 서버 주소(private, public), 공인IP 입력
            
            ![Untitled 19](https://user-images.githubusercontent.com/55968079/185590518-62d4332b-11ba-47af-8077-3072e46cd448.png)
            
            - vi /etc/hosts
                - 반드시 서버 이름 작성해줘야한다!!
            
            ![Untitled 20](https://user-images.githubusercontent.com/55968079/185590537-259f3f17-b1e9-469c-8a36-53c0ac26db58.png)
            
        - 네이버를 포함해 다른 메일 서버와 메일 송수신 되면 성공!
