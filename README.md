![Frame 341](https://github.com/cau-bootcamp/wehavit/assets/39216546/e0ea1545-b810-48c8-bf31-37687d3f5e61)
<h3 align="center"> 🎉 친구들과 함께 주고 받는 서로의 도전을 응원하는 공간, 위해빗 👏 </h3>
<div align="center"> <img align="center" src="https://github.com/cau-bootcamp/wehavit/assets/39216546/463b5439-155d-4b9c-b7e3-929984505bde" width=100 /> </div><br> 
<div align="center"> 2023. 08. 19. ~ 진행중 <br><br></div>
<div align="center">
  <a href = "https://apps.apple.com/kr/app/wehavit/id6504269390" >
    <img src="https://github.com/cau-bootcamp/wehavit/assets/39216546/754ff73d-5ef4-42c4-a643-be1bbee58e13" />
  </a>
</div>




# Background
더 나은 삶을 위해 새로운 장기적인 노력을 해보려 할 때 혼자서는 노력을 이어가기 어려운가요? <br>
SNS를 통해 인증글을 올리더라도, 추천 글들에 보이는 앞서가는 사람들에 주눅들기 일쑤인가요? 
<br><br>

**🧚 그렇다면 위해빗이 도와줄게요! ☺️**
<br><br>

친구들과 서로 주고받는 재미있는 반응들로 매일매일 노력을 이어갈 수 있게 위해빗이 도와줄게요. <br>
도전과 응원, 격려 속에서 함께 만들어가는 성공의 짜릿함을 느껴보세요. 
 <br>
 
 <br>
 
# Features
✍️ 간단한 노력 인증 절차
    
    오늘의 실천을 인증하기 위해서는 간단하게 사진 몇 장과 코멘트만 적고 공유하세요!
    내가 지키려고 노력하는게 뭔지, 이번 주에는 몇 번이나 했는지 등 
    반복해서 적기 귀찮은 정보들은 위해빗이 대신 작성해드릴게요!
    
📣 적극적인 격려 주고받기
    
    단순히 좋아요나 이모티콘으로 서로의 노력을 응원할 때 보다 더 짜릿하고 재미있게 
    서로의 실천을 응원하고 격려할 수 있게 도와드릴게요.
    그치만, 좋아요를 남기는 것 만큼이나 간편하게 할 수 있어요!
    
😎 선택한 친구들에게만 공유되는 나의 작은 도전
    
    모든 친구들에게 공유하기에는 부끄러운 목표라면 내가 원하는 친구들, 그룹에게만 공유할 수 있어요.
    나의 도전이 아직 작고 소중하다면, 내 도전을 응원해줄 수 있는 친구들 속에서 
    열렬한 환호와 따뜻한 격려를 받으며 목표를 향해 끝까지 노력해봐요!
<br>

<br>

# App Previews

|간단한 노력 인증 절차|인증글을 공유하는 그룹|내 정보 확인|
|:-:|:-:|:-:|
|![인증하기](https://github.com/cau-bootcamp/wehavit/assets/39216546/bc4a8286-ecfd-49b4-b7f6-74f4467a481a)|![그룹 확인](https://github.com/cau-bootcamp/wehavit/assets/39216546/e75fbdd6-8f74-4d82-a14a-7d42dfa5b28d)|![내 정보 확인](https://github.com/cau-bootcamp/wehavit/assets/39216546/5dbaeed5-4522-4c14-aa0c-c1ed9a9b82ac)|


|반응 남기기|반응 확인하기|스플래시화면|
|:-:|:-:|:-:|
|![반응하기](https://github.com/cau-bootcamp/wehavit/assets/39216546/88241d1c-a2b9-47e5-9fb6-bba3459fac0f)|![반응확인2](https://github.com/cau-bootcamp/wehavit/assets/39216546/597a4e47-09ca-4b4c-9cb5-1d83f4be5b4c)|![RPReplay_Final1719307120](https://github.com/cau-bootcamp/wehavit/assets/39216546/ea919153-d5e6-4867-85e9-21badaa2bfe5)|



# Project Development
### 개발 환경

- macOS (Apple Silicon)
- Flutter (Channel stable, 3.22.2, on macOS 14.5 23F79 darwin-arm64 (Rosetta), locale ko-KR)
- Android SDK version 34.0.0
- Xcode 15.4

### 적용한 아키텍처

- **Clean Architecture** for overall project
- **MVVM** for presentation layer

### 적용한 상태관리 도구
- Riverpod

### 실행 방법
1. Git Clone 
    
    ```bash
    $ git clone https://github.com/cau-bootcamp/wehavit.git 
    $ cd wehavit
    ```

2. dependency 패키지 설치

    ```bash
    flutter pub get
    ```

3. Firebase App 설정
    Install firebase cli tool: https://firebase.google.com/docs/cli?hl=ko#setup_update_cli
   
    ```bash
    $ firebase login # login to firebase
    $ firebase projects:create {your-project-name} # create new project
    $ dart pub global activate flutterfire_cli # install flutterfire cli
    $ flutterfire configure --project={your-project-name} # set up firebase config on you flutter app
    ```

5. WeHavit 실행
    Run and enjoy. 😊

    ```bash
    flutter run
    ```


# License

MIT
