import 'package:args/command_runner.dart';
import 'package:dawn/src/commands.dart';

void main(final List<String> args) =>
    CommandRunner('dawn', 'The command-line interface for Dawn.')
      ..addCommand(CreateCommand())
      ..addCommand(CompileCommand())
      ..run(args);
