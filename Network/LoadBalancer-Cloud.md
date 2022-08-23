# Day10 - LoadBalancer, Cloud

# 1. LoadBalancer 구축 네트워크 네이버 클라우드에 구축하기

- haproxy에서 80포트를 사용하기 때문에 wordpress는 8080 포트와 같이 다른 포트를 사용해야 한다!

- 네이버 클라우드 데이터베이스 생성
    
    ![Untitled](Day10%20-%20LoadBalancer,%20Cloud%2089927b0762e74cf4b2f7d82ca3362aa3/Untitled.png)
    

- CentOS7-100
    - haproxy 설치
    - wordpress 설치
- CentOS7-200
    - wordpress 설치

- 한 클라우드 서버에 프록시와 wordpress 둘 다 설치해야 하므로 포트를 다르게 설정해줘야한다!
    - 기본 80 포트에서 8080을 캐치할 수 있도록 수정해준다.
    - vi /etc/httpd/conf/httpd.conf
        
        ![Untitled](Day10%20-%20LoadBalancer,%20Cloud%2089927b0762e74cf4b2f7d82ca3362aa3/Untitled%201.png)
        
    
    - 프론트엔드 접속은 80 포트로 설정해주되, 백엔드 주소는 클라우드 서버 내부IP와 8080 포트로 설정해준다.
        - vi /etc/haproxy/haproxy.cfg
        
        ![Untitled](Day10%20-%20LoadBalancer,%20Cloud%2089927b0762e74cf4b2f7d82ca3362aa3/Untitled%202.png)
        
- 네이버 클라우드 서버 ACG 포트 추가 - 3306, 8080
    
    ![Untitled](Day10%20-%20LoadBalancer,%20Cloud%2089927b0762e74cf4b2f7d82ca3362aa3/Untitled%203.png)
    

- 네이버 클라우드 데이터베이스 ACG 포트 추가 - 3306
    - 모든 ip 주소 열어줘도 되고 아니면 클라우드 서버 두 대만 한정해서 열어줘도 된다!
    
    ![Untitled](Day10%20-%20LoadBalancer,%20Cloud%2089927b0762e74cf4b2f7d82ca3362aa3/Untitled%204.png)
    

- php 파일 데이터베이스 정보 설정
    - vi /var/www/html/wp-config.php
    - 데이터베이스 생성할 때 테이블 생성해줬던 정보를 바탕으로 설정
    
    ![Untitled](Day10%20-%20LoadBalancer,%20Cloud%2089927b0762e74cf4b2f7d82ca3362aa3/Untitled%205.png)
