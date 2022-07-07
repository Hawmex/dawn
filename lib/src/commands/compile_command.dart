import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_static/shelf_static.dart';

class CompileCommand extends Command<void> {
  CompileCommand() {
    argParser
      ..addOption(
        'mode',
        abbr: 'm',
        help: 'Compilation mode.',
        allowed: {'dev', 'prod'},
        allowedHelp: {
          'dev': 'Development mode',
          'prod': 'Production mode.',
        },
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

  String get compilationMode => argResults!['mode'];
  bool get shouldServe => argResults!['serve'];
  int get port => int.parse(argResults!['port']);

  @override
  Future<void> run() async {
    await runCommand(withServer: shouldServe);

    if (compilationMode == 'dev') {
      Timer? timer;

      Directory('./web').watch(recursive: true).listen((final event) {
        timer?.cancel();
        timer = Timer(const Duration(seconds: 1), runCommand);
      });
    }
  }

  Future<void> runCommand({final bool withServer = false}) async {
    copyFiles();
    compile();

    if (withServer) await runServer();

    if (compilationMode == 'dev') {
      print('\nWatching for changes...');
    }
  }

  Future<void> runServer() async {
    print('\nStarting server...');

    await serve(
      createStaticHandler(
        './.dawn/$compilationMode',
        defaultDocument: 'index.html',
      ),
      InternetAddress.anyIPv4,
      port,
      shared: true,
    );

    print('\x1B[32mServer running on http://localhost:$port.\x1B[0m');

    Process.runSync('start', ['http://localhost:$port'], runInShell: true);
  }

  void copyFiles() {
    copyFile('index.html');

    Directory('./web/assets')
        .listSync(recursive: true)
        .whereType<File>()
        .forEach(
          (final file) => copyFile(file.path.replaceFirst('./web/', '')),
        );

    print(
      '\n\x1B[32m+\x1B[0m '
      'Copied assests and index.html to .dawn/$compilationMode...',
    );
  }

  void copyFile(final String basicPath) =>
      File('./.dawn/$compilationMode/$basicPath')
        ..createSync(recursive: true)
        ..writeAsBytesSync(File('./web/$basicPath').readAsBytesSync());

  void compile() {
    Process.runSync(
      'dart',
      [
        'compile',
        'js',
        'web/main.dart',
        '-o',
        '.dawn/$compilationMode/main.dart.js',
        if (compilationMode == 'prod') '-O3'
      ],
      runInShell: true,
    );

    print('\x1B[32m+\x1B[0m Compiled main.dart.');
  }
}
