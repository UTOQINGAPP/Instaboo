import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A chip-based input widget for managing silent installer arguments.
/// Each argument is displayed as an individual chip that can be deleted.
///
/// Widget de entrada basado en chips para gestionar argumentos silenciosos.
/// Cada argumento se muestra como un chip individual que puede eliminarse.
class SilentArgsChipInputShared extends StatefulWidget {
  /// Initial list of arguments. May be passed as a joined string or a list.
  /// Lista inicial de argumentos. Puede pasarse como string unido o como lista.
  final String initialValue;

  /// Called whenever the list of args changes.
  /// Se llama cada vez que la lista de args cambia.
  final ValueChanged<String> onChanged;

  /// Optional label shown above the widget.
  /// Etiqueta opcional mostrada encima del widget.
  final String label;

  /// Optional hint shown inside the add-argument field.
  /// Sugerencia opcional mostrada dentro del campo de agregar argumento.
  final String hint;

  const SilentArgsChipInputShared({
    super.key,
    this.initialValue = '',
    required this.onChanged,
    this.label = 'Argumentos silenciosos',
    this.hint = 'Ej: /S  y presiona Enter',
  });

  /// Splits a joined args string into individual tokens.
  /// Divide un string de args unido en tokens individuales.
  static List<String> parse(String value) =>
      value.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();

  /// Joins individual tokens into a single args string.
  /// Une tokens individuales en un solo string de args.
  static String join(List<String> args) => args.join(' ');

  @override
  State<SilentArgsChipInputShared> createState() =>
      _SilentArgsChipInputSharedState();
}

class _SilentArgsChipInputSharedState
    extends State<SilentArgsChipInputShared> {
  late final List<String> _args;
  late final TextEditingController _inputController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _args = SilentArgsChipInputShared.parse(widget.initialValue);
    _inputController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addArg(String raw) {
    final tokens = SilentArgsChipInputShared.parse(raw);
    if (tokens.isEmpty) return;
    setState(() {
      for (final t in tokens) {
        if (!_args.contains(t)) _args.add(t);
      }
    });
    _inputController.clear();
    _focusNode.requestFocus();
    widget.onChanged(SilentArgsChipInputShared.join(_args));
  }

  void _removeArg(int index) {
    setState(() => _args.removeAt(index));
    widget.onChanged(SilentArgsChipInputShared.join(_args));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Label ──────────────────────────────────────────────────────────
        Text(
          widget.label,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),

        // ── Chip container ─────────────────────────────────────────────────
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline),
            borderRadius: BorderRadius.circular(12),
            color: colorScheme.surfaceContainerLowest,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chips
              if (_args.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: List.generate(_args.length, (i) {
                    return Chip(
                      label: Text(
                        _args[i],
                        style: textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      deleteIcon: const Icon(Icons.close, size: 14),
                      onDeleted: () => _removeArg(i),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: colorScheme.secondaryContainer,
                      deleteIconColor: colorScheme.onSecondaryContainer,
                      labelStyle: TextStyle(
                        color: colorScheme.onSecondaryContainer,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
              ],

              // ── Input row ───────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: KeyboardListener(
                      focusNode: FocusNode(),
                      onKeyEvent: (event) {
                        if (event is KeyDownEvent &&
                            event.logicalKey == LogicalKeyboardKey.enter) {
                          _addArg(_inputController.text);
                        }
                      },
                      child: TextField(
                        controller: _inputController,
                        focusNode: _focusNode,
                        style: textTheme.bodyMedium?.copyWith(
                          fontFamily: 'monospace',
                        ),
                        decoration: InputDecoration(
                          hintText: _args.isEmpty ? widget.hint : 'Agregar otro argumento…',
                          hintStyle: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onSubmitted: _addArg,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 100),
                    child: IconButton(
                      icon: const Icon(Icons.add_circle_outline, size: 20),
                      tooltip: 'Agregar argumento',
                      onPressed: () => _addArg(_inputController.text),
                      color: colorScheme.primary,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── Empty hint ─────────────────────────────────────────────────────
        if (_args.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              'Sin argumentos configurados',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}
