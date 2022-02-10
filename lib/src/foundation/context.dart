// TODO: Find a way to properly implement context.

import 'dart:convert';

class Context {}

class ChildEntry {
  final String widget;
  final List<ChildEntry> children;

  const ChildEntry({required this.widget, required this.children});

  @override
  String toString() => toJson().toString();

  Map<String, dynamic> toJson() => {
        'widget': widget,
        'children': children,
      };
}

void main() => print(
      const JsonEncoder.withIndent('  ').convert(
        const [
          ChildEntry(
            widget: 'A',
            children: [
              ChildEntry(
                widget: 'BB',
                children: [],
              ),
              ChildEntry(
                widget: 'CC',
                children: [],
              ),
            ],
          ),
        ],
      ),
    );
