import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:dawn/src/commands/create_command.dart';
import 'package:dawn/src/core/cli_message_printer.dart';
import 'package:dawn/src/core/package_version.dart';

class DawnCommandRunner extends CommandRunner<int> {
  DawnCommandRunner() : super('dawn', 'Manage your Dawn app development') {
    argParser.addFlag('version', help: 'Print Dawn version.', negatable: false);

    addCommand(CreateCommand());
  }

  @override
  Future<int?> run(final Iterable<String> args) async {
    try {
      await super.run(args);
      return 0;
    } on UsageException catch (e) {
      print('${e.message}\n${e.usage}');
      return 1;
    } catch (e, st) {
      print('$e\n$st');
      return 1;
    }
  }

  @override
  Future<int?> runCommand(final ArgResults topLevelResults) async {
    final shouldPrintVersion = topLevelResults['version'] as bool;

    if (shouldPrintVersion) {
      printCliMessage('Dawn version: $packageVersion');
      return 0;
    } else {
      return super.runCommand(topLevelResults);
    }
  }
}
