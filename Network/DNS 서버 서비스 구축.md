# Day05

```
1. Centos7
wordpress + DB
HAproxy -> LoadBalancer

2. Docker
workpress + DB

+ DockerFile
3. K8S = Kubernetes
동일한 pod
pod 분리

4. IaC = CloudFormation = Terraform

apm
Linux + apache + php + mysql(mariadb)
```

# 1. 도메인 구매

- [hosting.kr](http://hosting.kr) 사이트에서 [cyahn.xyz](http://cyahn.xyz) 라는 도메인 구매

# 2. DNS 서버 세팅 - 주(master),보조(slave) 도메인 서버

- 이전에 한 서버 삭제
    - yum remove -y bind bind-utils bind-libs httpd
    
    ![Untitled](https://user-images.githubusercontent.com/55968079/184883426-339de21d-6256-4ec9-8f5a-cb8d0f9da673.png)
    
    - 만약 역방향(com.cyahn) 파일도 있다면 같이 지워주기!
    - index.html 파일도 지워주기!
    - 방화벽 설정 삭제
        - firewall-cmd —permanent —remove-port=80/tcp
        - firewall-cmd —permanent —remove-port=53/tcp
        - firewall-cmd —permanent —remove-port=53/udp
    - 이렇게 각각 명령어 치기 싫으면 파일 생성해서 파일 내용 작성한 후 파일을 실행하면 된다.
        - ls -la : 파일 권한 조회 명령어
        - 실행 권한이 없어도 sh 명령어를 사용하면 강제로 실행시킬 수 있다.
            - sh rm.sh
        - 파일 내용 맨 윗줄은 작업 영역을 의미! → /bin/bash
        
        ![Untitled 1](https://user-images.githubusercontent.com/55968079/184883119-3de96d8e-3df8-4624-9dc0-6362cd9eb1fa.png)
        
- 방화벽 설정
    - **firewall-cmd —list-all** : 현재 방화벽 설정 조회 명령어
    - 설정 파일 편집 - 포트 53,54,80 삭제
    - 방화벽 리로드
    
    ![Untitled 2](https://user-images.githubusercontent.com/55968079/184883161-08183fe2-43e9-4bcd-9217-12711534f264.png)
    
- 웹서비스 설치
    - 3개의 가상 리눅스 서버에 모두 설치
        - yum install -y bind bind-utils bind-libs httpd
    - 웹 서비스 설정 파일 수정
        - vi /etc/named.conf
        - 서비스 될 IP 주소 수정, 접속 허용 수정
        - sed -i ‘s/127.0.0.1/any/g’ /etc/named.conf
        - sed -i ‘s/localhost/any/g’ /etc/named.conf
            - 127.0.0.1 or localhost → any로 변경해주는 명령어! ⇒ 파일에 직접 접근하지 않고 수정할 수 있는 방법
        
        ![Untitled 3](https://user-images.githubusercontent.com/55968079/184883169-ddfe8d26-e99b-43e4-9f0a-7dd28e8924c4.png)
        
        - vi /etc/named.rfc1912.zones
            - 정방향 접속 조회 설정
                - 도메인 네임 수정
                - master : 주 도메인 서버를 의미
                - 보조 도메인 서버(10.0.0.2, 10.0.0.3) 허용
                
                ![Untitled 4](https://user-images.githubusercontent.com/55968079/184883177-3f6ceb43-3bbd-43b4-8c56-4e0a8ca3d4d3.png)
                
                - 꼭 아이피 주소 뒤에 ‘;’ 붙여주기!!!!!!!!!!!!!!!!!!!!!!!!! → 안하면 에러남
                
            - 역방향 접속 조회 설정
                
                ![Untitled 5](https://user-images.githubusercontent.com/55968079/184883185-ea90a107-6d27-4baa-a298-5e3e7aa57ae2.png)
                
            - named 파일 새 도메인 파일명으로 복사 후 편집 - 정방향 파일, 역방향 파일
            
            ![Untitled 6](https://user-images.githubusercontent.com/55968079/184883196-e72af0cc-23b2-4405-9311-7ae8f1ed6627.png)
            
            ![Untitled 7](https://user-images.githubusercontent.com/55968079/184883202-40f4c868-e1a6-497b-a1c8-fd3ca6a2f30c.png)

	![Untitled 8](https://user-images.githubusercontent.com/55968079/184883208-4fd2e672-6c18-4306-a7f4-c9311a3bca88.png)
            
            - 수정파일 읽기 권한 부여
                - chmod o+r /var/named/cyahn.com /var/named/com.cyahn
                    - 이 권한을 주지 않으면 cmd창에서 nslookup 명령어로 찾을 때 아예 읽지를 못해서 DNS 서버를 찾지 못한다.
                
            - 방화벽 설정
                - 포트 열어 준 후 반드시 **reload 명령어는 마지막에 실행**!!!
                    - 방화벽 설정 변경 했을 땐 무조건 reload 명령어로 적용 해 줘야한다.
                - 아래 캡쳐 대로 했을 시 접속 오류 발생 - 80 포트 오픈 적용 안됐기 때문에
                
                ![Untitled 9](https://user-images.githubusercontent.com/55968079/184883219-823eb684-4939-49ed-b408-3cd6dd46e59f.png)
                
            - DNS 서버, 웹 서버 실행
                - systemctl start named
                - systemctl start httpd
        
- 보조  DNS 서버 설정 - CentOS7-2, CentOS7-3
    - 앞 과정 동일
    - 설정 파일 내용만 변경
    
    ![Untitled 10](https://user-images.githubusercontent.com/55968079/184883234-4a0535b4-85f7-46f8-aa95-4475b526e9a0.png)
    
    ![Untitled 11](https://user-images.githubusercontent.com/55968079/184883249-d34d7066-4695-438c-8e82-412d48cc78e0.png)
    
    - index.html 파일 생성
        - vi /var/www/html/index.html
    
    ![Untitled 12](https://user-images.githubusercontent.com/55968079/184883290-f6847788-073d-46a7-acc1-4720cbda2f14.png)
    
    - 서버 실행 및 방화벽 포트 오픈
        - **포트 오픈 설정 후 reload 무조건 해줘야한다! → 안하면 적용 안됨.**
    
    ![Untitled 13](https://user-images.githubusercontent.com/55968079/184883304-b64c4a16-a072-4910-b828-36ec95dc8edc.png)
    
    - 가상 머신 도메인 서버 ip 주소 고정 값으로 설정
    
    ![Untitled 14](https://user-images.githubusercontent.com/55968079/184883313-64e44509-bdd3-494d-bcb1-e11b39497164.png)
    
    - 결과 화면 - 성공 시
    
    ![Untitled 15](https://user-images.githubusercontent.com/55968079/184883323-ccaad951-76aa-493d-948b-fd64a27d00f5.png)

    ![Untitled 16](https://user-images.githubusercontent.com/55968079/184883350-90daa437-b9f7-40fe-8a3f-fac0ce0f9b33.png)
    
- 레코드 추가할 일이 생길 경우 **주 도메인 서버 파일에 내용을 추가**해줘야한다!
    - 아래처럼 wwww를 추가했을 때 반드시 serial 넘버를 수동으로 올려줘야 한다.

![Untitled 17](https://user-images.githubusercontent.com/55968079/184883394-0e7e7913-06a1-4f8d-98a8-42a7991fbde7.png)

```
<여러 웹 사이트를 운영하는 방법>
1. IP 주소가 여러 개인 경우
2. Port를 달리하는 경우

동일한 IP로 여러 웹 사이트를 운영하는 방법

```

# 3. DNS 서비스 구축 - blog, intra

- 포트 사용하기
    - vi /etc/httpd/conf/httpd.conf
    - 8080으로 수정하면 서버의 8080 포트도 열어줘야한다.
        - firewall-cmd —add-port=8080/tcp
    
    ![Untitled 18](https://user-images.githubusercontent.com/55968079/184883397-002a8846-3e6a-4297-89a0-defcce58e784.png)
    
    - 클라이언트가 다음과 같이 포트 번호까지 입력해줘야 접속 가능
    
    ![Untitled 19](https://user-images.githubusercontent.com/55968079/184883402-83d741dd-fe8b-4a81-8ae1-b96e20b03313.png)
    
    - 블로그 도메인 추가하기
        - 웹 서버 설정 추가
        - vi /etc/httpd/conf/httpd.conf
        
        ![Untitled 20](https://user-images.githubusercontent.com/55968079/184883405-a1bb7cfe-1439-4e33-8048-bf9f2e505d91.png)
        
        - index.html 파일 생성
            - 디렉토리 생성
                - mkdir /var/www/blog
                - vi /var/www/blog/index.html
        - 도메인에 블로그 레코드 추가
            - vi /var/named/cyahn.com
            
            ![Untitled 21](https://user-images.githubusercontent.com/55968079/184883410-5c5b83f3-604f-47f9-8a34-c849e9b0d216.png)
            
            - serial 숫자를 바꾸면 보조 서버에서도 수정되어 있는다!
            
            ![Untitled 22](https://user-images.githubusercontent.com/55968079/184883411-3c5db973-e1ca-4ac6-bba6-e0740b283d44.png)
            
            - 보조 DNS 서버 index.html 파일 동일하게 생성
            - 웹 서버 설정파일 수정
                - vi /etc/httpd/conf/httpd.conf
                
                ![Untitled 23](https://user-images.githubusercontent.com/55968079/184883412-eb11af12-b72c-496f-b022-3c59820dc925.png)
                
            - 밑에까지 추가 해줘야 기본 서버도 접속 가능! → 이렇게 명시를 해줘야 한다.
                - 주, 보조 서버 다
                
                ![Untitled 24](https://user-images.githubusercontent.com/55968079/184883415-abc8c9bf-0c23-4ef9-8a7b-01d881bf4b6a.png)
                
- intra 설정하기
    - mkdir /var/www/intra
    - vi /var/www/intra/index.html
    - vi /etc/httpd/conf/httpd.conf
        
        ![Untitled 25](https://user-images.githubusercontent.com/55968079/184883416-95dee1d8-242d-43db-a9d8-377cb4563dd6.png)
        
    
    - vi /var/named/cyahn.com
        
        ![Untitled 26](https://user-images.githubusercontent.com/55968079/184883418-962df172-06c6-48b1-b0d4-78945a0b9304.png)
        
    - 보조 서버 (7-3)에 intra index.html 생성
        
        ![Untitled 27](https://user-images.githubusercontent.com/55968079/184883421-d86054ae-c1fd-4174-b082-2b91f8741a77.png)
        
    - 결과 화면
        
        ![Untitled 28](https://user-images.githubusercontent.com/55968079/184883423-8de388f0-0ef1-4267-a755-264b353b9455.png)
