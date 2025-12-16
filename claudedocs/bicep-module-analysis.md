# Bicep Module 코드베이스 분석 보고서

**분석일**: 2025-12-10
**대상**: bicep-module 리포지토리
**용도**: Azure Expert MSP (AEMSP) 프로그램용 재사용 가능한 Bicep 모듈 라이브러리

---

## 1. 폴더 구조 개요

리포지토리는 **Azure 서비스 도메인** 기준으로 11개 카테고리로 구성:

```
bicep-module/
├── automation/           # Azure Automation 리소스
├── bot/                  # Bot Framework 서비스
├── compute/              # 가상 머신 및 컴퓨팅 리소스
├── db/                   # 데이터베이스 서비스 (SQL)
├── managed/              # Managed Identity
├── monitor/              # 모니터링 및 관측성
├── network/              # 네트워킹 리소스 (최대 규모)
├── recovery-service/     # 백업 및 복구 서비스
├── security/             # 보안 리소스 (Key Vault)
├── storage/              # Storage Account
├── usage-sample/         # 샘플 배포 및 GitHub Actions 워크플로우
└── claudedocs/           # 분석 문서
```

---

## 2. Bicep 파일 상세 목록

### 2.1 AUTOMATION (2개 파일)

| 파일명 | 용도 | 주요 특징 |
|--------|------|-----------|
| `automation_account.bicep` | Azure Automation Account | Basic SKU, 로컬 인증 비활성화, 공용 네트워크 비활성화 |
| `runbook.bicep` | Automation Runbooks | PowerShell/Python 스크립트 실행 |

### 2.2 BOT (1개 파일)

| 파일명 | 용도 | 주요 특징 |
|--------|------|-----------|
| `bot-services.bicep` | Bot Services 배포 | Bot Framework 통합 |

### 2.3 COMPUTE (7개 파일)

| 파일명 | 용도 | 주요 특징 |
|--------|------|-----------|
| `vm-linux.bicep` | Linux VM | Ubuntu, 전체 프로비저닝 옵션 |
| `vm-windows.bicep` | Windows VM | OS SKU 변형 지원 |
| `vm-linux-redhat.bicep` | RedHat Linux VM | RHEL 전용 |
| `ai-services.bicep` | Cognitive Services | S0 SKU AI 서비스 |
| `availability-sets.bicep` | VM 가용성 집합 | 고가용성 구성 |
| `disk.bicep` | 관리 디스크 | Premium/Standard 옵션 |
| `snapshots.bicep` | 디스크 스냅샷 | 백업/복원용 |

### 2.4 DATABASE (2개 파일)

| 파일명 | 용도 | 주요 특징 |
|--------|------|-----------|
| `sql.bicep` | SQL Server + Database 생성 | 서버와 DB 동시 생성 |
| `sql_db.bicep` | 기존 서버에 SQL DB 배포 | 자식 리소스 패턴 |

### 2.5 MANAGED IDENTITY (1개 파일)

| 파일명 | 용도 | 주요 특징 |
|--------|------|-----------|
| `managed-id.bicep` | 사용자 할당 관리 ID | RBAC 통합용 |

### 2.6 MONITORING (10개 파일)

| 파일명 | 용도 | 주요 특징 |
|--------|------|-----------|
| `log-analytics-workspace.bicep` | Log Analytics Workspace | 중앙 로깅 |
| `log-analytics-workspace-data-collection.bicep` | 데이터 수집 규칙 | DCR 구성 |
| `log-analytics-workspace-solution.bicep` | LAW 솔루션/확장 | 모니터링 확장 |
| `application-insight.bicep` | Application Insights | APM 통합 |
| `action-group.bicep` | 경고 액션 그룹 | 알림 라우팅 |
| `action-rule.bicep` | 경고 액션 규칙 | 알림 규칙 |
| `activity-log-alerts.bicep` | 활동 로그 경고 | 리소스 변경 감지 |
| `metric-alert-rule.bicep` | 메트릭 기반 경고 | 성능 모니터링 |
| `smart-detector-alert-rules.bicep` | Smart Detector 경고 | AI 기반 이상 감지 |
| `data-collection-endpoint.bicep` | 데이터 수집 엔드포인트 | 에이전트 기반 수집 |

### 2.7 NETWORK (18개 파일) - 최대 카테고리

| 파일명 | 용도 | 주요 특징 |
|--------|------|-----------|
| `vnet.bicep` | 가상 네트워크 | 주소 공간 구성 |
| `subnet.bicep` | 서브넷 | 자식 리소스 패턴 |
| `nsg.bicep` | 네트워크 보안 그룹 | 보안 규칙 컨테이너 |
| `nsg-rule.bicep` | NSG 규칙 | 자식 리소스 패턴 |
| `pip.bicep` | 공용 IP 주소 | Standard SKU |
| `lb.bicep` | 로드 밸런서 | 확장 가능 구성 |
| `lb-inbound-nat-rule.bicep` | LB NAT 규칙 | 포트 포워딩 |
| `route-table.bicep` | 라우트 테이블 | 사용자 정의 라우팅 |
| `route.bicep` | 라우트 | 자식 리소스 패턴 |
| `nat-gateway.bicep` | NAT 게이트웨이 | 아웃바운드 연결 |
| `firewall.bicep` | Azure Firewall | 네트워크 보안 |
| `firewall-policy.bicep` | 방화벽 정책 | 규칙 집합 |
| `firewall-policy-group.bicep` | 방화벽 정책 그룹 | 자식 리소스 |
| `ip-group.bicep` | IP 그룹 | IP 주소 집합 |
| `dnszone.bicep` | DNS 영역 | 도메인 관리 |
| `dnszone-record.bicep` | DNS 레코드 | A, CNAME, TXT 등 |
| `vpn.bicep` | VPN Gateway | 하이브리드 연결 |
| `vpn-connection.bicep` | VPN 연결 | Site-to-Site |
| `local-network-gateway.bicep` | 로컬 네트워크 게이트웨이 | 온프레미스 정의 |
| `vwan.bicep` | Virtual WAN | 대규모 네트워킹 |
| `logicapp.bicep` | Logic Apps | 워크플로우 자동화 |

### 2.8 RECOVERY SERVICES (4개 파일)

| 파일명 | 용도 | 주요 특징 |
|--------|------|-----------|
| `recovery-service-vault.bicep` | Recovery Services Vault | VM 백업 |
| `recovery-service-backup-policy.bicep` | RS 백업 정책 | 스케줄 및 보존 |
| `backup-vault.bicep` | Data Protection Backup Vault | 새로운 백업 서비스 |
| `backup-policy.bicep` | 백업 정책 | 데이터 보호 정책 |

### 2.9 SECURITY (1개 파일)

| 파일명 | 용도 | 주요 특징 |
|--------|------|-----------|
| `key-vault.bicep` | Azure Key Vault | RBAC, Soft Delete, Purge Protection |

### 2.10 STORAGE (1개 파일)

| 파일명 | 용도 | 주요 특징 |
|--------|------|-----------|
| `storage-account.bicep` | Storage Account | Blob, File, Queue, Table 지원 |

---

## 3. 모듈 관계 및 의존성

### 3.1 부모-자식 리소스 계층

```
Parent-Child 관계 (Bicep 리소스 계층):
├── vnet (부모)
│   └── subnet (자식 리소스)
│       └── vm (의존: subnet, nsg, pip)
│
├── nsg (부모)
│   └── nsg-rule (자식 리소스)
│
├── firewall-policy (부모)
│   └── firewall-policy-group (자식 리소스)
│
├── route-table (부모)
│   └── route (자식 리소스)
│
├── sql server (부모)
│   └── sql_db (자식 리소스)
│
└── vpn-gateway (부모)
    └── vpn-connection (자식 리소스)
```

### 3.2 모듈 조합 패턴 (usage-sample/create-vm.bicep)

```bicep
module vnet '../network/vnet.bicep'
module nsg '../network/nsg.bicep'
module nsgRule '../network/nsg-rule.bicep'
module subnet '../network/subnet.bicep'
module vm '../compute/vm-windows.bicep'

// 명시적 의존성 선언:
dependsOn: [nsg]
dependsOn: [vnet]
dependsOn: [subnet]
```

### 3.3 크로스 모듈 출력 체인

| 소스 모듈 | 출력 | 대상 모듈 | 입력 |
|-----------|------|-----------|------|
| `vnet.bicep` | `vnetId` | `subnet.bicep` | `vnetName` 참조 |
| `nsg.bicep` | `nsgId` | `vm.bicep` | `nsgId` 파라미터 |
| `pip.bicep` | `pipId`, `pipAddr` | `vm.bicep` | `pip.id` |

---

## 4. 리소스 타입 요약

| 카테고리 | 리소스 타입 |
|----------|-------------|
| **Compute** | Virtual Machines, Disks, Snapshots, Availability Sets |
| **Network** | VNets, Subnets, NSGs, Load Balancers, Public IPs, NAT Gateway, Firewall, VPN, Virtual WAN, DNS Zones |
| **Storage** | Storage Accounts (Blob, File, Queue, Table) |
| **Database** | SQL Servers, SQL Databases |
| **Security** | Key Vault, Managed Identities |
| **Monitoring** | Log Analytics Workspace, Application Insights, Alert Rules, Action Groups, Data Collection Rules |
| **Backup** | Recovery Services Vault, Backup Vault, Backup Policies |
| **Automation** | Automation Accounts, Runbooks |
| **Integration** | Logic Apps, Bot Services, Cognitive Services |

---

## 5. 파라미터 패턴 및 컨벤션

### 5.1 네이밍 컨벤션

| 리소스 타입 | 패턴 예시 | 비고 |
|-------------|-----------|------|
| VMs | `vmName` 파라미터 → 직접 사용 | 호스트네임 15자 제한 |
| Network | `vnetName`, `subnetName`, `nsgName` | 명확한 도메인 접두사 |
| Storage | `storageName` (하이픈 제거) | `replace(storageName, '-', '')` |
| Identifiers | `pipName`, `lbName`, `lawName` | 약어 사용 |

### 5.2 공통 파라미터 타입

```bicep
// 1. 필수 파라미터
param vmName string
param location string
param adminUsername string

// 2. 보안 파라미터
@secure()
param adminPassword string  // @minLength(12)

// 3. 기본값 파라미터
param location string = 'koreacentral'
param addressPrefix string = '10.0.0.0/16'
param tags object = {}

// 4. 제한 파라미터 (Enum)
@allowed(['Standard_LRS', 'Premium_LRS', 'Premium_ZRS'])
param storageSkuName string

// 5. 조건부 플래그
param usePublicIP bool = false
param useDataDisk bool = false
param useMultiDataDisk bool = false

// 6. 배열 파라미터
param zones array = []
param multiDataDisk array = []
param frontendIPConfigurations array = []
```

### 5.3 출력 패턴

```bicep
// 표준 출력: [리소스타입]Id 패턴
output vnetId string = vnet.id
output subnetId string = subnet.id
output nsgId string = nsg.id
output vmId string = vm.id
output pipId string = pip.id

// 애플리케이션 특화 출력
output nicPrivateIp string = nic.properties.ipConfigurations[0].properties.privateIPAddress
output pipAddr string = pip.properties.ipAddress
```

### 5.4 보안 데코레이터

```bicep
@description()        // 모든 파라미터 문서화
@secure()            // 비밀번호, 자격 증명
@minLength(n)        // 유효성 검사
@maxLength(n)        // 유효성 검사
@allowed([...])      // 열거형 값
```

---

## 6. 아키텍처 인사이트

### 6.1 설계 원칙

1. **모듈성**: 각 모듈 독립 배포 가능
2. **조합성**: 출력-입력 바인딩을 통한 모듈 체인
3. **유연성**: 선택적 기능을 위한 광범위한 boolean 플래그
4. **보안 우선**: 프라이빗 네트워크 액세스, RBAC, 암호화 옵션
5. **리전 지원**: 전체 location 파라미터화

### 6.2 주요 기능

**Virtual Machine 모듈:**
- Linux (Ubuntu, RedHat) 및 Windows 지원
- 유연한 디스크 관리 (단일/다중 디스크, 조건부 생성)
- 선택적 Public IP가 있는 통합 NIC
- NAT 규칙을 통한 Load Balancer 지원
- vTPM 및 Secure Boot가 있는 Trusted Launch 보안
- TrustedLaunch용 Guest Attestation 확장

**Storage Account 모듈:**
- 모든 Storage 종류 지원 (Storage, StorageV2, BlobStorage 등)
- 세분화된 서비스 활성화 (Blob, File, Queue, Table)
- 암호화 키 소스 구성 (Microsoft.Storage 또는 KeyVault)
- TLS 강제
- 공용 액세스 제어
- 교차 테넌트 복제 제어
- 주석 처리됨: Private Endpoints 및 Private DNS zones

**Networking 모듈:**
- 구성 가능한 주소 공간이 있는 VNets
- 선택적 NSG, NAT Gateway, Route Table 연결이 있는 서브넷
- 포괄적인 NSG 규칙 프레임워크
- 확장 가능한 구성의 Load Balancer
- VPN 및 Virtual WAN 지원
- 정책 그룹이 있는 Firewall

**Monitoring 스택:**
- 계층화된 경고 시스템 (Activity, Metric, Smart Detector)
- 중앙 로깅을 위한 Log Analytics
- Application Insights 통합
- 최신 에이전트 기반 모니터링을 위한 Data Collection endpoints
- 보존 및 할당량 정책

### 6.3 보안 기능

| 리소스 | 보안 기능 |
|--------|-----------|
| Azure Automation | 로컬 인증 비활성화, 공용 네트워크 비활성화 |
| Key Vault | RBAC 권한 부여, Soft Delete, Purge Protection |
| Storage | 선택적 인프라 암호화 |
| SQL | 보안 관리자 자격 증명 |
| VM | Guest Attestation 보안 확장 |

---

## 7. GitOps 통합

### 7.1 GitHub Actions 워크플로우 (`usage-sample/deploy_bicep.yml`)

**주요 기능:**
- 다중 리전 배포 지원
- Federated Credentials를 통한 Azure 인증
- 배포 전 What-if 유효성 검사
- 구독 범위 배포
- Git 태그를 통한 자동 버전 관리

### 7.2 통합 컨텍스트

- AEMSP (Azure Expert MSP) 프로그램 일부
- 테스트 테넌트: sckcorp.co.kr
- 테스트 구독: FY24_ExpertMSP_Audit
- Git 서브모듈로 고객 리포지토리 통합 설계

---

## 8. 통계 요약

| 항목 | 수량 |
|------|------|
| 총 Bicep 파일 | 56개 |
| Bicepparam 파일 | 0개 |
| 모듈 카테고리 | 11개 도메인 |
| 최대 카테고리 | Network (18개 파일) |
| 복합 샘플 | 3개 파일 |
| GitHub Actions 워크플로우 | 1개 파일 |
| 문서 파일 | 1개 (README.md) |

---

## 9. 사용 패턴 (usage-sample 참조)

### 9.1 VM 생성 플로우

```
create-vm.bicep (오케스트레이터)
├─ vnet.bicep (네트워크 생성)
├─ nsg.bicep (보안 그룹 생성)
├─ nsg-rule.bicep (nsg 의존)
├─ subnet.bicep (vnet 의존)
└─ vm-windows.bicep (subnet 의존, nsg/pip 출력 사용)
```

### 9.2 조합 패턴

1. **파라미터 정의**: 배포 커스터마이징
2. **모듈 선언**: 상대 경로 사용
3. **파라미터 전달**: 부모에서 자식 모듈로
4. **출력 소비**: 이전 모듈에서
5. **의존성 관리**: `dependsOn` 배열 사용

---

## 10. 권장 개선 사항

### 10.1 단기 개선

1. **Bicepparam 파일 추가**: 환경별 파라미터 파일 생성 (dev, staging, prod)
2. **Private Endpoint 활성화**: Storage 모듈의 주석 처리된 PE 구성 활성화
3. **테스트 자동화**: Bicep linting 및 what-if를 CI에 통합

### 10.2 장기 개선

1. **모듈 버전 관리**: 시맨틱 버저닝 도입
2. **문서화 강화**: 각 모듈별 README 추가
3. **예제 확장**: 다양한 시나리오별 샘플 추가

---

## 11. 결론

이 리포지토리는 다음 목적으로 설계된 **체계적이고 프로덕션 준비된 Bicep 모듈 라이브러리**입니다:

1. **재사용성**: Git 서브모듈을 통한 고객 구현 전반에 걸친 재사용
2. **조합성**: 명시적 모듈 의존성 및 출력 체인을 통한 구성
3. **보안**: 기본 보안 구성 및 RBAC 지원
4. **유연성**: 광범위한 boolean 플래그 및 파라미터화
5. **자동화**: Federated Credential 인증을 통한 GitHub Actions
6. **유지보수성**: 명확한 네이밍, 문서화, 도메인 기반 구성

아키텍처는 엔터프라이즈 MSP 운영에 적합한 모듈식, 조합 가능, 버전 관리 가능한 Azure 리소스 정의로 **Infrastructure-as-Code 모범 사례**를 따릅니다.
