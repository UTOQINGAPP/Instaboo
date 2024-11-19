import 'package:fluent_ui/fluent_ui.dart';
import 'package:instaboo/ui/shared/components/container/image_component_shared.dart';

// InstallPackageComponentShared is a reusable widget that displays information about a package being installed.
// It shows the package's icon, name, progress status, and a message describing the current installation step.
// The widget includes a `ProgressRing` to visually indicate the installation progress and applies a gradient color effect to the package name.


class InstallPackageComponentShared extends StatefulWidget {
  final ImageComponentShared icon;
  final String name;
  final String message;
  final double? progress;
  final Color titleColor;
  const InstallPackageComponentShared(
      {super.key,
      required this.icon,
      required this.name,
      required this.titleColor,
      required this.message,
      this.progress});

  @override
  State<InstallPackageComponentShared> createState() =>
      _InstallPackageComponentSharedState();
}

class _InstallPackageComponentSharedState
    extends State<InstallPackageComponentShared> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.icon,
      title: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            colors: [
              widget.titleColor,
              widget.titleColor,
            ],
          ).createShader(rect);
        },
        child: Text(
          widget.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      subtitle: Text(widget.message),
      trailing: ProgressRing(
        value: widget.progress,
      ),

      //FluentIcons.status_circle_checkmark
    );
  }
}
