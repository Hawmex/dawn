import 'package:dawn/src/commands.dart';
import 'package:dawn/src/commands/watch_command.dart';

void main(final List<String> arguments) {
  CommandManager(arguments, [
    CreateCommand(),
    BuildCommand(),
    WatchCommand(),
  ]).match();
}
