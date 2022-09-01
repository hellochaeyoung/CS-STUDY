
## 1. Terraform으로 EC2 생성하기

![Untitled](Terraform_ec2_images/Untitled.png)

- terraform plan, terraform apply —auto-approve
- 결과
    - public ip를 다음과 같이 알려주므로 XShell에서 접속할 수 있다.

    ![Untitled](Terraform_ec2_images/Untitled%201.png)

    ![Untitled](Terraform_ec2_images/Untitled%202.png)


- user data 추가하고 ec2 생성하기
    - user data 내용이 추가되거나 조금만 달라져도 ec2가 삭제되고 재생성된다!

    ![Untitled](Terraform_ec2_images/Untitled%203.png)

    ![Untitled](Terraform_ec2_images/Untitled%204.png)

    ![Untitled](Terraform_ec2_images/Untitled%205.png)

- AWS EC2에 Wordpress 설치 및 AWS RDS 연결
    - AWS RDS MySQL로 생성 → 엔드포인트 필요
    - 다음 명령어 그대로 진행
    - 인스턴스를 설치하면 우리가 직접 관리 가능

    ![Untitled](Terraform_ec2_images/Untitled%206.png)

    - 이 화면이 나오면 성공!

    ![Untitled](Terraform_ec2_images/Untitled%207.png)

- 지금까지의 설치 과정 자동화하기
    - 쉘 파일 생성

        ![Untitled](Terraform_ec2_images/Untitled%208.png)

        ![Untitled](Terraform_ec2_images/Untitled%209.png)
