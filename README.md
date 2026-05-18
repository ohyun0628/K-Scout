<p align="center">
  <img src="KScout_AppIcon_1024.png" width="120" height="120" alt="K-Scout App Icon">
</p>

<h1 align="center">⚽ K-Scout</h1>

<p align="center">
  <b>K League Player Stats & Match Schedule iOS App</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.9+-F05138?style=flat&logo=swift&logoColor=white"/>
  <img src="https://img.shields.io/badge/SwiftUI-blue?style=flat&logo=swift&logoColor=white"/>
  <img src="https://img.shields.io/badge/iOS-16%2B-black?style=flat&logo=apple&logoColor=white"/>
  <img src="https://img.shields.io/badge/Xcode-15%2B-147EFB?style=flat&logo=xcode&logoColor=white"/>
  <img src="https://img.shields.io/badge/API-Football-00A651?style=flat"/>
</p>

---

K-Scout은 API-Football 데이터를 활용하여 K리그 선수 스탯을 레이더 차트로 시각화하고,
경기 일정·결과·팀 순위·선수 득점 순위를 한눈에 확인할 수 있는 iOS 애플리케이션입니다.

선수 검색 및 시즌 누적 스탯 확인, 팀 순위표, 득점·도움 랭킹,
관심 선수 즐겨찾기 저장, K리그1·K리그2 경기 일정 및 실시간 스코어 조회 기능을 제공합니다.

---

## 📱 Project Overview

| 항목 | 내용 |
|------|------|
| Project Name | K-Scout |
| Platform | iOS (iPhone) |
| Language | Swift 5.9+ |
| Framework | SwiftUI |
| IDE | Xcode 15+ (iOS 16+) |
| API | API-Football (api-sports.io) |
| Developer | 권오현 (2171053) |
| Course | iOS Programming — Hansung University |
| Track | 빅데이터트랙 |

---

## ✨ Features

### 🔍 선수 검색 & 스탯 시각화
- K리그 등록 선수 이름 검색
- 선수 프로필 및 시즌 누적 스탯 제공
- SwiftUI Charts 오각형 레이더 차트 시각화
  (득점 / 도움 / 슛 / 패스 / 수비)

### 🏆 팀 순위표
- K리그1 / K리그2 탭 구조로 팀 순위 제공
- 팀 로고 · 승점 · 득실차 · 순위 변동 표시
- 실시간 업데이트

### 👑 선수 순위
- 득점 순위 (Top Scorers) 상위 선수 목록
- 도움 순위 (Top Assists) 상위 선수 목록
- 선수 카드 탭 시 상세 스탯 확인 가능

### 📅 경기 일정 & 결과
- K리그1 / K리그2 탭 구조
- 주간 캘린더 뷰로 경기 일정 확인
- 실시간 진행 중 경기 스코어 및 LIVE 배지 표시
- 지난 경기 결과 조회

### ⭐ 즐겨찾기 선수 관리
- 관심 선수 즐겨찾기 추가 / 삭제
- UserDefaults 로컬 저장
- 즐겨찾기 탭에서 빠른 조회 및 스탯 확인

---

## 🏗 App Architecture

MVVM 패턴 및 Swift Concurrency 기반으로 설계되었습니다.

```text
iOS App (MVVM)
 ├─ Models
 │   ├─ Player, Stats (선수·스탯 데이터)
 │   ├─ Match, Fixture (경기 일정·결과)
 │   └─ Standing, Ranking (순위·랭킹)
 ├─ Views (SwiftUI Declarative UI)
 │   ├─ SearchView     (선수 검색 & 레이더 차트)
 │   ├─ RankingView    (팀 순위 & 선수 랭킹)
 │   ├─ ScheduleView   (경기 일정 & 스코어)
 │   └─ FavoriteView   (즐겨찾기 선수 목록)
 └─ ViewModels (async/await & @ObservableObject)
```

---

## 🛠 Tech Stack

| Technology | Description |
|-----------|-------------|
| Swift 5.9+ | iOS 앱 개발 언어 (Swift Concurrency 활용) |
| SwiftUI | 선언형 UI 프레임워크 |
| Xcode 15+ | iOS 개발 환경 |
| API-Football | K리그 경기·순위·선수 데이터 (REST API) |
| SwiftUI Charts | 선수 스탯 레이더 차트 구현 |
| UserDefaults | 즐겨찾기 선수 로컬 저장 |

---

## 🌐 API 정보

```
Base URL  : https://v3.football.api-sports.io
K리그1    : league=292, season=2025
K리그2    : league=293, season=2025

사용 엔드포인트
/players            → 선수 검색 및 시즌 스탯
/players/topscorers → 득점 순위 상위 20명
/players/topassists → 도움 순위 상위 20명
/standings          → 팀 순위표
/fixtures           → 경기 일정 및 결과
```

---

## ⚙️ 설치 방법

```bash
# 1. 레포지토리 클론
git clone https://github.com/ohyun0628/K-Scout.git

# 2. Xcode로 열기
open K-Scout.xcodeproj

# 3. APIService.swift에 API 키 입력
let apiKey = "YOUR_API_KEY_HERE"
# api-sports.io 에서 무료 발급 가능 (100calls/day)

# 4. 빌드 & 실행 (iOS 16+ 시뮬레이터)
```

---

## 🎯 Project Goals

- K리그 선수·팀 데이터를 레이더 차트 및 순위표로 시각화하는 모바일 앱 구축
- API-Football REST API 연동 및 async/await 비동기 처리 숙달
- SwiftUI Charts 프레임워크 실무 활용 경험 습득
- MVVM 아키텍처 기반 클린 코드 작성

---

## 📷 App Screenshots

> 추후 앱 화면 스크린샷 추가 예정

---

## 🎥 Demo Video

> 유튜브 시연 영상 링크 (추후 추가 예정)

---

## 👨‍💻 Developer

| | |
|---|---|
| Name | 권오현 |
| Student ID | 2171053 |
| University | Hansung University |
| Course | iOS Programming |
| Track | 빅데이터트랙 |
