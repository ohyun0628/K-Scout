<p align="center">
  <img src="KScout_AppIcon_1024.png" width="120" height="120" alt="K-Scout App Icon">
</p>

<h1 align="center">⚽ K-Scout</h1>

<p align="center">
  <b>K League Player Stats & Match Schedule iOS App</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.7+-F05138?style=flat&logo=swift&logoColor=white"/>
  <img src="https://img.shields.io/badge/SwiftUI-blue?style=flat&logo=swift&logoColor=white"/>
  <img src="https://img.shields.io/badge/iOS-15%2B-black?style=flat&logo=apple&logoColor=white"/>
  <img src="https://img.shields.io/badge/Xcode-14%2B-147EFB?style=flat&logo=xcode&logoColor=white"/>
  <img src="https://img.shields.io/badge/API-Football-00A651?style=flat"/>
</p>

---

K-Scout은 K리그 팬들과 전력 분석관을 위해 기획된 **모바일 데이터 스카우팅 플랫폼**입니다.
선수 스탯을 레이더 차트로 시각화하고, 경기 일정·결과·팀 순위·선수 득점 순위를 한눈에 확인할 수 있는 iOS 애플리케이션입니다.

---

## 📱 Project Overview

| 항목 | 내용 |
|------|------|
| Project Name | K-Scout |
| Platform | iOS (iPhone) |
| Language | Swift 5.9+ |
| Framework | SwiftUI |
| IDE | Xcode 12.5+ |
| API | API-Football (api-sports.io) & Local Mock DB |
| Developer | 권오현 (2171053) |
| Course | iOS Programming — Hansung University |
| Track | 빅데이터트랙 |



## ✨ Features

### 🔍 선수 검색 & 스탯 시각화
- K리그 등록 선수 이름 검색 (연도별 2022~2026 선택 조회 가능)
- 선수 프로필 사진 및 상세 스탯 제공
- 커스텀 SwiftUI 캔버스를 활용한 **오각형 레이더 차트 시각화** (득점/도움/슛/패스/수비)

### 🏆 팀 순위표 & 스쿼드
- K리그1 / K리그2 탭 구조로 실시간 순위 제공
- 팀 로고 · 승점 · 득실차 · 최근 5경기 폼 표시
- 팀 클릭 시 구단 스쿼드 라인업 조회 기능

### 👑 선수 순위
- 리그별 득점 순위 (Top Scorers), 도움 순위 (Top Assists) 상위 목록 제공
- 선수 카드 탭 시 즉시 상세 스탯 화면으로 이동

### 📅 경기 일정 & 결과
- 주간 캘린더 뷰 및 일자 선택을 통한 전체 경기 일정 확인
- 실시간 진행 중 경기 스코어 표시 및 결과 조회

### 🔐 오프라인 대응 로그인 시스템
- 이메일/비밀번호 기반 커스텀 로그인 및 회원가입 (Firebase 기반)
- 시연 및 오프라인 환경을 위한 프리패스(Mock) 로그인 완벽 지원

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
 │   └─ AuthViews      (로그인 & 회원가입)
 └─ ViewModels (async/await & @ObservableObject)
     └─ MockPlayerService (오프라인 무중단 데이터 통신 관장)
```

---

## 🌐 데이터 관리 파이프라인

```text
1. Base API URL  : https://v3.football.api-sports.io
2. 주요 엔드포인트: /players, /standings, /fixtures
3. Fail-Safe 로직: 
   - API 연결 실패 또는 오프라인 환경(`useMockData` 활성화) 시, 
   - 앱 내부에 내장된 수만 건의 `DummyData2022~2026.swift` 로컬 구조체로 즉시 스위칭
```

---

## 🎥 Demo Video

[![K-SCOUT 시연 동영상](https://img.youtube.com/vi/uhc21nUUQlY/maxresdefault.jpg)](https://youtu.be/uhc21nUUQlY)
> 👆 이미지를 클릭하시면 앱 구동 시연 영상(YouTube)으로 이동합니다.

## ⚙️ 설치 및 실행 방법

```bash
# 1. 레포지토리 클론
git clone https://github.com/ohyun0628/K-Scout.git

# 2. Xcode로 열기
open K-Scout.xcodeproj

# 3. 빌드 & 실행 (iOS 15+ 시뮬레이터 권장)
# (현재 오프라인 시연 모드로 자동 설정되어 있어, API Key 없이 즉시 모든 기능 테스트 가능)
```

---

## 👨‍💻 Developer

| | |
|---|---|
| Name | 권오현 |
| Student ID | 2171053 |
| University | Hansung University |
| Course | iOS Programming |
| Track | 빅데이터트랙 |
