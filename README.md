## bicep-module
AEMSP Bicep Main Module

## 고객사 Repo Setting 방법

- AEMSP 테스트 구독
  - 테넌트: 
  - 구독: 

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
       - AZURE_CLIENT_ID : 
       - AZURE_SUBSCRIPTION_ID : 
       - AZURE_TENANT_ID : 
       - GIT_PAT : [PAT 설정 가이드 링크](https://iamjjanga.tistory.com/16)
