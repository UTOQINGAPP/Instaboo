import 'package:flutter/material.dart';

/// Dialog content widget that displays the software license information for Instaboo.
/// Contenedor del diálogo que muestra la información de licencia de software de Instaboo.
class LicensesDialogHome extends StatelessWidget {
  /// Creates the licenses dialog content.
  /// Crea el contenido del diálogo de licencias.
  const LicensesDialogHome({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: colorScheme.surface,
          elevation: 8,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 520,
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildHeader(context, textTheme),
                const Divider(height: 1),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Instaboo',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '© 2026 Diego Moreano Merino (Utoqingapp)',
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Este software utiliza código distribuido bajo la Licencia MIT.\n'
                          'Puede consultar el texto completo de la licencia en el archivo LICENSE\n'
                          'incluido con el proyecto.',
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Instaboo es una herramienta diseñada para facilitar la instalación y\n'
                          'gestión de software en equipos informáticos.',
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'El nombre Instaboo y su distribución oficial pertenecen a su autor.',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the dialog header with title and close button.
  /// Construye la cabecera del diálogo con título y botón de cierre.
  Widget _buildHeader(BuildContext context, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 8, 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Licencia de software',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            tooltip: 'Cerrar',
          ),
        ],
      ),
    );
  }
}