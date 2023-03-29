import 'dart:html' as html;
import 'dart:math';

import 'package:dawn/widgets.dart';

import 'build_context.dart';

typedef EventCallback<T extends EventDetails> = void Function(
  T details,
);

class EventDetails<T extends html.Event> {
  final Node _targetNode;
  final T _event;

  const EventDetails(this._event, {required final Node targetNode})
      : _targetNode = targetNode;

  /// The widget in the tree that fired this ref.
  Widget get targetWidget => _targetNode.widget;

  /// The state of the widget in the tree that fired this event.
  State? get targetState {
    if (_targetNode is StatefulNode) {
      return (_targetNode as StatefulNode).state;
    } else {
      return null;
    }
  }

  /// The element of the widget in the tree that fired this event.
  html.Element? get targetElement {
    if (_targetNode is PaintedNode) {
      return (_targetNode as PaintedNode).element;
    } else {
      return null;
    }
  }

  /// The context of the widget in the tree that fired this event.
  BuildContext get targetContext => _targetNode.context;
}

enum PointerType { mouse, pen, touch }

typedef PointerEventCallback<T extends PointerEventDetails> = EventCallback<T>;

class PointerEventDetails extends EventDetails<html.PointerEvent> {
  PointerEventDetails(super._event, {required super.targetNode});

  int get pointerId => _event.pointerId!;

  PointerType get pointerType {
    switch (_event.pointerType!) {
      case 'mouse':
        return PointerType.mouse;
      case 'pen':
        return PointerType.pen;
      case 'touch':
        return PointerType.touch;
      default:
        throw RangeError('Pointer type must be "mouse", "pen", or "touch".');
    }
  }

  bool get isPrimary => _event.isPrimary!;

  Point get localPosition => _event.client;
  Point get globalPosition => _event.screen;
  Point get delta => _event.movement;

  int get buttons => _event.buttons!;

  bool get altKey => _event.altKey;
  bool get ctrlKey => _event.ctrlKey;

  num get width => _event.width!;
  num get height => _event.height!;

  num get pressure => _event.pressure!;

  int get tiltX => _event.tiltX!;
  int get tiltY => _event.tiltY!;

  int get twist => _event.twist!;
}
