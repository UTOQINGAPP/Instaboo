import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instaboo/interface/shared/components/components_shared.dart';

/// Generic software item card.
/// Supports three modes via flags:
///   - editable/deletable (library use): shows edit + delete buttons
///   - selectable (installer use): shows a checkbox
///   - read-only (history/preview): no trailing widget
///
/// Tarjeta genérica de ítem de software.
/// Soporta tres modos mediante flags:
///   - editable/eliminable (uso en biblioteca): muestra botones editar + eliminar
///   - seleccionable (uso en instalador): muestra un checkbox
///   - solo lectura (historial/preview): sin widget trailing
class ItemSoftwareComponentShared extends StatefulWidget {
  final String logoPath;
  final String name;
  final String description;
  final List<String> categories;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isEditableAndDeletable;
  final bool isSelectable;
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onTap;

  /// If non-null, shows an "Instalado" badge with the version (NF-04).
  /// Si no es null, muestra un badge "Instalado" con la versión (NF-04).
  final String? installedVersion;

  const ItemSoftwareComponentShared({
    super.key,
    required this.logoPath,
    required this.name,
    required this.description,
    required this.categories,
    this.onEdit,
    this.onDelete,
    this.isEditableAndDeletable = true,
    this.isSelectable = false,
    this.value,
    this.onChanged,
    this.onTap,
    this.installedVersion,
  });

  @override
  State<ItemSoftwareComponentShared> createState() =>
      _ItemSoftwareComponentSharedState();
}

class _ItemSoftwareComponentSharedState
    extends State<ItemSoftwareComponentShared> {
  @override
  void initState() {
    super.initState();
    if (widget.isSelectable) {
      if (widget.value == null) {
        throw Exception(
          'value is required when isSelectable is true',
        );
      }
    }
    if (widget.isEditableAndDeletable) {
      if (widget.onEdit == null) {
        throw Exception('onEdit is required when isEditableAndDeletable is true');
      }
      if (widget.onDelete == null) {
        throw Exception(
            'onDelete is required when isEditableAndDeletable is true');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: Colors.white.withValues(alpha: 0.1),
      child: ListTile(
        leading: widget.logoPath.contains('assets')
            ? Image.asset(widget.logoPath)
            : Image.file(
                File(widget.logoPath),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
        title: Text(
          widget.name,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Installed badge (NF-04)
            if (widget.installedVersion != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle,
                      size: 13, color: Color(0xFF4CAF50)),
                  const SizedBox(width: 4),
                  Text(
                    widget.installedVersion!.isNotEmpty
                        ? 'Instalado v${widget.installedVersion}'
                        : 'Instalado',
                    style: textTheme.labelSmall?.copyWith(
                      color: const Color(0xFF4CAF50),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
            Text(
              widget.description,
              style: textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                widget.categories.length,
                (index) =>
                    CustomTagComponentShared(label: widget.categories[index]),
              ),
            ),
          ],
        ),
        trailing: widget.isEditableAndDeletable
            ? _buttonsEditAndDelete()
            : widget.isSelectable
                ? _checkbox()
                : null,
        onTap: widget.onTap,
      ),
    );
  }

  Checkbox _checkbox() {
    return Checkbox(
      value: widget.value,
      onChanged: (value) => widget.onChanged?.call(value ?? false),
    );
  }

  Row _buttonsEditAndDelete() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButtonComponentShared(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Colors.white.withValues(alpha: .5),
            ),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          onPressed: widget.onEdit,
          child: const Icon(Icons.edit),
        ),
        const SizedBox(width: 10),
        CustomElevatedButtonComponentShared(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Colors.white.withValues(alpha: .5),
            ),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          onPressed: widget.onDelete,
          child: const Icon(Icons.delete),
        ),
      ],
    );
  }
}
