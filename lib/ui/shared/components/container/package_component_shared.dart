import 'package:fluent_ui/fluent_ui.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/ui/shared/components/container/image_component_shared.dart';
import 'package:instaboo/ui/shared/components/container/platform_card_component_shared.dart';

class PackageComponentShared extends StatefulWidget {
  const PackageComponentShared({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.version,
    required this.platforms,
    required this.requiresInternet,
    required this.titleColor,
    this.onSelected,
    this.flyouts = true,
  });
  final ImageComponentShared image;
  final String name;
  final String description;
  final String version;
  final List<PlatformData> platforms;
  final String requiresInternet;
  final Color titleColor;
  final bool flyouts;
  final void Function(bool? value)? onSelected;

  @override
  State<PackageComponentShared> createState() => _PackageComponentSharedState();
}

class _PackageComponentSharedState extends State<PackageComponentShared> {
  bool state = false;
  final contextController = FlyoutController();
  final contextAttachKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapUp: (d) {
        // This calculates the position of the flyout according to the parent navigator
        final targetContext = contextAttachKey.currentContext;
        if (targetContext == null) return;
        final box = targetContext.findRenderObject() as RenderBox;
        final position = box.localToGlobal(
          d.localPosition,
          ancestor: Navigator.of(context).context.findRenderObject(),
        );
        if (!widget.flyouts) {
          return;
        }
        contextController.showFlyout(
          barrierColor: Colors.black.withOpacity(0.1),
          position: position,
          builder: (context) {
            return FlyoutContent(
              child: SizedBox(
                width: 205,
                child: CommandBar(
                  /// isCompact: true,
                  //compactBreakpointWidth: 100,
                  mainAxisAlignment: MainAxisAlignment.center,
                  primaryItems: [
                    CommandBarButton(
                      icon: const Icon(FluentIcons.edit),
                      label: const Text('Editar'),
                      onPressed: () {},
                    ),
                    CommandBarButton(
                      icon: const Icon(FluentIcons.delete),
                      label: const Text('Eliminar'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: FlyoutTarget(
        key: contextAttachKey,
        controller: contextController,
        child: ListTile(
          leading: widget.image,
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Version:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.version,
                    style: TextStyle(fontWeight: FontWeight.w100),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Requiere internet:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.requiresInternet,
                    style: TextStyle(fontWeight: FontWeight.w100),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plataformas Compatibles:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: List.generate(
                      widget.platforms.length,
                      (index) {
                        return PlatformCardComponentShared(
                          icon: FluentIcons.system,
                          name: widget.platforms[index].name,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descripcion:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ],
          ),
          trailing: Checkbox(
            checked: state,
            content: Text('Selecionar'),
            onChanged: (bool? value) {
              setState(() => state = value!);
              widget.onSelected?.call(state);
            },
          ),
        ),
      ),
    );
  }
}
