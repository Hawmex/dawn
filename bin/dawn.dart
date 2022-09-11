import 'package:args/command_runner.dart';
import 'package:dawn/src/commands/create_command.dart';

void main(final List<String> args) =>
    CommandRunner('dawn', 'The command-line interface of Dawn.')
      ..addCommand(CreateCommand())
      ..run(args);
