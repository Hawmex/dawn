import 'package:dawn/foundation.dart';

import 'framework_widget.dart';

abstract class UserInputWidget extends FrameworkWidget {
  final EventListener? onChange;
  final EventListener? onInput;

  const UserInputWidget({
    this.onChange,
    this.onInput,
    super.style,
    super.animation,
    super.onPress,
    super.onPointerDown,
    super.onPointerUp,
    super.onPointerEnter,
    super.onPointerLeave,
    super.onPointerMove,
    super.onPointerCancel,
    super.onPointerOver,
    super.onPointerOut,
    super.onMouseDown,
    super.onMouseUp,
    super.onMouseEnter,
    super.onMouseLeave,
    super.onMouseMove,
    super.onMouseOver,
    super.onMouseOut,
    super.onTouchStart,
    super.onTouchEnd,
    super.onTouchMove,
    super.onTouchCancel,
    super.key,
  });
}
