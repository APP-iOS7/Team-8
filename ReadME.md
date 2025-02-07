# word E

## ❓프로젝트 소개
### 간단하면서 쉽고 즐거운 영어 단어 플래시 카드 게임!
### 반복적 카드 뒤집기로 어느새 당신은 영어 달인!
- 예쁜 플래시 카드를 통해 일상생활 속에 쓰이는 영어 단어들을 쉽고 재밌게 배워 보아요!
- 맞추지 못한 카드는 북마크로 저장해두었다가 언제든지 다시 도전해 보아요!
- 결과 페이지를 통해서 나날이 성장하는 자신을 발견할 수 있습니다!


### 🛠️ 기능

![image](https://github.com/user-attachments/assets/938bbf15-b2e3-4478-ad4d-774be4668e91)


- 무작위 영어 단어 카드 뒤집기와 저장해 놓은 북마크 보기 중 해당 모드를 선택하여 학습할 수 있습니다.

![image](https://github.com/user-attachments/assets/096f5c65-ed3c-4515-bfc9-aa3e43c8bcdf)

- 답을 입력하여 나타나는 영어 단어 플래시 카드의 뜻을 맞춰볼 수 있습니다.
- 영어 단어 플래시 카드를 터치하여 카드의 뒷면에서 뜻을 확인할 수 있습니다.


![image](https://github.com/user-attachments/assets/079accba-6043-44b1-9d0b-e045990d318d)

- 버튼을 누르지 않고도 스와이프 제스처를 이용해 다음 카드로 넘길 수 있습니다.
- 결과 페이지를 통해 정답을 몇개 맞췄는지 확인할 수 있습니다.
- 북마크 기능을 이용해 나중에 보고 싶은 영어단어 플래시 카드를 저장해 놓을 수 있습니다.

## 실행 화면
<img src="https://github.com/user-attachments/assets/0ffcf9c5-80fd-4d2f-bb7e-e4b0c38b2399">


## 👩🏻‍💻 개발자 소개

|프로필|이름|이메일|
|:----:|:---:|:-----:|
|<img src="https://avatars.githubusercontent.com/ynghk?s=100"/>|이영학| celebi3@naver.com |
|<img src="https://avatars.githubusercontent.com/whswls?s=100"/>|조은진| till5941@naver.com |
|<img src="https://avatars.githubusercontent.com/yohns231?s=100" style="width: 85px;"/>|고요한| rhdygks231@naver.com |

### 💁🏻‍♀️ 역할 분담

**이영학**
- 시작 화면 꾸미기
  - 각 카드들이 무작위로 흔들리는 애니메이션 효과 구현
  - 화면 어느 곳을 터치해도 다음 화면 이동
- 모드 선택 화면 구성
  - 모드 선택시 해당 화면으로 이동

**조은진**
- 결과 화면 구성
  - 북마크 버튼 활성화
  - 리스트를 탭하여 해당 화면 이동
  - 정답 리스트와 오답 리스트 구분 짓기
  - 원형 차트를 통해 오답률 확인 가능
- 북마크 화면 구성
  - Picker를 통한 오름차순, 내림차순 정렬 기능 구현

**고요한** 
- 단어 암기 카드 화면 구성
  - 카드를 탭하여 뒤집기 애니메이션 효과 적용
  - 단어 입력 후 다음 화면으로 이동
  - 버튼 클릭 시 다음 화면으로 이동
  - 스와이프 기능으로 다음 화면 이동
  - 프로그래스바를 통해 진행률 확인 기능 구현

## 📝 회고록
### 💡 회의
<img width="1300" alt="image" src="https://github.com/user-attachments/assets/378491c5-ef81-4f3a-9198-e4ff8991219f" />

### 💭 회고
1. **프로젝트 목표 및 요구사항 수립 & 커뮤니케이션 과정 중 느낀 점**
 - 어플의 기능, 디자인, 역할 분담 등 기획 단계에서 많은 시간을 사용하였으며, 처음 기획한 방향으로 수월하게 갈 수 있었음
 - 각자 맡은 파트에서 기획되지 않은 부분은 서로 의견을 주고 받았으며, 혼자 생각할 때보다 더 좋은 아이디어를 알게 됨
 - 서로가 생각하지 못한 아이디어를 낼 수 있었음

2. **문제 및 해결 과정과 느낀 점**
- 다시 어플을 사용하고 결과 화면을 보게 되었을 때 북마크를 한 단어에 북마크 표시가 되지 않는 버그와 데이터 처리 로직 변경이 필요
  이에 기존 Swiftdata Model에서 새로 만든 Swiftdata Model로 전환하였으나 새로운 형식의 데이터로 인해 전체적인 코드의 수정이 필요하였으며
   fetal 오류가 발생
   이에 Migration의 중요성과 기획 시 데이터 부분도 고려를 해야 하는 것을 알게 됨

- NavigationStack 내에 애니메이션 효과를 적용한 View를 실행했을 시 Preview에서 보이는 화면과 다르게 View의 위치, 움직이는 정도가 심각할 정도로 차이가 나는 문제에 직면
    많은 레퍼런스를 찾아보고 자문을 하여 기존의 애니메이션 효과가 아닌 다른 효과를 적용하였고, 새로운 프로젝트 파일을 생성하여 실행했을 때 잘 작동하는 것을 확인함
    하지만 다시 기존 코드에 적용했을 때 전과 같은 현상이 발생하였음. 이에 기존 코드에 문제가 되는 것을 인지하게 되었고 문제가 될 수 있는 부분을 주석처리 하며 문제를 해결해 나감
    문제는 NavigationStack안에 바로 VStack으로 감싼 애니메이션 뷰에서 문제가 생기는 것을 확인함.  기존 VStack을 ScrollView로 감쌌고 .scrollDisabled(true) modifier을 이용해서 기존 View와 같게 만듦. 오류를 마주했을 때 당황하기 보다는 하나씩 해결해가보는 것이 중요한 것을 알게 되었음

- 기존 Swiftdata Model에서 새로운 Swift Model로 변경하면서 발생한 Compile Time Out 문제를 접하게 됨 기존에 사용하던 NavigationLink에 연결된 View에서 Model 변경으로 Argument를 받아와야 하는 상황이었으나 이를 발견하지 못하고 Build를 진행
 하지만 컴파일러는 Compile Time Out 오류만 표시해줄 뿐 Argument를 넣어줘야 한다는 오류를 알려주지 않음
 이 문제 또한 레퍼런스와 자문으로 해결하였으며, 문제가 될 수 있는 부분을 주석처리하면서 원인을 파악
   
   
3. **배울 점 및 개선 사항(혹은 아쉬운 점)**
- 기획 단계에서 좀 더 깊게 대화하여 model을 바꿔야 하는 상황이 발생하지 않도록 하기
- 결과 화면의 원형 차트 구현이 미숙하여 수정 예정

4. **차후 계획**
- API를 사용하여 여러가지 단어가 나올 수 있도록 하기

### 버그 화면
![애니메이션 오류](https://github.com/user-attachments/assets/b26e1f39-acda-4eaa-acdd-acbfb837860a)


## 📆 개발 기간
2025.02.04(화) - 2025.02.06(목)


## ⚙️ 개발 환경
<img src="https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=Xcode&logoColor=white">


## 🚀 Git 전략
### Git-Flow
> 효율적인 브랜치 관리를 통해 협업과 배포 프로세스를 최적화

![image](https://github.com/user-attachments/assets/fbd3b35b-bda9-45d6-bfab-3bad5e110477)

<br>

## 🔗 설치 및 실행 방법

### 1️⃣ Xcode 프로젝트 설치

AppStore - Xcode 설치

### 2️⃣ Xcode에서 프로젝트 열기
```
open 프로젝트명.xcodeproj
```

### 3️⃣ 빌드 및 실행하기


