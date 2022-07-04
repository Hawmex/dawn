import 'dart:io';

import 'package:dawn/src/commands.dart';

class WatchCommand extends Command {
  WatchCommand() : super('watch');

  @override
  void run(final List<String> parameters) {
    Directory('./web').watch().listen((final event) {
      copyFile('index.html');

      Directory('./web/assets')
          .listSync(recursive: true)
          .whereType<File>()
          .forEach(
            (final file) => copyFile(file.path.replaceFirst('./web/', '')),
          );

      Process.run(
        'dart',
        'compile js web/main.dart -o .dawn/dev/main.dart.js'.split(' '),
      );
    });
  }

  void copyFile(final String basicPath) => File('./.dawn/dev/$basicPath')
    ..createSync(recursive: true)
    ..writeAsBytesSync(File('./web/$basicPath').readAsBytesSync());
}
