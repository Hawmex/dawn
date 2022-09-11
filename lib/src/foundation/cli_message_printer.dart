enum CliMessageType { none, success, error }

void printCliMessage(
  final String message, {
  final CliMessageType type = CliMessageType.none,
  final bool listItem = false,
}) {
  const green = '\x1B[32m';
  const red = '\x1B[31m';
  const normal = '\x1B[0m';

  late final String prefix;
  late final String color;

  if (listItem) {
    switch (type) {
      case CliMessageType.success:
        prefix = '+';
        break;
      case CliMessageType.error:
        prefix = 'x';
        break;
      case CliMessageType.none:
        prefix = '-';
        break;
    }
  } else {
    prefix = '';
  }

  switch (type) {
    case CliMessageType.success:
      color = green;
      break;
    case CliMessageType.error:
      color = red;
      break;
    case CliMessageType.none:
      color = normal;
      break;
  }

  if (listItem) {
    print('\t$color$prefix $normal$message');
  } else {
    print('\n$color$prefix$message\n');
  }
}
