import 'package:dawn/src/widgets/framework_widget.dart';
import 'package:dawn/src/widgets/widget.dart';

/// A widget to wrap multiple widgets as children. An implementation of
/// `<div />`.
class Container extends FrameworkWidget {
  final List<Widget> children;

  const Container({
    required this.children,
    super.onPointerDown,
    super.onPointerUp,
    super.onPointerEnter,
    super.onPointerLeave,
    super.onPress,
    super.style,
    super.animation,
    super.key,
  });
}
