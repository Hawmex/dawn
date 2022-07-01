# dawn

<img src="./example/web/assets/logo.svg" width="128px" height="128px">

## Description

Dawn is a Dart web package for developing UIs in a pattern similar to Flutter.

## Getting Started

1. Download the [boilterplate](https://downgit.github.io/#/home?url=https://github.com/Hawmex/dawn/tree/main/example).
2. Extract the zip file into the directory you like.
3. Rename the `example` folder to whatever you want.
4. Change `pubspec.yaml` to the following spec:

   ```yaml
   name: my_project_name
   description: A Dawn app
   publish_to: none
   environment:
   sdk: ">=2.17.0 <3.0.0"
   ```

5. Run the following commands:

   `dart pub add dawn`

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

_NOTE: To compile for production, run `./scripts/prod.bat`. You can find the production-ready output in `.dawn/prod`._

## Dawn Reference

Dawn provides the following basic widgets:

- `Text`
- `Image`
- `Video`
- `Container`
- `Input`
- `Textbox`

## How Dawn Works

- Dawn lets you write your front-end in Dart with a syntax similar to Flutter.
- It's compiled to a JavaScript file which is included in `index.html`.
- Dawn handles reactivity and widget structure with a virtual node tree.
