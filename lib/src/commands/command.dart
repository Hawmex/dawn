class CommandManager {
  final List<String> arguments;
  final List<Command> commands;

  const CommandManager(this.arguments, this.commands);

  void match() => commands
      .firstWhere((final command) => command.name == arguments[0])
      .run(arguments.sublist(1));
}

abstract class Command {
  final String name;

  const Command(this.name);

  void run(final List<String> parameters);
}
