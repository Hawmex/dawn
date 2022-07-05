# dawn

<img src="https://raw.githubusercontent.com/Hawmex/dawn/main/example/web/assets/logo.svg" width="128px" height="128px" />

## Description

Dawn is a Dart Web package that provides basic classes like `StatelessWidget` similar to Flutter,
but with a different implementation. It compiles to JavaScript and paints the UI using HTML and CSS.

[Example](https://github.com/Hawmex/dawn/blob/main/example/web/main.dart)
|
[Reference](https://pub.dev/documentation/dawn/latest/dawn/dawn-library.html)

## Getting Started

1. ### Installation

   `dart pub global activate dawn`

2. ### Setup

   `dawn create my_awesome_app`

3. ### Build For Development

   `dawn compile`

   To run with development server:

   `dawn compile -s`

   **After Step 3, you will see this page on your browser:**

   <img src="https://raw.githubusercontent.com/Hawmex/dawn/main/example/web/assets/example.gif" width="100%" />

4. ### Build For Production

   `dawn compile -m prod`

## Why Dawn Exists

- I really like Flutter's approach (`StatelessWidget`, `StatefulWidget`, `State<T>`, etc.),
  but I didn't find it easy at all to develop custom UIs in Flutter compared to
  HTML and CSS. See [this issue on GitHub](https://github.com/flutter/flutter/issues/97496).
- Flutter web is great but it hugely suffers from initial loading performance.

I decided to make something that has the best of both worlds.
The ease of developing custom UIs quickly with the elegant approach of Flutter,
without compromising the performance.
