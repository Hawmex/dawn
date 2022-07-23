import 'content_alignment.dart';
import 'flex_direction.dart';
import 'flex_wrap.dart';
import 'grid_direction.dart';
import 'items_alignment.dart';
import 'self_alignment.dart';
import 'size.dart';

abstract class Display {
  static const Display initial = _Named('initial');
  static const Display inherit = _Named('inherit');
  static const Display unset = _Named('unset');
  static const Display revert = _Named('revert');
  static const Display revertLayer = _Named('revert-layer');

  static const Display none = _Named('none');
  static const Display contents = _Named('contents');

  const factory Display.flex({
    required final FlexDirection direction,
    final FlexWrap wrap,
    final Size gap,
    final SelfAlignment justifySelf,
    final ItemsAlignment justifyItems,
    final ContentAlignment justifyContent,
    final SelfAlignment alignSelf,
    final ItemsAlignment alignItems,
    final ContentAlignment alignContent,
  }) = _Flex;

  const factory Display.grid({
    required final GridDirection direction,
    final List<Size> rowsTemplate,
    final List<Size> columnsTemplate,
    final Size gap,
    final SelfAlignment justifySelf,
    final ItemsAlignment justifyItems,
    final ContentAlignment justifyContent,
    final SelfAlignment alignSelf,
    final ItemsAlignment alignItems,
    final ContentAlignment alignContent,
  }) = _Grid;

  Map<String, String> toMap();
}

class _Named with Display {
  final String name;

  const _Named(this.name);

  @override
  Map<String, String> toMap() => {'display': name};
}

class _Flex with Display {
  final FlexDirection direction;
  final FlexWrap? wrap;
  final Size? gap;
  final SelfAlignment? justifySelf;
  final ItemsAlignment? justifyItems;
  final ContentAlignment? justifyContent;
  final SelfAlignment? alignSelf;
  final ItemsAlignment? alignItems;
  final ContentAlignment? alignContent;

  const _Flex({
    required this.direction,
    this.wrap,
    this.gap,
    this.justifySelf,
    this.justifyItems,
    this.justifyContent,
    this.alignSelf,
    this.alignItems,
    this.alignContent,
  });

  @override
  Map<String, String> toMap() {
    return {
      'display': 'flex',
      'flex-direction': '$direction',
      if (wrap != null) 'flex-wrap': '$wrap',
      if (gap != null) 'gap': '$gap',
      if (justifySelf != null) 'justify-self': '$justifySelf',
      if (justifyItems != null) 'justify-items': '$justifyItems',
      if (justifyContent != null) 'justify-content': '$justifyContent',
      if (alignSelf != null) 'align-self': '$alignSelf',
      if (alignItems != null) 'align-items': '$alignItems',
      if (alignContent != null) 'align-content': '$alignContent',
    };
  }
}

class _Grid with Display {
  final GridDirection direction;
  final List<Size>? rowsTemplate;
  final List<Size>? columnsTemplate;
  final Size? gap;
  final SelfAlignment? justifySelf;
  final ItemsAlignment? justifyItems;
  final ContentAlignment? justifyContent;
  final SelfAlignment? alignSelf;
  final ItemsAlignment? alignItems;
  final ContentAlignment? alignContent;

  const _Grid({
    required this.direction,
    this.rowsTemplate,
    this.columnsTemplate,
    this.gap,
    this.justifySelf,
    this.justifyItems,
    this.justifyContent,
    this.alignSelf,
    this.alignItems,
    this.alignContent,
  });

  @override
  Map<String, String> toMap() {
    return {
      'display': 'grid',
      'grid-auto-flow': '$direction',
      if (rowsTemplate != null) 'grid-template-rows': rowsTemplate!.join(' '),
      if (columnsTemplate != null)
        'grid-template-columns': columnsTemplate!.join(' '),
      if (gap != null) 'gap': '$gap',
      if (justifySelf != null) 'justify-self': '$justifySelf',
      if (justifyItems != null) 'justify-items': '$justifyItems',
      if (justifyContent != null) 'justify-content': '$justifyContent',
      if (alignSelf != null) 'align-self': '$alignSelf',
      if (alignItems != null) 'align-items': '$alignItems',
      if (alignContent != null) 'align-content': '$alignContent',
    };
  }
}
