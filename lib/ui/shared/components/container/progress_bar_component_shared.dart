import 'package:fluent_ui/fluent_ui.dart';

// ProgressBarComponentShared is a reusable widget that displays a progress bar with a label and a percentage value.
// It provides a visual representation of progress, with the label on the left and the percentage value on the right.
// The progress bar spans the full width of its container, making it suitable for tracking progress in various tasks.


class ProgressBarComponentShared extends StatelessWidget {
  final String label;
  final double? progress;
  const ProgressBarComponentShared(
      {super.key, required this.label, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '%${progress?.round()}',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(height: 2),
        SizedBox(
          width: double.maxFinite,
          child: ProgressBar(
            value: progress,
          ),
        ),
      ],
    );
  }
}
