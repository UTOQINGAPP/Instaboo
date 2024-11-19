import 'package:fluent_ui/fluent_ui.dart';

// ItemListComponentShared is a simple reusable widget that displays an item in a list format.
// It consists of a radio bullet icon and a text label, making it suitable for use in lists or selection dialogs.


class ItemListComponentShared extends StatelessWidget {
  final String label;
  const ItemListComponentShared({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(FluentIcons.radio_bullet),
        Text(
          label,
        ),
      ],
    );
  }
}
