import 'dart:io';

void runProcess(
  final String executable,
  final List<String> args, {
  final bool cancelOnError = true,
  final void Function()? onSuccess,
  final void Function()? onError,
}) {
  final processResult = Process.runSync(executable, args, runInShell: true);

  if (processResult.exitCode > 0) {
    if (onError != null) onError();

    if (cancelOnError) {
      throw '\n${processResult.stdout}';
    } else {
      print('\n${processResult.stdout}');
    }
  } else {
    if (onSuccess != null) onSuccess();
  }
}
