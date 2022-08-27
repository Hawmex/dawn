import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_static/shelf_static.dart';

import '../foundation/process_runner.dart';

class CompileCommand extends Command<void> {
  CompileCommand() {
    argParser
      ..addOption(
        'mode',
        abbr: 'm',
        help: 'Compilation mode.',
        allowed: {'dev', 'prod'},
        allowedHelp: {'dev': 'Development mode', 'prod': 'Production mode.'},
        defaultsTo: 'dev',
      )
      ..addFlag('serve', abbr: 's', help: 'Run a local server.')
      ..addOption(
        'port',
        abbr: 'p',
        help: 'Local server port.',
        defaultsTo: '5500',
      );
  }

  @override
  String get name => 'compile';

  @override
  String get description => 'Compiles web/ directory contents.';

  String get _compilationMode => argResults!['mode'];
  bool get _shouldServe => argResults!['serve'];
  int get _port => int.parse(argResults!['port']);

  String get _urlOpenerCommand {
    if (Platform.isFuchsia || Platform.isMacOS) {
      return 'open';
    } else if (Platform.isLinux) {
      return 'xdg-open';
    } else if (Platform.isWindows) {
      return 'start';
    } else {
      throw UnsupportedError('This platform is not supported.');
    }
  }

  @override
  Future<void> run() async {
    await _runCommand(shouldServe: _shouldServe);

    if (_compilationMode == 'dev') {
      Timer? timer;

      Directory('./web').watch(recursive: true).listen((final event) {
        timer?.cancel();
        timer = Timer(const Duration(seconds: 1), _runCommand);
      });
    }
  }

  Future<void> _runCommand({final bool shouldServe = false}) async {
    _copyFiles();
    _compile();

    if (shouldServe) await _runServer();
    if (_compilationMode == 'dev') print('\nWatching for changes...');
  }

  Future<void> _runServer() async {
    print('\nStarting server...');

    await serve(
      createStaticHandler(
        './.dawn/$_compilationMode',
        defaultDocument: 'index.html',
      ),
      InternetAddress.anyIPv4,
      _port,
      shared: true,
    );

    print('\x1B[32mServer running on http://localhost:$_port.\x1B[0m');

    runProcess(_urlOpenerCommand, ['http://localhost:$_port']);
  }

  void _copyFiles() {
    _copyFile('index.html');

    Directory('./web/assets')
        .listSync(recursive: true)
        .whereType<File>()
        .forEach(
          (final file) => _copyFile(file.path.replaceFirst('./web/', '')),
        );

    print(
      '\n\x1B[32m+\x1B[0m '
      'Copied assets and index.html to .dawn/$_compilationMode...',
    );
  }

  void _copyFile(final String basicPath) =>
      File('./.dawn/$_compilationMode/$basicPath')
        ..createSync(recursive: true)
        ..writeAsBytesSync(File('./web/$basicPath').readAsBytesSync());

  void _compile() {
    runProcess(
      'dart',
      [
        'compile',
        'js',
        'web/main.dart',
        '-o',
        '.dawn/$_compilationMode/main.dart.js',
        if (_compilationMode == 'prod') '-O3'
      ],
      throwOnError: false,
      onSuccess: () => print('\x1B[32m+\x1B[0m Compiled main.dart.'),
      onError: () => print('\x1B[31mx\x1B[0m Couldn\'t compile main.dart.'),
    );
  }
}
