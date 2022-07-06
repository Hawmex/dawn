import 'dart:io';

import 'package:args/command_runner.dart';

class CreateCommand extends Command<void> {
  @override
  String get name => 'create';

  @override
  String get description => 'Sets up a new Dawn application.';

  String get projectName => argResults!.rest.first;

  @override
  void run() {
    Directory.current = Directory('./$projectName')..createSync();

    createFiles();
    installDependencies();

    print('\nEnjoy Coding!');
  }

  void createFiles() {
    print('\nCreating Files');

    createFile(path: './.gitignore', body: gitIgnore);
    createFile(path: './README.md', body: readmeDotMd);
    createFile(path: './pubspec.yaml', body: pubspecDotYaml);
    createFile(path: './analysis_options.yaml', body: analysisOptionsDotYaml);
    createFile(path: './web/index.html', body: indexDotHtml);
    createFile(path: './web/main.dart', body: mainDotDart);
    createFile(path: './web/assets/logo.svg', body: logoDotSvg);
  }

  void createFile({
    required final String path,
    required final String body,
  }) {
    File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(body);

    print('\t- Created $path');
  }

  void installDependencies() {
    print('\nInstalling dependencies');

    Process.runSync('dart', ['pub', 'add', 'dawn'], runInShell: true);
    print('\t- Installed dawn');

    Process.runSync(
      'dart',
      ['pub', 'add', '--dev', 'dawn_lints'],
      runInShell: true,
    );

    print('\t- Installed dawn_lints');
  }

  String get gitIgnore => '''
# Files and directories created by pub.
.dart_tool/
.packages

# Conventional directory for Dawn outputs.
.dawn/

# Omit committing pubspec.lock for library packages; see
# https://dart.dev/guides/libraries/private-files#pubspeclock.
pubspec.lock
''';

  String get readmeDotMd => '''
# $projectName

## Description

A Dawn application.

Please refer to [Dawn's Getting Started section](https://github.com/Hawmex/dawn#getting-started) for more information.
''';

  String get pubspecDotYaml => '''
name: $projectName
description: A Dawn app
publish_to: none
environment:
  sdk: ">=2.17.0 <3.0.0"
''';

  String get analysisOptionsDotYaml => '''
include: package:dawn_lints/dawn_lints.yaml
''';

  String get indexDotHtml => '''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>$projectName</title>

    <link rel="shortcut icon" href="/assets/logo.svg" type="image/x-icon" />

    <style>
      *,
      *::before,
      *::after {
        margin: 0px;
        padding: 0px;
        -webkit-tap-highlight-color: transparent;
        box-sizing: border-box;
      }
    </style>

    <script src="/main.dart.js" defer></script>
  </head>

  <body></body>
</html>
''';

  String get mainDotDart => '''
import 'package:dawn/dawn.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(final Context context) {
    return const Container(
      [
        Image(
          '/assets/logo.svg',
          style: Style({'width': '128px', 'height': '128px'}),
          animation: Animation(
            keyframes: [
              {'transform': 'scale(0.8)'},
              {'transform': 'scale(1.0)'}
            ],
            options: {
              'duration': 1000,
              'iterations': double.infinity,
              'direction': 'alternate',
              'easing': 'cubic-bezier(0.2, 0.0, 0.4, 1)',
            },
          ),
        ),
        Text(
          'Welcome to Dawn',
          style: Style({'font-size': '24px', 'font-weight': 'bold'}),
        ),
        Container([
          Text('To get started, edit '),
          Text(
            'web/main.dart',
            style: Style({
              'font-family': 'monospace',
              'background': '#232323',
              'border-radius': '4px',
              'padding': '4px',
            }),
          ),
          Text(' and save to reload.'),
        ]),
      ],
      style: Style({
        'display': 'flex',
        'flex-flow': 'column',
        'justify-content': 'center',
        'align-items': 'center',
        'gap': '16px',
        'width': '100%',
        'height': '100vh',
        'background': '#000000',
        'color': '#ffffff',
        'font-family': 'Jost, system-ui',
        'user-select': 'none',
      }),
    );
  }
}
''';

  String get logoDotSvg => '''
<svg width="264" height="265" viewBox="0 0 264 265" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M260 132C260 202.692 202.692 260 132 260C61.3075 260 4 202.692 4 132C4 61.3075 61.3075 4 132 4C202.692 4 260 61.3075 260 132Z" fill="#00B2FF" />
    <path d="M212.153 93.0361C225.967 121.346 251.831 216.101 188.298 247.101C124.765 278.101 48.1313 251.728 17.131 188.196C-13.8693 124.663 12.5034 48.0289 76.0361 17.0286C139.569 -13.9717 198.34 64.7264 212.153 93.0361Z" fill="#232323" />
    <path d="M256 132C256 200.483 200.483 256 132 256V264C204.902 264 264 204.902 264 132H256ZM132 256C63.5167 256 8 200.483 8 132H0C0 204.902 59.0984 264 132 264V256ZM8 132C8 63.5167 63.5167 8 132 8V0C59.0984 0 0 59.0984 0 132H8ZM132 8C200.483 8 256 63.5167 256 132H264C264 59.0984 204.902 0 132 0V8ZM208.558 94.7902C215.245 108.493 224.985 138.674 225.231 169.092C225.476 199.505 216.297 228.988 186.544 243.506L190.052 250.696C223.832 234.213 233.487 200.819 233.23 169.027C232.974 137.24 222.875 105.889 215.748 91.282L208.558 94.7902ZM186.544 243.506C124.997 273.538 50.7575 247.989 20.7259 186.442L13.5362 189.95C45.5052 255.468 124.534 282.665 190.052 250.696L186.544 243.506ZM20.7259 186.442C-9.30565 124.894 16.2429 50.655 77.7902 20.6235L74.282 13.4337C8.76393 45.4028 -18.4329 124.432 13.5362 189.95L20.7259 186.442ZM77.7902 20.6235C107.543 6.10577 136.431 17.0143 160.252 35.924C184.077 54.8367 201.872 81.0873 208.558 94.7902L215.748 91.282C208.621 76.6752 190.123 49.422 165.226 29.6582C140.326 9.89153 108.062 -3.04886 74.282 13.4337L77.7902 20.6235Z" fill="#232323" />
</svg>
''';
}
