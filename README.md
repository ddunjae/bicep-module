## bicep-module
AEMSP Bicep Main Module

## 고객사 Repo Setting 방법

- AEMSP 테스트 구독
  - 테넌트: sckcorp.co.kr
  - 구독: FY24_ExpertMSP_Audit (6cebf2f6-6962-4e8f-b5b5-93bfc10adaaa)

- New Repository Setting
  - 신규 Repo 생성 후, 해당 모듈을 고객사 Repository에서 Submodule 형식으로 사용
    ```PowerShell
    git submodule add https://github.com/spintech-msp/bicep-module.git
    git add .gitmodules bicep-module
    git commit .gitmodules bicep-module
    git push
    git submodule update --remote bicep-module
    ```
  
  - GitHub Action을 사용한 자동화 배포 구성
    1. usage-sample/deploy_bicep.yml 샘플 참고하여 .github/workflows/deploy_bicep.yml 구성
    2. Action Secret 구성
       ![image](https://github.com/spintech-msp/bicep-module/assets/127721836/f85b85ce-9690-407d-9982-931a64bd3c7f)
       - AZURE_CLIENT_ID : 63f0a3c9-7f4d-45cf-93fe-527b05dcab36
       - AZURE_SUBSCRIPTION_ID : 6cebf2f6-6962-4e8f-b5b5-93bfc10adaaa
       - AZURE_TENANT_ID : 45939ce6-50d5-48dc-bf2e-6086b74c66e5
       - GIT_PAT : [PAT 설정 가이드 링크](https://iamjjanga.tistory.com/16)

   - Azure 애플리케이션 설정
     1. 테스트 구독의 'Bicep-Git-Connector' 애플리케이션 검색
        ![image](https://github.com/spintech-msp/bicep-module/assets/127721836/af05455b-d739-408c-9f1e-5527fab4d3d1)
     2. 인증서 및 암호 - 페더레이션 자격 증명 추가
        ![image](https://github.com/spintech-msp/bicep-module/assets/127721836/b34a5162-5cd3-44c7-a57e-079bf70e3fc5)