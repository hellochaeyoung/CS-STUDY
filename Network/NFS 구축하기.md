
# 1. Storage

- DAS(Direct Attach Storage)
    - IDE, SCSI, SATA
    - 대부분 서버 내부 또는 근처에 위치
    - 따라서 확장성에 제한이 있다.
    - 저렴, 속도 빠름, 안정적
- NAS(Network Area Storage)
    - 통상적으로 100Mbps ~ 1Gbps 이내로 구성된 네트워크 내에 존재
    - 원거리 설치 및 접속 가능
    - 파일 시스템 공유 가능
    - NFS(Network File System)
    - 속도가 느리다.
    - 병목 현상이 발생하면 더 느려진다.
    - 거의 모든 Cloud Service Provider 지원
- SAN(Storage Area Network)
    - 별도의 전용 장비(SAN Switch, 서버: HBA Card)
    - Fiber Channel 구성
    - 16Gbps 급 이상으로 구성
    - 원거리 설치 및 파일 시스템 공유 가능
    - 너무 너무 비싸다.
    - FC, FCIP, iSCSI
    

## 2. NFS -  Network File System

- NFS 설치 - 2 : NFS Server
    - yum install -y nfs-utils
- 설정 파일 수정
    - mkdir /nfs-s : 서버 디렉토리 생성
    - vi /etc/exports
        - root_squash : 접속하는 사용자 모두 루트 관리자로 사용하겠다는 뜻
        
        ![Untitled](https://user-images.githubusercontent.com/55968079/185592079-2fd52984-6592-412d-953a-6a54edfbfbec.png)
        
    
- 서버 실행 및 권한 확인
    
    ![Untitled 1](https://user-images.githubusercontent.com/55968079/185591886-5ccab81d-e253-4b04-b0e7-60f557f6687a.png)
    
- 서비스 방화벽 설정
    
    ![Untitled 2](https://user-images.githubusercontent.com/55968079/185591951-82b0fbe6-e834-4046-91a5-24fe343f60f9.png)
    
- NFS 설치 - 3 : NFS Client
    - yum install -y nfs-utils
    - 서버든 클라이언트든 util은 필요!
- 장치를 사용하기 위해서는 반드시 디렉토리와 연결하는 작업이 필요하다! ⇒ Mount
    - 디렉토리 생성
        - mkdir /nfs-c
    - mount -t nfs 10.0.0.2:/nfs-s /nfs-c
    - 마운트를 하고 나서 파일을 생성했을 때 서버에서도 확인할 수 있다!
    
    ![Untitled 3](https://user-images.githubusercontent.com/55968079/185591956-458486ed-72fe-4147-b5d8-2bdeaf0e9de1.png)
    
    ![Untitled 4](https://user-images.githubusercontent.com/55968079/185591958-b5d63102-2948-4149-bf69-886bfe58fcac.png)
    
- 언마운트 하면 파일 안보임
    
    ![Untitled 5](https://user-images.githubusercontent.com/55968079/185591961-c054119b-770b-455c-996b-abf8cd2443fd.png)
    
- 윈도우에서 연결해보기
    - cmd
        - mount -o anon 10.0.0.2:/nfs-s z:
        - umount z: : 연결 해제
        
        ![Untitled 6](https://user-images.githubusercontent.com/55968079/185592001-1f029175-6ef6-4abf-b307-e9db686db716.png)
        
    - 리눅스 서버에서 권한 주기
        
        ![Untitled 7](https://user-images.githubusercontent.com/55968079/185592014-3b147937-2b17-43a9-b359-2e112a874e5f.png)
        
    
    - 네트워크 파일 시스템 사용하기 위해서는 마운트 작업이 반드시 필요! → 디렉토리 생성해주고 연결해주면 된다.
        
        ![Untitled 8](https://user-images.githubusercontent.com/55968079/185592016-3a6df1cf-47b4-48be-9f73-cf3d00444484.png)
        
- vmware에서 서버에 하드디스크 2개 추가해준 후 조회하면 다음과 같음
    - 물리적인 디스크 총 3개
    - lsblk : 디스크 상태 조회 명령어
    
    ![Untitled 9](https://user-images.githubusercontent.com/55968079/185592084-b7f4e0cf-4cf6-4b3a-a5ca-605ddd73b3a5.png)
    
- 파티셔닝
    - 물리적인 디스크를 논리적으로 분할
    - 디스크를 사용하기 위해서는 반드시 1개 이상의 파티션이 존재 해야 한다.
    - 주 파티션을 4개까지 생성 가능, 주 파티션 중 하나를 확장 파티션으로 생성 가능
    - 확장 파티션의 논리 파티션을 12개 생성 가능
- 파일 시스템
    - 파일이나 디렉토리(폴더)를 효율적으로 관리하는 기술
    - Linux : ext2 → (ext3 → ext4) → xfs
        - 저널링 파일시스템 : 파일을 생성하거나 삭제할 때 Log, 속도가 느리다.
        - ext3의 느린 속도를 개선한 버전이 ext4
    - Windows : fat16 → fat32 → NTFS
        - fat32 : 단일 파일 4G 이상 저장이 불가
- 마운트
    - 리눅스에서 장치를 사용하기 위해서 디렉토리와 연결하는 작업

- 디스크 사용해보기
    
    ![Untitled 10](https://user-images.githubusercontent.com/55968079/185592088-167b96be-e53b-45cb-bdb3-97d6510d148d.png)
    
    - n : 새로운 파티션 생성
        
        ![Untitled 11](https://user-images.githubusercontent.com/55968079/185592092-feec8a68-33f0-439f-91f5-31a9d4fa466f.png)

        ![Untitled 12](https://user-images.githubusercontent.com/55968079/185592093-bb48f41d-6cf3-4342-bb25-7967ca9e2377.png)

        ![Untitled 13](https://user-images.githubusercontent.com/55968079/185592095-5488f009-cbd1-4ebe-a5d9-c71d85a2cbd2.png)
        
    
    - 파티션 삭제하기
        - 파티션을 삭제할 때 디렉토리 마운트 된 상태이기 때문에 마운트를 꼭 해지하고 나서 삭제를 진행해야한다!
        - 마운트 대상은 디렉토리!! → 디렉토리에 연결해서 같이 공유해서 여러 유저가 사용할 수 있는 것
        - d : delete
    
    - 실습
        
        ![Untitled 14](https://user-images.githubusercontent.com/55968079/185592097-090623f1-a14e-4523-abe3-a65282388c21.png)
        
        1. sdb 디스크를 파티션 3개로 분리하기
            
            : fdisk /dev/sdb
            
            ![Untitled 15](https://user-images.githubusercontent.com/55968079/185592100-90e0bde2-268c-4a1a-bd13-7411571fb122.png)

            ![Untitled 16](https://user-images.githubusercontent.com/55968079/185592102-1575ed31-3784-4d3c-a152-ecfe7e59359b.png)
            
    
    1. 마운트할 디렉토리 생성
        
         : mkdir /cyahn1 /cyahn2 /cyahn3
        
    2. 파일 시스템 (ext3, ext4, xfs) 순차적으로 생성
        
        ![Untitled 17](https://user-images.githubusercontent.com/55968079/185592056-8828499f-157b-4d68-a41a-792c12a2cf78.png)

        ![Untitled 18](https://user-images.githubusercontent.com/55968079/185592060-6c88af48-a0bf-495b-b0fd-9b72feb402f3.png)

        ![Untitled 19](https://user-images.githubusercontent.com/55968079/185592061-3ca3af5f-0e14-4732-98fb-2322acfe3bee.png)
        
    3. 생성한 디렉토리를 파일 시스템과 연결
        
        ![Untitled 20](https://user-images.githubusercontent.com/55968079/185592064-bdc30c66-1cea-4073-aa8e-25a615aff9d6.png)

        ![Untitled 21](https://user-images.githubusercontent.com/55968079/185592066-2feb0ffd-8a5a-4494-b471-fed0dc576ced.png)

        ![Untitled 22](https://user-images.githubusercontent.com/55968079/185592070-ecb6610a-5655-47b5-8b00-fd994ff6790a.png)
        
    4. 마운트 하기 전 디렉토리
        
        ![Untitled 23](https://user-images.githubusercontent.com/55968079/185592074-bd2cb005-4c64-42f7-b9b7-2294366fcaa8.png)
        
    5. 마운트 한 후 디렉토리 상황 및 마운트 해지
        1. cyahn3 왜 마운트 안되는지 모르겠음, 확인해볼 것
        
        ![Untitled 24](https://user-images.githubusercontent.com/55968079/185592077-d0632903-db38-4c71-8203-da1c8a85c964.png)
        
    
- 디스크 생성 → 파티션 생성(섹터 설정) → 디렉토리 생성 → 디렉토리 마운트 하면 사용 가능
- 마운트를 해지하면 로컬로 돌아온다! → 실제로 공유 디렉토리가 사라진 것을 아님 단지 연결만 해지
