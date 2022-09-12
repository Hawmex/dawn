import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dawn/src/commands/create_command.dart';

void main(final List<String> args) async {
  final runner = CommandRunner('dawn', 'The command-line interface of Dawn.')
    ..addCommand(CreateCommand());

  try {
    await runner.run(args);
    exit(0);
  } on UsageException catch (e) {
    print('${e.message}\n${e.usage}');
    exit(1);
  } catch (e, st) {
    print('$e\n$st');
    exit(1);
  }
}
