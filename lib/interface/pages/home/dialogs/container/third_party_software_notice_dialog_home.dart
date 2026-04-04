import 'package:flutter/material.dart';

/// Dialog content widget that displays the Third-Party Software Notice for Instaboo.
/// Contenedor del diálogo que muestra el Aviso sobre Software de Terceros de Instaboo.
class ThirdPartySoftwareNoticeDialogHome extends StatelessWidget {
  /// Creates the third-party software notice dialog content.
  /// Crea el contenido del diálogo de aviso sobre software de terceros.
  const ThirdPartySoftwareNoticeDialogHome({super.key});

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
                          'Instaboo es una herramienta diseñada para facilitar la '
                              'instalación y gestión de múltiples programas desde una '
                              'única interfaz.\n\n'
                              'La aplicación permite organizar instaladores de software y '
                              'ejecutar procesos de instalación de forma manual o '
                              'automatizada.\n\n'
                              'Muchos de los programas que pueden ser instalados mediante '
                              'Instaboo son **software desarrollado y distribuido por '
                              'terceros**.',
                        ),
                        _section(
                          textTheme,
                          '2. Propiedad del software',
                          'Instaboo **no es propietario ni desarrollador del software de '
                              'terceros** que pueda instalarse mediante la aplicación.\n\n'
                              'Todos los derechos sobre dichos programas pertenecen a sus '
                              'respectivos autores o titulares de derechos.',
                        ),
                        _section(
                          textTheme,
                          '3. Licencias de software',
                          'Cada programa instalado mediante Instaboo puede estar sujeto a '
                              '**su propia licencia de uso**, la cual es definida por su '
                              'desarrollador.\n\n'
                              'Estas licencias pueden incluir, entre otras:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'licencias de software libre',
                            'licencias de código abierto',
                            'licencias comerciales',
                            'licencias propietarias',
                          ],
                        ),
                        _paragraph(
                          textTheme,
                          'El usuario es responsable de **revisar y aceptar las '
                              'condiciones de licencia correspondientes a cada programa '
                              'instalado**.',
                        ),
                        _section(
                          textTheme,
                          '4. Distribución de instaladores',
                          'Instaboo no redistribuye ni modifica el contenido del '
                              'software de terceros.\n\n'
                              'La aplicación actúa únicamente como una herramienta para:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'ejecutar instaladores',
                            'automatizar procesos de instalación',
                            'organizar bibliotecas de software',
                            'gestionar paquetes de instalación',
                          ],
                        ),
                        _paragraph(
                          textTheme,
                          'Los instaladores utilizados pueden provenir de:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'fuentes oficiales del software',
                            'repositorios configurados por el usuario',
                            'archivos agregados manualmente por el usuario',
                          ],
                        ),
                        _section(
                          textTheme,
                          '5. Instalaciones automatizadas',
                          'Instaboo puede automatizar el proceso de instalación '
                              'utilizando parámetros de instalación silenciosa o '
                              'configuraciones desatendidas cuando estas estén '
                              'disponibles.\n\n'
                              'Esta automatización no altera el código ni el contenido del '
                              'software instalado, y únicamente facilita el proceso de '
                              'instalación.',
                        ),
                        _section(
                          textTheme,
                          '6. Responsabilidad del usuario',
                          'El usuario es responsable de:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'verificar la procedencia de los instaladores utilizados',
                            'asegurarse de que el software instalado sea legítimo',
                            'cumplir con las licencias de los programas instalados',
                            'verificar la compatibilidad del software con su sistema',
                          ],
                        ),
                        _paragraph(
                          textTheme,
                          'Instaboo no verifica ni certifica automáticamente la seguridad '
                              'o legalidad de los instaladores agregados por el usuario.',
                        ),
                        _section(
                          textTheme,
                          '7. Limitación de responsabilidad',
                          'Instaboo no garantiza el funcionamiento, seguridad o '
                              'compatibilidad del software de terceros instalado mediante '
                              'la aplicación.\n\n'
                              'Los desarrolladores de Instaboo no serán responsables por:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'errores en software de terceros',
                            'fallos durante la instalación',
                            'incompatibilidades entre programas',
                            'daños derivados del uso de software de terceros',
                          ],
                        ),
                        _section(
                          textTheme,
                          '8. Recomendación de seguridad',
                          'Se recomienda a los usuarios descargar instaladores de '
                              'software **únicamente desde fuentes oficiales o '
                              'confiables**.\n\n'
                              'El uso de software obtenido de fuentes no verificadas puede '
                              'representar riesgos de seguridad para el sistema del '
                              'usuario.',
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
              'Aviso sobre Software de Terceros',
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