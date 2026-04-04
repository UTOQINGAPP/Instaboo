import 'package:flutter/material.dart';

/// Dialog content widget that displays the Disclaimer for Instaboo.
/// Contenedor del diálogo que muestra el Descargo de Responsabilidad de Instaboo.
class DisclaimerDialogHome extends StatelessWidget {
  /// Creates the disclaimer dialog content.
  /// Crea el contenido del diálogo de descargo de responsabilidad.
  const DisclaimerDialogHome({super.key});

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
              maxWidth: 640,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
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
                        _buildIntro(textTheme),
                        _section(
                          textTheme,
                          '1. Uso del software',
                          'Instaboo es una herramienta diseñada para facilitar la '
                              'instalación y gestión de software en un equipo '
                              'informático.\n\n'
                              'El uso de la aplicación es responsabilidad exclusiva del '
                              'usuario. Al utilizar Instaboo, el usuario acepta que lo '
                              'hace **bajo su propio riesgo**.',
                        ),
                        _section(
                          textTheme,
                          '2. Instalación de software de terceros',
                          'Instaboo permite ejecutar instaladores de software '
                              'desarrollados por terceros.\n\n'
                              'La aplicación **no desarrolla, modifica ni controla el '
                              'contenido de dichos programas**, y únicamente facilita su '
                              'ejecución o automatiza el proceso de instalación.\n\n'
                              'El funcionamiento, seguridad y compatibilidad de estos '
                              'programas dependen exclusivamente de sus respectivos '
                              'desarrolladores.',
                        ),
                        _section(
                          textTheme,
                          '3. Fallos de instalación',
                          'Los procesos de instalación pueden fallar debido a múltiples '
                              'factores, incluyendo:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'incompatibilidad del sistema',
                            'dependencias faltantes',
                            'errores del instalador',
                            'conflictos con software existente',
                            'configuraciones del sistema',
                          ],
                        ),
                        _paragraph(
                          textTheme,
                          'Instaboo **no garantiza que todos los programas se instalen '
                              'correctamente en todos los equipos**.',
                        ),
                        _section(
                          textTheme,
                          '4. Daños al sistema',
                          'Los desarrolladores de Instaboo no serán responsables por:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'daños al sistema operativo',
                            'pérdida de datos',
                            'conflictos entre programas instalados',
                            'errores derivados del uso del software',
                            'problemas ocasionados por software de terceros',
                          ],
                        ),
                        _paragraph(
                          textTheme,
                          'Se recomienda al usuario **realizar copias de seguridad de su '
                              'sistema antes de realizar instalaciones importantes**.',
                        ),
                        _section(
                          textTheme,
                          '5. Fuentes de software',
                          'Instaboo puede ejecutar instaladores provenientes de '
                              'distintas fuentes, incluyendo:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'archivos agregados por el usuario',
                            'repositorios configurados por el usuario',
                            'instaladores descargados manualmente',
                          ],
                        ),
                        _paragraph(
                          textTheme,
                          'El usuario es responsable de **verificar la procedencia y '
                              'seguridad de los instaladores utilizados**.',
                        ),
                        _section(
                          textTheme,
                          '6. Uso bajo responsabilidad del usuario',
                          'Instaboo se proporciona **"tal cual"**, sin garantías de '
                              'ningún tipo, ya sean expresas o implícitas.\n\n'
                              'El uso del software implica que el usuario acepta que el '
                              'desarrollador **no será responsable de los resultados '
                              'derivados de su utilización**.',
                        ),
                        _section(
                          textTheme,
                          '7. Recomendaciones de seguridad',
                          'Para minimizar riesgos, se recomienda:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'utilizar instaladores provenientes de fuentes oficiales',
                            'mantener el sistema operativo actualizado',
                            'verificar los programas antes de instalarlos',
                            'realizar copias de seguridad periódicas del sistema',
                          ],
                        ),
                        _section(
                          textTheme,
                          '8. Limitación general de responsabilidad',
                          'En ningún caso los desarrolladores de Instaboo serán '
                              'responsables por daños directos, indirectos, incidentales '
                              'o consecuentes derivados del uso o imposibilidad de uso '
                              'del software.',
                        ),
                        const SizedBox(height: 16),
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
              'Descargo de Responsabilidad',
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

  /// Builds the intro block (app name and last update).
  /// Construye el bloque introductorio (nombre de la app y última actualización).
  Widget _buildIntro(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Instaboo',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Última actualización: 2026',
            style: textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Builds a section with title and body text.
  /// Construye una sección con título y texto.
  Widget _section(TextTheme textTheme, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _paragraph(textTheme, body),
        ],
      ),
    );
  }

  /// Renders a paragraph, interpreting **bold** markers.
  /// Renderiza un párrafo, interpretando marcadores **negrita**.
  Widget _paragraph(TextTheme textTheme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          style: textTheme.bodyMedium,
          children: _parseBoldSpans(textTheme, text),
        ),
      ),
    );
  }

  /// Builds a bullet list.
  /// Construye una lista con viñetas.
  Widget _bulletList(TextTheme textTheme, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map(
              (String item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '• ',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: textTheme.bodyMedium,
                          children: _parseBoldSpans(textTheme, item),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  /// Parses **bold** in text and returns a list of TextSpan.
  /// Parsea **negrita** en el texto y devuelve una lista de TextSpan.
  List<TextSpan> _parseBoldSpans(TextTheme textTheme, String text) {
    final List<TextSpan> spans = <TextSpan>[];
    int start = 0;
    while (true) {
      final int open = text.indexOf('**', start);
      if (open == -1) {
        spans.add(
          TextSpan(
            text: text.substring(start),
            style: textTheme.bodyMedium,
          ),
        );
        break;
      }
      if (open > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, open),
            style: textTheme.bodyMedium,
          ),
        );
      }
      final int close = text.indexOf('**', open + 2);
      if (close == -1) {
        spans.add(
          TextSpan(
            text: text.substring(open),
            style: textTheme.bodyMedium,
          ),
        );
        break;
      }
      spans.add(
        TextSpan(
          text: text.substring(open + 2, close),
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      start = close + 2;
    }
    return spans;
  }
}