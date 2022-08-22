# Day09 - LoadBalancer

# 1. LoadBalancer

- 아무리 성능이 뛰어난 서버라 해도 모든 트래픽을 감당할 수 없다.
- 서버를 추가로 구비하고 여러 대의 서버에 동이랗ㄴ 데이터를 저장해 수많은 트래픽을 효과적으로 분산하여 처리하게 된다.
- 하지만, 여러 대의 서버를 구축해 놓았다 하더라도 클라이언트의 요청이 골고루 여러 서버에 분산될 수 있을까?
- 쏟아지는 트래픽을 여러 대의 서버로 분산시켜 주는 기술이 없다면 한 서버에 모든 트래픽이 몰리는 상황이 발생할 것이다.
- 이 때 필요한 기술이 바로 로드밸런싱이고 이것을 담당하는 장치 또는 기술을 로드밸런서라고 한다.
- 증가한 트래픽에 대처할 수 있는 방법들
    - Scale-up
        - 서버 자체의 성능을 확장하는 것
    - Scale-out
        - 기존 서버와 동일 또는 낮은 성능의 서버를 두 대 이상 증설하여 운영하는 것
        - 로드밸런싱이 반드시 필요!
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled.png)
    
    - 다양한 로드밸런싱 알고리즘
        - 라운드로빈 방식
            - 서버에 들어온 요청을 순서대로 돌아가며 배정하는 방식
            - 구성하는 네트워크에서 사용하는 알고리즘
        - 가중 라운드로빈 방식
- Proxy
    - Forward Proxy
    - Reverse Proxy
        - loadBalancer → 균등하게 분배
    

# 2. 네트워크 구성 - 프록시 및 WEB, DNS, DB, DHCP

- 사전 설정 작업
    - 가상머신 VMnet1 subnet address 세팅 및 호스트 PC VMnet1 아이피 주소 세팅
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%201.png)
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%202.png)
    

- 네트워크 구성 조건
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%203.png)
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%204.png)
    
    haproxy가 로드발란서 역할을 담당
    
    워드프레스는 웹사이트, 블로그, 앱을 만들 수 있는 오픈소스 소프트웨어로, 누구나 프로그램 개발 및 수정, 재배포가 가능한 프로그램이다.  php로 구현되었으며 데이터베이스는 MySQL 또는 MariaDB가 사용된다.
    

- 가상머신 각 1,2,3 서버에 호스트 하나 더 추가 - 백엔드
    - 네트워크 어댑터 추가해주기! - 백엔드 서버를 구축하기 위함
    - 내부적으로만 사용되기 때문에 Host-Only로 설정
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%205.png)
    
    - ip 주소가 10.0.0.1로 설정되어 있는 것 확인
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%206.png)
    
- 네트워크 스크립트 목록 확인 시 ens33만 파일이 존재하고 ens36 파일은 없다!
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%207.png)
    
- 파일 복사한 뒤 내용 편집
    - 백엔드 서버로, 내부에서만 사용될 서버이기 때문에 게이트웨이, DNS 다 필요없다!
    - ip 주소 수정
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%208.png)
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%209.png)
    

- 네트워크 재실행 후 ip 주소 확인
    - 설정한 ip 주소로 변경된 것을 볼 수 있음
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2010.png)
    
- 새로 생성한 각 백엔드 서버에 dns, web, dhcp 설치
    - 설치 과정은 지난 설치 과정과 거의 동일
    
    | HOST | CentOS7-1 | CentOS7-2 | CentOS7-3 | W10-1 |
    | --- | --- | --- | --- | --- |
    | IP - FrontEnd | 10.0.0.1 | 10.0.0.2 | 10.0.0.3 | 10.0.0.100 |
    | IP - BackEnd | 172.16.0.1 | 172.16.0.2 | 172.16.0.3 |  |
    |  |  |  |  |  |
    | Roles | 주DNS | 보조DNS | DHCP |  |
    |  | haproxy(Load) | WEB(Main) | WEB(Main) |  |
    |  | MySQL5.7 (Server) | WordPress | WordPress |  |
    |  |  | php7.3 | php7.3 |  |
    |  |  | MySQL5.7 (Client) |  |  |
    - DNS  서버 설치 시 ip주소만 다르게 설정
        - master, slave 잘 구분해서!
            
            ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2011.png)
            
    
- haproxy 설치
    - web 서버 설치는 CentOS7-2, CentOS7-3 두 개에만 했으므로 해당 서버를 등록해줘야 한다.
    - vi /etc/haproxy/haproxy.cfg
        - backend app에 ip와 port 번호를 변경해준다.
        - 로드밸런싱 알고리즘으로 라운드로빈을 사용한다.
        
        ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2012.png)
        
        ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2013.png)
        
    
    - 프록시 서버 실행
        - systemctl start haproxy
    - 방화벽 80 포트 오픈
        - firewall-cmd —permanant —add-port=80/tcp
        - firewall-cmd —reload

- 프록시로 인해 도메인 접속 시 2, 3 서버로 번갈아 가면서 접속하게 된다.
    - 이것은 순서대로 접속하는 라운드로빈 알고리즘에 의해서 수행된다.

- WordPress 설치
    - 바로 그냥 다운받으면 버전 충돌이 발생해 wget을 이용해 설치
    - 2,3번 서버에 wget 먼저 설치 후 wget으로 설치
        - yum install -y wget
        - wget [https://ko.wordpress.org/latest-ko_KR.tar.gz](https://ko.wordpress.org/latest-ko_KR.tar.gz)
    - 압축 풀기
        - tar xvfz latest-ko_KR.tar.gz
    - php 파일 다 복사하여 이동 → index 때문에
        - cp -r wordpress/* /var/www/html/
        
        ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2014.png)
        
    - php 설정 파일 복사
        - cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    - 필요 라이브러리 다운
        - yum install -y epel-release yum utils
        - yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
    - php 7.3 버전 설치
        - yum-config-manager —enable remi-php73

- MySQL 설치를 위한 php 설치 및 설정
    - yum install -y php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd
    - vi /var/www/html/wp-config.php
        - 여기서 비밀번호 다르게 입력하면 아예 데이터베이스 연결이 제대로 이루어지지 않으므로 동일하게 설정할 것!

![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2015.png)

- vi /etc/httpd/conf/httpd.conf
    - html → php로 수정
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2016.png)
    
- systemctl restart httpd
- 3번 서버도 동일하게 진행!

- MySQL 설치
    - vi /etc/yum.repos.d/mysql-community.repo
    - gpgcheck=0으로 수정!
    
    ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2017.png)
    
    - MySQL Server 설치
        - yum install -y mysql-community-server
        - systemctl start mysqld
        - 비밀번호 확인
            - cat /var/log/mysqld.log | grep password → 나온 패스워드 복사해서 사용!
        - 초기화 작업 - 패스워드 재설정 위함
            - mysql_secure_installation
        - 비밀번호 재설정
            - 재설정 시 보안강도가 높지 않으면 자꾸 실패라고 뜨기 때문에 아까 php 설치 때 데이터베이스 비번으로 설정해놓은 것과 동일하게 하면 된다. (어려운 비밀번호로 설정 필수)
            - 강도가 100이면 설정이 완료되고 이후에 설정들은 다음과 같이 진행하면 된다.
            
            ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2018.png)
            
            ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2019.png)
            
        
        - MySQL 서버 접속
            - mysql -uroot -p
            
            ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2020.png)
            
        
        - 포트 오픈
            - firewall-cmd —permanent —add-port=3306/tcp
            - firewall-cmd —reload
            
    - MySQL Client 설치
        - yum install -y mysql-community-client
        - 접속
            - mysql -uroot -p -h 172.16.0.1
            - 서버에서 접속 허용을 안해줬기 때문에 오류가 발생한다.
            
            ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2021.png)
            
        
        - 서버에서 접속 허용
            - 패스워드 동일하게 입력해야 함 → 꼭 -ppassword 이렇게 -p 옵션을 붙여야한다!
            
            ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2022.png)
            
        
        - 클라이언트가 설치 된 CentOS7-2에서 데이터베이스 생성
            
            ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2023.png)
            
        - 웹 클라이언트(W10-1)로 접속
            - 제대로 연동되면 install 페이지 → 로그인 페이지로 이동
            
            ![Untitled](Day09%20-%20LoadBalancer%20079ed9f497a940ed9aa293ebeffe1eb2/Untitled%2024.png)
