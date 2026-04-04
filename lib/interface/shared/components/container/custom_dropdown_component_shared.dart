import 'package:flutter/material.dart';

/// Model for dropdown items. Encapsulates data needed for [DropdownMenuItem].
///
/// Modelo para elementos del dropdown. Encapsula datos necesarios para [DropdownMenuItem].
class CustomDropdownItemModel<T> {
  const CustomDropdownItemModel({
    required this.value,
    required this.child,
    this.enabled = true,
    this.alignment,
  });

  /// Value of the dropdown item.
  /// Valor del elemento del dropdown.
  final T value;

  /// Widget to display as the item content.
  /// Widget a mostrar como contenido del elemento.
  final Widget child;

  /// Whether the item is enabled (can be selected).
  /// Si el elemento está habilitado (puede ser seleccionado).
  final bool enabled;

  /// Alignment of the item content.
  /// Alineación del contenido del elemento.
  final AlignmentGeometry? alignment;

  /// Creates a [DropdownMenuItem] from this model.
  /// Crea un [DropdownMenuItem] a partir de este modelo.
  DropdownMenuItem<T> toDropdownMenuItem() {
    return DropdownMenuItem<T>(
      value: value,
      enabled: enabled,
      alignment: alignment ?? AlignmentDirectional.centerStart,
      child: child,
    );
  }
}

/// Theme data for [CustomDropdownComponentShared].
/// Allows customizing label, required indicator, input decoration, and dropdown color.
///
/// Datos de tema para [CustomDropdownComponentShared].
/// Permite personalizar etiqueta, indicador de requerido, decoración del input y color del dropdown.
class CustomDropdownThemeTasks {
  const CustomDropdownThemeTasks({
    required this.labelStyle,
    required this.requiredIndicatorColor,
    required this.fillColor,
    required this.contentPadding,
    required this.borderRadius,
    required this.dropdownColor,
    this.borderSide,
    this.enabledBorderSide,
    this.focusedBorderSide,
    this.hintStyle,
  });

  /// Border side for enabled state. If null, no border is drawn.
  /// Lado del borde para estado habilitado. Si es null, no se dibuja borde.
  final BorderSide? enabledBorderSide;

  /// Text style for the label above the field.
  /// Estilo de texto para la etiqueta sobre el campo.
  final TextStyle labelStyle;

  /// Color for the asterisk when the field is required.
  /// Color del asterisco cuando el campo es requerido.
  final Color requiredIndicatorColor;

  /// Background color of the dropdown field.
  /// Color de fondo del campo dropdown.
  final Color fillColor;

  /// Inner padding of the dropdown field.
  /// Relleno interno del campo dropdown.
  final EdgeInsetsGeometry contentPadding;

  /// Border radius of the input.
  /// Radio del borde del input.
  final BorderRadius borderRadius;

  /// Background color of the dropdown menu.
  /// Color de fondo del menú dropdown.
  final Color dropdownColor;

  /// Border side for default/enabled state. If null, no border is drawn.
  /// Lado del borde para estado normal. Si es null, no se dibuja borde.
  final BorderSide? borderSide;

  /// Border side when the field is focused.
  /// Lado del borde cuando el campo tiene foco.
  final BorderSide? focusedBorderSide;

  /// Style for hint text. If null, uses a variant of label style.
  /// Estilo del texto de ayuda. Si es null, usa una variante del estilo de etiqueta.
  final TextStyle? hintStyle;

  /// Builds theme from the current app [ThemeData].
  /// Uses [InputDecorationThemeData] and [TextTheme] for defaults.
  ///
  /// Construye el tema a partir del [ThemeData] actual de la app.
  /// Usa [InputDecorationThemeData] y [TextTheme] para los valores por defecto.
  static CustomDropdownThemeTasks fromContext(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final InputDecorationThemeData inputTheme = theme.inputDecorationTheme;
    final TextTheme textTheme = theme.textTheme;

    final Color fillColor =
        inputTheme.fillColor ??
        scheme.surfaceContainerHighest.withValues(alpha: 0.5);

    final EdgeInsetsGeometry contentPadding =
        inputTheme.contentPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14);

    final OutlineInputBorder? outlineBorder =
        inputTheme.border is OutlineInputBorder
        ? inputTheme.border as OutlineInputBorder
        : null;
    final BorderRadius radius =
        outlineBorder?.borderRadius ?? BorderRadius.circular(12);

    final BorderSide? defaultSide = outlineBorder?.borderSide;
    final BorderSide focusedSide =
        inputTheme.focusedBorder is OutlineInputBorder
        ? (inputTheme.focusedBorder as OutlineInputBorder).borderSide
        : BorderSide(color: scheme.primary, width: 2);

    final BorderSide enabledSide =
        inputTheme.enabledBorder is OutlineInputBorder
        ? (inputTheme.enabledBorder as OutlineInputBorder).borderSide
        : BorderSide(color: scheme.outline.withValues(alpha: 0.5));

    return CustomDropdownThemeTasks(
      labelStyle:
          textTheme.bodyLarge?.copyWith(color: scheme.onSurface) ??
          DefaultTextStyle.of(context).style.copyWith(color: scheme.onSurface),
      requiredIndicatorColor: scheme.error,
      fillColor: fillColor,
      contentPadding: contentPadding,
      borderRadius: radius,
      dropdownColor: scheme.surfaceContainerHighest,
      borderSide: defaultSide,
      focusedBorderSide: focusedSide,
      hintStyle:
          inputTheme.hintStyle ??
          textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
          ) ??
          DefaultTextStyle.of(context).style.copyWith(
            color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
          ),
      enabledBorderSide: enabledSide,
    );
  }

  /// Input border for default state.
  /// Borde del input para estado normal.
  InputBorder get border => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: borderSide ?? BorderSide.none,
  );

  /// Input border for enabled state.
  /// Borde del input para estado habilitado.
  InputBorder get enabledBorder => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: enabledBorderSide ?? borderSide ?? BorderSide.none,
  );

  /// Input border for focused state.
  /// Borde del input para estado enfocado.
  InputBorder get focusedBorder => OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: focusedBorderSide ?? borderSide ?? BorderSide.none,
  );
}

/// Reusable dropdown field with label and optional required indicator.
/// Supports optional custom theme; otherwise uses app theme defaults.
///
/// Campo dropdown reutilizable con etiqueta e indicador opcional de requerido.
/// Admite tema personalizado opcional; si no se pasa, usa el tema actual de la app.
class CustomDropdownComponentShared<T> extends StatelessWidget {
  const CustomDropdownComponentShared({
    super.key,
    required this.label,
    required this.onChanged,
    this.items,
    this.rawItems,
    this.hint,
    this.value,
    this.required = false,
    this.theme,
    this.itemBuilder,
  }) : assert(
         items != null || (rawItems != null && itemBuilder != null),
         'Either items or rawItems with itemBuilder must be provided',
       );

  /// Label text displayed above the dropdown.
  /// Texto de etiqueta mostrado sobre el dropdown.
  final String label;

  /// List of items to display in the dropdown.
  /// Can be either a list of [CustomDropdownItemModel] or a list of values [T].
  /// If [T] is provided, [itemBuilder] must be specified to convert values to display text.
  ///
  /// Lista de elementos a mostrar en el dropdown.
  /// Puede ser una lista de [CustomDropdownItemModel] o una lista de valores [T].
  /// Si se proporciona [T], [itemBuilder] debe especificarse para convertir valores a texto.
  final List<CustomDropdownItemModel<T>>? items;

  /// List of raw values. Used when [items] is null.
  /// Lista de valores crudos. Se usa cuando [items] es null.
  final List<T>? rawItems;

  /// Callback called when an item is selected.
  /// Callback llamado cuando se selecciona un elemento.
  final ValueChanged<T?> onChanged;

  /// Hint text displayed when no item is selected.
  /// Texto de ayuda mostrado cuando no hay elemento seleccionado.
  final String? hint;

  /// Currently selected value.
  /// Valor actualmente seleccionado.
  final T? value;

  /// Whether the field is required (shows asterisk).
  /// Si el campo es requerido (muestra asterisco).
  final bool required;

  /// Optional theme for this component. If null, uses [CustomDropdownThemeTasks.fromContext].
  /// Tema opcional del componente. Si es null, usa [CustomDropdownThemeTasks.fromContext].
  final CustomDropdownThemeTasks? theme;

  /// Optional builder for dropdown items. If null, uses toString() on items.
  /// Constructor opcional para los elementos del dropdown. Si es null, usa toString() en los elementos.
  final String Function(T)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    final CustomDropdownThemeTasks resolvedTheme =
        theme ?? CustomDropdownThemeTasks.fromContext(context);

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: resolvedTheme.labelStyle,
              children: [
                if (required)
                  TextSpan(
                    text: ' *',
                    style: resolvedTheme.labelStyle.copyWith(
                      color: resolvedTheme.requiredIndicatorColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<T>(
            initialValue: value,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: hint != null ? resolvedTheme.hintStyle : null,
              filled: true,
              fillColor: resolvedTheme.fillColor,
              contentPadding: resolvedTheme.contentPadding,
              border: resolvedTheme.border,
              enabledBorder: resolvedTheme.enabledBorder,
              focusedBorder: resolvedTheme.focusedBorder,
            ),
            dropdownColor: resolvedTheme.dropdownColor,
            items: items != null
                ? items!.map((item) => item.toDropdownMenuItem()).toList()
                : rawItems!
                      .map(
                        (item) => DropdownMenuItem<T>(
                          value: item,
                          child: Text(
                            itemBuilder != null
                                ? itemBuilder!(item)
                                : item.toString(),
                          ),
                        ),
                      )
                      .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
