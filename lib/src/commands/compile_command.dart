import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_static/shelf_static.dart';

class CompileCommand extends Command<void> {
  final address = 'localhost';
  final port = 8080;

  CompileCommand() {
    argParser.addOption(
      'mode',
      abbr: 'm',
      help: 'Compilation mode.',
      allowed: {'dev', 'prod'},
      allowedHelp: {
        'dev': 'Development mode',
        'prod': 'Production mode.',
      },
      defaultsTo: 'dev',
    );

    argParser.addFlag('serve', abbr: 's', help: 'Run a local server.');
  }

  @override
  String get name => 'compile';

  @override
  String get description => 'Compiles web/ directory contents.';

  @override
  Future<void> run() async {
    await runCommand(withServer: argResults!['serve']);

    if (argResults!['mode'] == 'dev') {
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

    if (argResults!['mode'] == 'dev') {
      print('Watching for changes');
    }
  }

  Future<void> runServer() async {
    print('\nStarting server');

    await serve(
      createStaticHandler(
        './.dawn/${argResults!['mode']}',
        defaultDocument: 'index.html',
      ),
      'localhost',
      8080,
      shared: true,
    );

    print('Server running on http://$address:$port');

    Process.runSync('start', ['http://$address:$port'], runInShell: true);
  }

  void copyFiles() {
    print('\nCopying assests and index.html to .dawn/${argResults!['mode']}');

    copyFile('index.html');

    Directory('./web/assets')
        .listSync(recursive: true)
        .whereType<File>()
        .forEach(
          (final file) => copyFile(file.path.replaceFirst('./web/', '')),
        );
  }

  void copyFile(final String basicPath) =>
      File('./.dawn/${argResults!['mode']}/$basicPath')
        ..createSync(recursive: true)
        ..writeAsBytesSync(File('./web/$basicPath').readAsBytesSync());

  void compile() {
    print('Compiling main.dart');

    Process.runSync(
      'dart',
      [
        'compile',
        'js',
        'web/main.dart',
        '-o',
        '.dawn/${argResults!['mode']}/main.dart.js',
        if (argResults!['mode'] == 'prod') '-m -O3'
      ],
      runInShell: true,
    );
  }
}
