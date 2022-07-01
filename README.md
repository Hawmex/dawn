# dawn

<img src="https://raw.githubusercontent.com/Hawmex/dawn/main/example/web/assets/logo.svg" width="128px" height="128px">

## Description

Dawn is a Dart Web package that provides basic classes like `StatelessWidget` similar to Flutter,
but with a different implementation. It compiles to JavaScript and paints the UI using HTML and CSS.

## [Example](https://github.com/Hawmex/dawn/blob/main/example/web/main.dart)

## [Reference](https://pub.dev/documentation/dawn/latest/dawn/dawn-library.html)

## Why Dawn Exists

- I really like Flutter's approach (`StatelessWidget`, `StatefulWidget`, `State<T>`, etc.),
  but I didn't find it easy at all to develop custom UIs in Flutter compared to
  HTML and CSS. See [this issue on GitHub](https://github.com/flutter/flutter/issues/97496).
- Flutter web is great but it hugely suffers from initial loading performance.

I decided to make something that has the best of both worlds.
The ease of developing custom UIs quickly with the elegant approach of Flutter,
without compromising the performance.

## Getting Started

1. Download the [boilterplate](https://downgit.github.io/#/home?url=https://github.com/Hawmex/dawn/tree/main/example).
2. Extract the zip file into the directory you like.
3. Rename the `example` folder to whatever you want.
4. Change `name` and `description` in `pubspec.yaml` if you want:
5. Run the following commands:

   `dart pub remove dawn`

   `dart pub add dawn`

   `dart pub remove dawn_lints`

   `dart pub add --dev dawn_lints`

6. Run the following commands:

   `mkdir .dawn`

   `mkdir .dawn/dev`

   `mkdir .dawn/prod`

7. Run the developement mode script:

   `./scripts/dev.bat`

   _NOTE: You should have NodeJS and Nodemon installed._

8. Run "Live Server" extension on VSCode.
9. Edit `web/main.dart` and enjoy coding!

_NOTE: To compile for production, run `./scripts/prod.bat`.
You can find the production-ready output in `.dawn/prod`._
