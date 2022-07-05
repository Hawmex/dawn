import 'dart:io';

import 'package:args/command_runner.dart';

class CompileCommand extends Command<void> {
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
  }

  @override
  String get name => 'compile';

  @override
  String get description => 'Compiles web/ directory contents.';

  @override
  void run() {
    copyFiles();
    compile();

    if (argResults!['mode'] == 'dev') {
      print('Watching for changes');

      Directory('./web').watch().listen((final event) {
        copyFiles();
        compile();
        print('Watching for changes');
      });
    }
  }

  void copyFiles() {
    print('Copying assests and index.html to .dawn/${argResults!['mode']}');

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

    Process.run(
      'dart',
      [
        'compile',
        'js',
        'web/main.dart',
        '-o',
        '.dawn/${argResults!['mode']}/main.dart.js',
        if (argResults!['mode'] == 'prod') '-m -O3'
      ],
    );
  }
}
