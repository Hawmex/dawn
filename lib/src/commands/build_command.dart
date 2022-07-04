import 'dart:io';

import 'package:dawn/src/commands.dart';

class BuildCommand extends Command {
  late final int optimizationLevel;

  BuildCommand() : super('build');

  @override
  void run(final List<String> parameters) {
    optimizationLevel = int.parse(parameters[0]);

    copyFile('index.html');

    Directory('./web/assets')
        .listSync(recursive: true)
        .whereType<File>()
        .forEach(
          (final file) => copyFile(file.path.replaceFirst('./web/', '')),
        );

    Process.run(
      'dart',
      'compile js web/main.dart -o .dawn/prod/main.dart.js -m -O$optimizationLevel'
          .split(' '),
    );
  }

  void copyFile(final String basicPath) => File('./.dawn/prod/$basicPath')
    ..createSync(recursive: true)
    ..writeAsBytesSync(File('./web/$basicPath').readAsBytesSync());
}
