<p align="center">
  <img src="KScout_AppIcon_180.png" width="120" height="120" alt="K-Scout App Icon">
</p>

<h1 align="center">K-Scout</h1>
<p align="center"><b>K리그 경기·선수 데이터 분석 iOS 애플리케이션</b></p>

# ⚽ K-Scout
### K-League Match & Player Data Analytics iOS App

K-Scout은 API-Football 데이터를 활용하여 K리그의 경기 일정, 실시간 정보 및 선수 스탯을 시각화하고 분석하는 iOS 애플리케이션입니다.

사용자는 실시간으로 K리그1/K리그2 순위표와 경기 스코어를 확인할 수 있으며, 관심 경기 시작 1시간 전에 알림을 받아 일정을 효율적으로 관리할 수 있습니다. 
또한 SwiftUI Charts를 활용한 오각형 레이더 차트를 통해 선수들의 핵심 능력을 직관적으로 비교·분석할 수 있도록 도와줍니다.

---

# 📱 Project Overview

- **Project Name** : K-Scout
- **Platform** : iOS
- **Development Environment** : Xcode 15+ (iOS 16+)
- **Language** : Swift 5.9+
- **Framework** : SwiftUI

K-Scout은 K리그 팬과 축구 분석에 관심 있는 사용자들을 위한 모바일 애플리케이션입니다. 
외부 스포츠 데이터 API 연동, 레이더 차트 시각화, 경기 시작 푸시 알림 기능을 통해 모바일 환경에 최적화된 축구 데이터 분석 경험을 제공하는 것을 목표로 합니다.

---

# ✨ Features

## 📊 League Standings
- K리그1 및 K리그2 최신 순위 정보 제공 (탭 구조)
- 팀 로고, 승점, 득실차 및 순위 변동 상황 실시간 업데이트

## 🗓 Match Schedule & Live Score
- 주간 캘린더 뷰를 통한 라운드별 경기 일정 확인
- 실시간 진행 중인 경기의 스코어 및 `LIVE` 배지 표시

## 🔔 Kick-off Notification
- 관심 팀 및 경기 즐겨찾기 기능
- 경기 시작 1시간 전 푸시 알림 수신 (`UserNotifications`)

## 📈 Player Stats Comparison
- K리그 등록 선수 검색 및 시즌 누적 스탯 상세 프로필 제공
- 두 선수의 데이터(득점, 도움, 슛, 패스, 수비)를 동시 선택하여 비교

## 🕸 Radar Chart Visualization
- `SwiftUI Charts`를 활용한 능력치 오각형 시각화
- 선수별 강점과 약점을 한눈에 파악할 수 있는 대시보드 제공

---

# 🏗 App Architecture

K-Scout은 유지보수성과 테스트 용이성을 위해 **MVVM (Model-View-ViewModel)** 패턴 및 **Swift Concurrency** 아키텍처로 설계되었습니다.

iOS App (MVVM)
 ├─ Models (Codable Data Structures)
 ├─ Views (SwiftUI Declarative UI)
 │   ├─ Standings View (리그 순위표)
 │   ├─ Schedule View (경기 일정 및 라이브 스코어)
 │   └─ Scout/Compare View (선수 스탯 비교)
 └─ ViewModels (async/await Async Networking & State Management)

본 프로젝트는 외부 REST API인 `API-Football`을 연동하여 실시간에 준하는 데이터를 파싱하고 앱의 상태(State)를 관리하도록 구현되었습니다.

---

# 🛠 Tech Stack

| Technology | Description |
|-----------|-------------|
| Swift | iOS 앱 개발 언어 (Swift Concurrency 활용) |
| SwiftUI | 사용자 인터페이스 개발 및 선언형 UI 구현 |
| Xcode | iOS 개발 환경 |
| API-Football | K리그 경기·순위·선수 데이터 수집 (REST API) |
| SwiftUI Charts | 선수 스탯 비교를 위한 레이더 차트 구현 |
| UserNotifications | 경기 시작 1시간 전 로컬/서버 푸시 알림 기능 |

---

# 🎯 Project Goals

- 복잡한 축구 데이터를 모바일 화면에 직관적으로 시각화하는 시스템 구축
- 외부 REST API 연동 및 비동기 네트워크 처리(`async/await`) 숙달
- 다양한 iOS 내장 프레임워크(`Charts`, `Notifications`)의 실무 활용 능력 향상
- MVVM 아키텍처 패턴 가이드라인을 준수하는 깔끔한 코드 작성 경험 축적

---

# 📷 App Screenshots

추후 앱 화면 스크린샷 추가 예정

---

# 🎥 Demo Video

유튜브 시연 영상 링크 (추후 추가 예정)

---

# 👨‍💻 Developer

- **Name** : 권오현  
- **Student ID** : 2171053  
- **University** : Hansung University  
- **Course** : iOS Programming
