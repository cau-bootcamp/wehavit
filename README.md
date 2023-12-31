# We Havit

This is a flutter project designed to cultivate habits based on praise and encouragement.

## Features

- Set and track your goal
- Friend request
- Upload confirm post with friends at 10pm (REALTIME!)
- Dynamic and fun reactions
  - Instant Photo
  - Emoji
  - Text
- Secret gift (Will be added soon)
- ...

## Project Development

### Installation

1. Git Clone 
    
    ```bash
    $ git clone https://github.com/cau-bootcamp/wehavit.git 
    $ cd wehavit
    ```

2. Install the dependencies

    ```bash
    flutter pub get
    ```

3. Setup Firebase App
    Install firebase cli tool: https://firebase.google.com/docs/cli?hl=ko#setup_update_cli
   
    ```bash
    $ firebase login # login to firebase
    $ firebase projects:create {your-project-name} # create new project
    $ dart pub global activate flutterfire_cli # install flutterfire cli
    $ flutterfire configure --project={your-project-name} # set up firebase config on you flutter app
    ```

5. Run wehavit
    Run and enjoy. 😊

    ```bash
    flutter run
    ```
### Structure

In the development of our Flutter project, we heavily relied on the Clean Architecture when structuring our codebase. We organized various features into separate folders, namely domain, data, and presentation, to facilitate effective management.

### Development

#### Test

```bash
# Test all
$ flutter test

# Test file
$ flutter test test/{file_name}
```

#### Lint

You can inspect the lint rules we have set up using the following commands:

```bash
flutter analyze
```

#### Pub run build

We aimed to minimize the time spent generating boilerplate using the build runner in Flutter. The packages dependent on the build runner include `go_router`, `riverpod`, and `freezed`. We recommend running the build runner in the background as you develop, following command below.

```bash
flutter pub run build_runner watch
```

This will minimize the time required to generate boilerplate code while you continue with your development.

### Versions and Dependencies

#### Flutter Version

Flutter `3.13.6`

#### Flutter Packages

- State Management: Flutter Riverpod `>= 2.0`
- Routing: go_router `>= 12.1.1`
- Camera: camera `>= 0.10.5+5`
- Animation: flutter_animate `>= 4.2.0+1`
- Remote Server: firebase_core `>= 2.23.0`
- Chart: syncfusion_flutter_charts `>= ^23.1.44`, syncfusion_flutter_gauges `>= 23.1.44`
- Utils: freezed_annotation `>= 2.4.1`, json_annotation `>= 4.8.1`, font_awesome_flutter `>= 10.6.0`, equatable `>= 2.0.5`, fpdart `>= 1.1.0`, uuid `>= 4.2.1`, ...

## License

MIT
