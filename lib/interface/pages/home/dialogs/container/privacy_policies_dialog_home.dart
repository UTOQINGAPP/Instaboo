import 'package:flutter/material.dart';

/// Dialog content widget that displays the Privacy Policy for Instaboo.
/// Contenedor del diálogo que muestra la Política de Privacidad de Instaboo.
class PrivacyPoliciesDialogHome extends StatelessWidget {
  /// Creates the privacy policy dialog content.
  /// Crea el contenido del diálogo de política de privacidad.
  const PrivacyPoliciesDialogHome({super.key});

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
                          'Esta Política de Privacidad describe cómo la aplicación '
                              '**Instaboo** maneja la información generada durante su uso.\n\n'
                              'Instaboo es una aplicación de escritorio diseñada para '
                              'facilitar la instalación y gestión de múltiples programas '
                              'desde una única interfaz.\n\n'
                              'La privacidad del usuario es una prioridad. Por esta razón, '
                              'Instaboo está diseñado para **minimizar la recopilación de '
                              'datos y evitar el almacenamiento de información personal '
                              'innecesaria**.',
                        ),
                        _section(
                          textTheme,
                          '2. Datos recopilados por la aplicación',
                          'Instaboo puede generar o registrar **información técnica del '
                              'sistema** con el objetivo de documentar el funcionamiento de '
                              'la aplicación y los procesos de instalación realizados.\n\n'
                              'La información recopilada puede incluir:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'Información básica del sistema operativo',
                            'Información del hardware del equipo',
                            'Arquitectura del sistema (por ejemplo, 32 o 64 bits)',
                            'Programas instalados mediante la aplicación',
                            'Resultados de los procesos de instalación',
                            'Mensajes de error o estado durante las instalaciones',
                          ],
                        ),
                        _paragraph(
                          textTheme,
                          'Estos datos se utilizan exclusivamente para **registrar las '
                              'operaciones realizadas por la aplicación y facilitar la '
                              'revisión del historial de instalaciones**.',
                        ),
                        _section(
                          textTheme,
                          '3. Registros de actividad',
                          'Instaboo puede crear **registros locales (logs)** en el equipo '
                              'donde se ejecuta la aplicación.\n\n'
                              'Estos registros pueden incluir:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'Fecha y hora de uso de la aplicación',
                            'Programas instalados mediante Instaboo',
                            'Resultado de las instalaciones',
                            'Eventos relevantes del proceso de instalación',
                          ],
                        ),
                        _paragraph(
                          textTheme,
                          'Estos registros forman parte del funcionamiento normal de la '
                              'aplicación y permiten mantener un **historial técnico de las '
                              'operaciones realizadas**.',
                        ),
                        _section(
                          textTheme,
                          '4. Almacenamiento de la información',
                          'La información generada por Instaboo se almacena '
                              '**localmente en el equipo del usuario**.\n\n'
                              'Instaboo **no envía información a servidores externos**, ni '
                              'recopila datos de forma remota.\n\n'
                              'Toda la información generada permanece bajo el control del '
                              'usuario dentro de su propio sistema.',
                        ),
                        _section(
                          textTheme,
                          '5. Datos personales',
                          'Instaboo **no recopila información personal del usuario**.\n\n'
                              'La aplicación no solicita ni registra datos como:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'nombres',
                            'direcciones de correo electrónico',
                            'ubicaciones',
                            'credenciales de usuario',
                            'información financiera',
                          ],
                        ),
                        _paragraph(
                          textTheme,
                          'El funcionamiento de Instaboo se limita exclusivamente a '
                              '**gestionar procesos de instalación de software en el equipo '
                              'local**.',
                        ),
                        _section(
                          textTheme,
                          '6. Uso de software de terceros',
                          'Instaboo permite gestionar la instalación de software '
                              'desarrollado por terceros.\n\n'
                              'La instalación de estos programas puede estar sujeta a '
                              '**sus propias políticas de privacidad y licencias de uso**, '
                              'las cuales son independientes de Instaboo.\n\n'
                              'Se recomienda al usuario revisar las políticas de '
                              'privacidad correspondientes a cada software instalado.',
                        ),
                        _section(
                          textTheme,
                          '7. Control del usuario sobre los datos',
                          'Dado que la información generada por Instaboo se almacena '
                              'localmente, el usuario mantiene control sobre dichos datos.\n\n'
                              'El usuario puede:',
                        ),
                        _bulletList(
                          textTheme,
                          <String>[
                            'revisar los registros generados por la aplicación',
                            'eliminar los registros almacenados en su equipo',
                            'eliminar configuraciones o bibliotecas creadas en la aplicación',
                          ],
                        ),
                        _section(
                          textTheme,
                          '8. Seguridad',
                          'Instaboo está diseñado para minimizar la recopilación de datos '
                              'y limitar el almacenamiento de información al mínimo '
                              'necesario para el funcionamiento de la aplicación.\n\n'
                              'Sin embargo, el usuario es responsable de mantener la '
                              'seguridad de su sistema y del entorno donde se ejecuta la '
                              'aplicación.',
                        ),
                        _section(
                          textTheme,
                          '9. Cambios en esta política',
                          'Esta Política de Privacidad puede ser actualizada en futuras '
                              'versiones de la aplicación.\n\n'
                              'Las versiones actualizadas podrán ser publicadas junto con '
                              'nuevas versiones de Instaboo o en los canales oficiales del '
                              'proyecto.',
                        ),
                        _section(
                          textTheme,
                          '10. Contacto',
                          'Para consultas relacionadas con esta Política de Privacidad o '
                              'con el funcionamiento de la aplicación, el usuario puede '
                              'comunicarse con los desarrolladores del proyecto a través de '
                              'los canales oficiales.',
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
              'Política de Privacidad',
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