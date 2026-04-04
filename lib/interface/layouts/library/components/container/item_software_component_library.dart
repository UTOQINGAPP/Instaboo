import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instaboo/interface/shared/components/components_shared.dart';

class ItemSoftwareComponentLibrary extends StatefulWidget {
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
  const ItemSoftwareComponentLibrary({
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
  });

  @override
  State<ItemSoftwareComponentLibrary> createState() =>
      _ItemSoftwareComponentLibraryState();
}

class _ItemSoftwareComponentLibraryState
    extends State<ItemSoftwareComponentLibrary> {
  @override
  void initState() {
    super.initState();
    if (widget.isSelectable) {
      if (widget.value == null) {
        throw Exception(
          'Value is required when isSelectable is true and isEditableAndDeletable is false',
        );
      }
    }
    if (widget.isEditableAndDeletable) {
      if (widget.onEdit == null) {
        throw Exception('onEdit is required when isEditableAndDeletable is true');
      }
      if (widget.onDelete == null) {
        throw Exception('onDelete is required when isEditableAndDeletable is true');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.description,
              style: textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),
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
          onPressed: () {},
          child: Icon(Icons.edit),
        ),
        SizedBox(width: 10),
        CustomElevatedButtonComponentShared(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Colors.white.withValues(alpha: .5),
            ),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          onPressed: () {},
          child: Icon(Icons.delete),
        ),
      ],
    );
  }
}
