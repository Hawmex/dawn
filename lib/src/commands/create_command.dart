import 'dart:io';

import 'package:args/command_runner.dart';

import '../foundation/cli_message_printer.dart';
import '../foundation/process_runner.dart';

class CreateCommand extends Command<void> {
  @override
  String get name => 'create';

  @override
  String get description =>
      'Sets up a new Dawn application in the current directory.';

  @override
  String get invocation => 'dawn create <app_name>';

  String get _appName => argResults!.rest.first;

  @override
  void run() {
    if (argResults!.rest.isEmpty) {
      usageException('Specify your application\'s name.\n');
    }

    final directory = Directory('./$_appName');

    if (directory.existsSync()) {
      usageException('Directory $_appName already exists.\n');
    }

    Directory.current = directory..createSync();

    _createFiles();
    _installDependencies();

    printCliMessage('Enjoy Coding!', type: CliMessageType.success);

    printCliMessage(
      'Run the following commands:\n'
      '  cd $_appName\n'
      '  webdev serve',
    );
  }

  void _createFiles() {
    printCliMessage('Creating Files...');

    _createFile(path: './.gitignore', body: _gitIgnore);
    _createFile(path: './README.md', body: _readmeDotMd);
    _createFile(path: './pubspec.yaml', body: _pubspecDotYaml);
    _createFile(path: './analysis_options.yaml', body: _analysisOptionsDotYaml);
    _createFile(path: './web/index.html', body: _indexDotHtml);
    _createFile(path: './web/main.dart', body: _mainDotDart);
    _createFile(path: './web/assets/logo.svg', body: _logoDotSvg);
    _createFile(path: './web/assets/logo_icon.svg', body: _logoIconDotSvg);

    _createFile(
      path: './web/assets/logo_and_title.svg',
      body: _logoAndTitleDotSvg,
    );
  }

  void _createFile({
    required final String path,
    required final String body,
  }) {
    File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(body);

    printCliMessage(
      'Created $path.',
      listItem: true,
      type: CliMessageType.success,
    );
  }

  void _installDependencies() {
    printCliMessage('Installing dependencies...');

    _installDependency('dawn');
    _installDependency('dawn_lints', dev: true);
    _installDependency('build_runner', dev: true);
    _installDependency('build_web_compilers', dev: true);
  }

  void _installDependency(final String name, {final bool dev = false}) {
    runProcess(
      'dart',
      ['pub', 'add', if (dev) '-d', name],
      throwOnError: false,
      onSuccess: () => printCliMessage(
        'Installed $name.',
        listItem: true,
        type: CliMessageType.success,
      ),
      onError: () => printCliMessage(
        'Couldn\'t install $name.',
        listItem: true,
        type: CliMessageType.error,
      ),
    );
  }

  String get _gitIgnore => '''
# Files and directories created by pub.
.dart_tool/
.packages

# Conventional directory for build output.
build/
''';

  String get _readmeDotMd => '''
# $_appName

## 📖 Description

A Dawn application.

Please visit [Dawn's Website](https://dawn-dev.netlify.app) for more information.
''';

  String get _pubspecDotYaml => '''
name: $_appName
description: A Dawn app
publish_to: none
environment:
  sdk: ">=2.18.0 <3.0.0"
''';

  String get _analysisOptionsDotYaml => '''
include: package:dawn_lints/dawn_lints.yaml
''';

  String get _indexDotHtml => '''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>$_appName</title>

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

  String get _mainDotDart => '''
import 'package:dawn/dawn.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Container(
      [
        Image(
          '/assets/logo.svg',
          style: Style({'width': '128px', 'height': '128px'}),
          animation: Animation(
            keyframes: [
              Keyframe(
                offset: 0,
                style: Style({'transform': 'translateY(0px)'}),
              ),
              Keyframe(
                offset: 1,
                style: Style({'transform': 'translateY(8px)'}),
              ),
            ],
            duration: Duration(seconds: 1),
            easing: Easing(0.2, 0, 0.4, 1),
            direction: AnimationDirection.alternate,
            iterations: double.infinity,
          ),
        ),
        Text(
          'Welcome to Dawn',
          style: Style({
            'font-size': '24px',
            'font-weight': 'bold',
            'color': '#00e690',
          }),
        ),
        Container([
          Text('To get started, edit '),
          Text(
            'web/main.dart',
            style: Style({
              'font-family': 'monospace',
              'background': '#eeeeee',
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
        'text-align': 'center',
        'align-items': 'center',
        'gap': '16px',
        'padding': '16px',
        'width': '100%',
        'min-height': '100vh',
        'background': '#ffffff',
        'color': '#000000',
        'font-family': '"Jost", system-ui',
        'user-select': 'none',
      }),
    );
  }
}
''';

  String get _logoDotSvg => '''
<svg
  width="71"
  height="71"
  viewBox="0 0 71 71"
  fill="none"
  xmlns="http://www.w3.org/2000/svg"
>
  <path
    d="M32.5269 2.82843C34.089 1.26633 36.6217 1.26633 38.1838 2.82843V2.82843C39.7459 4.39052 39.7459 6.92318 38.1838 8.48528L5.65686 41.0122L2.82844 38.1838C1.26634 36.6217 1.26634 34.089 2.82844 32.5269L32.5269 2.82843Z"
    fill="#7900EA"
  />

  <path
    d="M32.8284 8.48528C31.2663 6.92318 31.2663 4.39052 32.8284 2.82843V2.82843C34.3905 1.26633 36.9232 1.26633 38.4853 2.82843L68.1838 32.5269C69.7459 34.089 69.7459 36.6217 68.1838 38.1838L65.3553 41.0122L32.8284 8.48528Z"
    fill="#7900EA"
  />

  <rect x="47" y="17" width="8" height="38" rx="4" fill="#7900EA" />
  <rect x="17" y="16" width="8" height="37" rx="4" fill="#7900EA" />
  <rect x="32" y="2" width="8" height="41" rx="4" fill="#7900EA" />
  <rect x="17" y="55" width="8" height="16" rx="4" fill="#7900EA" />
  <rect x="32" y="45" width="8" height="16" rx="4" fill="#7900EA" />
  <rect x="47" y="57" width="8" height="8" rx="4" fill="#7900EA" />
</svg>
''';

  String get _logoIconDotSvg => '''
<svg
  width="180"
  height="180"
  viewBox="0 0 180 180"
  fill="none"
  xmlns="http://www.w3.org/2000/svg"
>
  <rect width="180" height="180" rx="80" fill="#00E690" />

  <circle cx="90" cy="90" r="60" fill="white" />

  <path
    d="M86.5269 56.8284C88.089 55.2663 90.6217 55.2663 92.1838 56.8284V56.8284C93.7459 58.3905 93.7459 60.9232 92.1838 62.4853L59.6569 95.0122L56.8284 92.1838C55.2663 90.6217 55.2663 88.089 56.8284 86.5269L86.5269 56.8284Z"
    fill="#7900EA"
  />

  <path
    d="M86.8284 62.4853C85.2663 60.9232 85.2663 58.3905 86.8284 56.8284V56.8284C88.3905 55.2663 90.9232 55.2663 92.4853 56.8284L122.184 86.5269C123.746 88.089 123.746 90.6217 122.184 92.1838L119.355 95.0122L86.8284 62.4853Z"
    fill="#7900EA"
  />

  <rect x="101" y="71" width="8" height="38" rx="4" fill="#7900EA" />
  <rect x="71" y="70" width="8" height="37" rx="4" fill="#7900EA" />
  <rect x="86" y="56" width="8" height="41" rx="4" fill="#7900EA" />
  <rect x="71" y="109" width="8" height="16" rx="4" fill="#7900EA" />
  <rect x="86" y="99" width="8" height="16" rx="4" fill="#7900EA" />
  <rect x="101" y="111" width="8" height="8" rx="4" fill="#7900EA" />
</svg>
''';

  String get _logoAndTitleDotSvg => '''
<svg
  width="148"
  height="140"
  viewBox="0 0 148 140"
  fill="none"
  xmlns="http://www.w3.org/2000/svg"
>
  <path
    d="M70.5269 2.82843C72.089 1.26633 74.6217 1.26633 76.1838 2.82843V2.82843C77.7459 4.39052 77.7459 6.92318 76.1838 8.48528L43.6569 41.0122L40.8284 38.1838C39.2663 36.6217 39.2663 34.089 40.8284 32.5269L70.5269 2.82843Z"
    fill="#7900EA"
  />

  <path
    d="M70.8284 8.48528C69.2663 6.92318 69.2663 4.39052 70.8284 2.82843V2.82843C72.3905 1.26633 74.9232 1.26633 76.4853 2.82843L106.184 32.5269C107.746 34.089 107.746 36.6217 106.184 38.1838L103.355 41.0122L70.8284 8.48528Z"
    fill="#7900EA"
  />

  <rect x="85" y="17" width="8" height="38" rx="4" fill="#7900EA" />
  <rect x="55" y="16" width="8" height="37" rx="4" fill="#7900EA" />
  <rect x="70" y="2" width="8" height="41" rx="4" fill="#7900EA" />
  <rect x="55" y="55" width="8" height="16" rx="4" fill="#7900EA" />
  <rect x="70" y="45" width="8" height="16" rx="4" fill="#7900EA" />
  <rect x="85" y="57" width="8" height="8" rx="4" fill="#7900EA" />

  <path
    d="M4.22056 88.4V122H9.98056V88.4H4.22056ZM15.0686 122C18.4926 122 21.5006 121.312 24.0926 119.936C26.6846 118.528 28.7006 116.576 30.1406 114.08C31.6126 111.552 32.3486 108.592 32.3486 105.2C32.3486 101.808 31.6126 98.864 30.1406 96.368C28.7006 93.84 26.6846 91.888 24.0926 90.512C21.5006 89.104 18.4926 88.4 15.0686 88.4H7.72456V93.728H14.9246C16.5886 93.728 18.1246 93.968 19.5326 94.448C20.9406 94.928 22.1566 95.648 23.1806 96.608C24.2366 97.568 25.0526 98.768 25.6286 100.208C26.2366 101.648 26.5406 103.312 26.5406 105.2C26.5406 107.088 26.2366 108.752 25.6286 110.192C25.0526 111.632 24.2366 112.832 23.1806 113.792C22.1566 114.752 20.9406 115.472 19.5326 115.952C18.1246 116.432 16.5886 116.672 14.9246 116.672H7.72456V122H15.0686ZM40.4557 113.36H58.2157L57.1117 108.56H41.5117L40.4557 113.36ZM49.2397 97.904L54.5677 110.384L54.7117 111.776L59.2717 122H65.6557L49.2397 86.528L32.8237 122H39.2077L43.8637 111.488L43.9597 110.24L49.2397 97.904ZM95.1671 110.912L85.5191 86.72L75.9671 110.912L67.9991 88.4H61.4231L75.1511 123.776L85.5191 100.016L95.8871 123.776L109.615 88.4H103.039L95.1671 110.912ZM138.249 88.4V110.96L113.721 86.72V122H119.289V99.44L143.817 123.68V88.4H138.249Z"
    fill="#00E690"
  />
</svg>
''';
}
