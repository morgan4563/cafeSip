# ☕ cafeSip

## 🖥️ 프로젝트 소개
**cafeSip**은 사용자가 쉽게 카페에서 메뉴를 주문하고 결제할 수 있도록 돕는 iOS 앱입니다.

## ⏰ 개발 기간
- 프로토타입 2024.12.11 ~ 2025.1.20

## 🛠️ 개발 환경
- 언어 : Swift, SwiftUI
- 데이터 베이스 : Firebase Firestore
- 아키텍처 : MVVM (Model-View-ViewModel) + Service Layer (Singleton)
- 지도 서비스 : NMapsMap (네이버 지도 API)

## 📝 주요 기능
[⚙️블로그에서 GIF이미지로 동작 확인하기](https://blog.naver.com/devjoon/223730505029)

### 회원가입, 로그인
- 정규표현식을 이용하여 가입시 유효성 검사를 진행
- Firebase Authentication을 이용한 이메일 비밀번호 정보 저장
- Firebase Database를 이용한 유저 데이터 저장

### 매장등록
- Mobile Dynamic Map 을 이용한 지도 사용 좌표값을 수집
- Reverse Geocoding 을 이용하여 수집된 좌표를 토대로 도로명 주소 출력
- Firebase Database를 이용한 매장 데이터 저장

### 매장관리
- Firebase Database를 이용한 메뉴 데이터 저장
- Firebase + listener를 이용하여 구매자 결제 실시간 감시

### 메뉴주문
- CodeScanner 라이브러리를 이용한 QR코드 데이터 수집
- Firebase와 연동하여 잔액충전, 송금관리
- Firebase + listener를 이용하여 판매자 메뉴준비 실시간 감시

### 로그아웃
- 앱 라이프사이클에 따라 앱 background이동, 종료시 데이터 local 저장
- 로그아웃시 local 데이터 초기화
