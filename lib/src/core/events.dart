import 'dart:html' as html;
import 'dart:math';

import 'package:dawn/widgets.dart';

import 'build_context.dart';

/// The callback function of events.
typedef EventCallback<T extends EventDetails> = void Function(
  T details,
);

/// The details of the fired event.
class EventDetails<T extends html.Event> {
  final Node _targetNode;
  final T _event;

  /// Creates a new instance of [EventDetails].
  const EventDetails(this._event, {required final Node targetNode})
      : _targetNode = targetNode;

  /// The [Widget] in the tree that fired this event.
  Widget get targetWidget => _targetNode.widget;

  /// The [State] of the [Widget] in the tree that fired this event.
  State? get targetState {
    if (_targetNode is StatefulNode) {
      return (_targetNode as StatefulNode).state;
    } else {
      return null;
    }
  }

  /// The [html.Element] of the [Widget] in the tree that fired this event.
  html.Element? get targetElement {
    if (_targetNode is PaintedNode) {
      return (_targetNode as PaintedNode).element;
    } else {
      return null;
    }
  }

  /// The [BuildContext] of the [Widget] in the tree that fired this event.
  BuildContext get targetContext => _targetNode.context;
}

/// Types of pointers.
enum PointerType { mouse, pen, touch }

/// The callback function of pointer events.
typedef PointerEventCallback<T extends PointerEventDetails> = EventCallback<T>;

/// The details of the fired pointer event.
class PointerEventDetails extends EventDetails<html.PointerEvent> {
  /// Creates a new instance of [PointerEventDetails].
  const PointerEventDetails(super._event, {required super.targetNode});

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
