import 'package:flutter/material.dart';

/// Dialog content widget that displays open source software information for Instaboo.
/// Contenedor del diálogo que muestra la información de software de código abierto de Instaboo.
class OpenSourceSoftwareInformationDialogHome extends StatelessWidget {
  /// Creates the open source software information dialog content.
  /// Crea el contenido del diálogo de información de software de código abierto.
  const OpenSourceSoftwareInformationDialogHome({super.key});

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
                          '1. Introducción',
                          'Instaboo utiliza componentes y bibliotecas de **software de '
                              'código abierto** desarrolladas por terceros.\\n\\n'
                              'Estos componentes permiten mejorar la funcionalidad, '
                              'estabilidad y desarrollo del software.\\n\\n'
                              'Agradecemos a las comunidades y desarrolladores que '
                              'contribuyen al ecosistema de software libre y de código '
                              'abierto.',
                        ),
                        _section(
                          textTheme,
                          '2. Licencias de software de terceros',
                          'Los componentes de código abierto utilizados en Instaboo se '
                              'distribuyen bajo sus respectivas licencias.\\n\\n'
                              'Estas licencias pueden incluir, entre otras:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'MIT License',
                            'Apache License 2.0',
                            'BSD License',
                            'otras licencias de código abierto compatibles',
                          ],
                        ),
                        _paragraph(
                          textTheme,
                          'Cada uno de estos componentes mantiene **sus propios términos '
                              'de licencia**, los cuales deben ser respetados por los '
                              'usuarios y desarrolladores.',
                        ),
                        _section(
                          textTheme,
                          '3. Uso de bibliotecas externas',
                          'Instaboo puede utilizar bibliotecas externas para proporcionar '
                              'distintas funcionalidades del software.\\n\\n'
                              'Estas bibliotecas pueden incluir herramientas relacionadas con:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'interfaz de usuario',
                            'gestión del sistema',
                            'manejo de archivos',
                            'utilidades de programación',
                            'otras funciones técnicas necesarias para el funcionamiento de la aplicación',
                          ],
                        ),
                        _section(
                          textTheme,
                          '4. Derechos de los autores originales',
                          'Todos los derechos sobre los componentes de código abierto '
                              'utilizados pertenecen a **sus respectivos autores y '
                              'titulares de derechos**.\\n\\n'
                              'El uso de dichos componentes dentro de Instaboo se realiza '
                              'conforme a los términos establecidos en sus respectivas '
                              'licencias.',
                        ),
                        _section(
                          textTheme,
                          '5. Acceso a las licencias',
                          'Las licencias completas de los componentes de código abierto '
                              'utilizados en Instaboo pueden encontrarse en:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'la documentación oficial de cada proyecto',
                            'los repositorios de los respectivos proyectos',
                            'los archivos de licencia incluidos en dichas bibliotecas',
                          ],
                        ),
                        _section(
                          textTheme,
                          '6. Agradecimientos',
                          'Instaboo reconoce y agradece el trabajo de las comunidades de '
                              'software libre y de código abierto cuyos proyectos hacen '
                              'posible el desarrollo de esta aplicación.',
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
              'Información de Software de Código Abierto',
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