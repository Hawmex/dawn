import 'package:args/command_runner.dart';
import 'package:dawn/src/commands/compile_command.dart';
import 'package:dawn/src/commands/create_command.dart';

void main(final List<String> args) =>
    CommandRunner('dawn', 'The command-line interface for Dawn.')
      ..addCommand(CreateCommand())
      ..addCommand(CompileCommand())
      ..run(args);
