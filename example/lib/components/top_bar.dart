import 'package:dawn/dawn.dart';

import 'icon_button.dart';

class TopBar extends StatelessComponent {
  final String leadingIcon;
  final String title;
  final List<Component> Function(Context context)? trailingBuilder;

  const TopBar({
    required this.leadingIcon,
    required this.title,
    this.trailingBuilder,
  }) : super();

  @override
  List<Component> render(final Context context) {
    return [
      Container(
        [
          Container(
            [
              IconButton(leadingIcon),
              Text(
                title,
                styles: const Styles([
                  'padding: 0px 16px',
                  'font-size: 20px',
                  'font-weight: 700',
                ]),
              ),
            ],
            styles: const Styles([
              'display: flex',
              'flex-flow: row',
              'align-items: center',
            ]),
          ),
          Container(
            trailingBuilder != null ? trailingBuilder!(context) : [],
            styles: const Styles([
              'display: flex',
              'flex-flow: row',
              'align-items: center',
            ]),
          )
        ],
        styles: const Styles([
          'display: flex',
          'flex-flow: row',
          'padding: 8px',
          'gap: 8px',
          'background: #212121',
          'color: #ffffff',
          'justify-content: space-between',
        ]),
      )
    ];
  }
}
