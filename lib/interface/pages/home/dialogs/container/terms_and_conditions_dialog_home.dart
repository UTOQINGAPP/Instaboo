import 'package:flutter/material.dart';

/// Dialog content widget that displays the Terms and Conditions of Use for Instaboo.
/// Contenedor del diálogo que muestra los Términos y Condiciones de Uso de Instaboo.
class TermsAndConditionsDialogHome extends StatelessWidget {
  /// Creates the terms and conditions dialog content.
  /// Crea el contenido del diálogo de términos y condiciones.
  const TermsAndConditionsDialogHome({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

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
              children: [
                _buildHeader(context, textTheme),
                const Divider(height: 1),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIntro(textTheme),
                        _section(
                          textTheme,
                          '1. Aceptación de los términos',
                          'Al descargar, ejecutar o utilizar la aplicación '
                              '**Instaboo**, el usuario acepta cumplir con los presentes '
                              '**Términos y Condiciones de Uso**.\n\n'
                              'Si el usuario no está de acuerdo con estos términos, '
                              'deberá abstenerse de utilizar la aplicación.',
                        ),
                        _section(
                          textTheme,
                          '2. Descripción del servicio',
                          '**Instaboo** es una aplicación de escritorio diseñada para '
                              'facilitar la **instalación y gestión de múltiples programas '
                              'desde una única interfaz**.\n\n'
                              'La aplicación permite organizar, seleccionar e instalar '
                              'software mediante una biblioteca personalizada de programas '
                              'y paquetes de instalación.\n\n'
                              'Entre sus principales funcionalidades se incluyen:',
                        ),
                        _bulletList(textTheme, [
                          'Gestión de una biblioteca de software.',
                          'Creación y administración de paquetes de instalación.',
                          'Instalación manual de programas.',
                          'Instalación automática de múltiples programas mediante paquetes.',
                          'Visualización del progreso de instalación.',
                          'Visualización de resultados del proceso de instalación.',
                          'Configuración de preferencias del sistema.',
                        ]),
                        _paragraph(
                          textTheme,
                          'El objetivo principal de la aplicación es **simplificar y '
                              'acelerar la instalación de software**, evitando que el '
                              'usuario tenga que instalar cada programa manualmente.',
                        ),
                        _section(
                          textTheme,
                          '3. Gestión de biblioteca de software',
                          'Instaboo permite al usuario crear y administrar una '
                              '**biblioteca personalizada de programas** que pueden '
                              'instalarse posteriormente.\n\n'
                              'Dentro de esta biblioteca, el usuario puede:',
                        ),
                        _bulletList(textTheme, [
                          'Agregar nuevos programas.',
                          'Editar la información de programas registrados.',
                          'Eliminar programas.',
                          'Organizar programas por categorías.',
                        ]),
                        _paragraph(
                          textTheme,
                          'Cada programa registrado puede incluir información como:',
                        ),
                        _bulletList(textTheme, [
                          'Nombre del programa',
                          'Descripción',
                          'Versión',
                          'Requisitos del sistema',
                          'Características del software',
                          'Ruta del instalador',
                          'Tipo de instalación (automática o asistida)',
                        ]),
                        _paragraph(
                          textTheme,
                          'Instaboo **no verifica ni valida automáticamente los '
                              'instaladores agregados por el usuario**. El usuario es '
                              'responsable de asegurarse de que los instaladores añadidos '
                              'a la biblioteca sean seguros, legítimos y compatibles con '
                              'su sistema.',
                        ),
                        _section(
                          textTheme,
                          '4. Creación y gestión de paquetes de instalación',
                          'La aplicación permite crear **paquetes o conjuntos de '
                              'programas** que pueden instalarse mediante una sola acción.\n\n'
                              'El usuario puede:',
                        ),
                        _bulletList(textTheme, [
                          'Crear nuevos paquetes de software.',
                          'Seleccionar qué programas forman parte de cada paquete.',
                          'Editar paquetes existentes.',
                          'Eliminar paquetes que ya no se utilicen.',
                        ]),
                        _paragraph(
                          textTheme,
                          'Esta funcionalidad permite preparar configuraciones típicas como:',
                        ),
                        _bulletList(textTheme, [
                          'Entornos de desarrollo',
                          'Software de oficina',
                          'Herramientas multimedia',
                          'Configuración inicial de un equipo',
                        ]),
                        _section(
                          textTheme,
                          '5. Instalación de software',
                          'Instaboo permite realizar instalaciones de software mediante '
                              'dos modalidades principales:',
                        ),
                        _subsection(textTheme, 'Instalación manual',
                            'El usuario puede seleccionar uno o varios programas desde '
                                'la biblioteca para instalarlos de manera individual.'),
                        _subsection(textTheme, 'Instalación mediante paquetes',
                            'El usuario puede seleccionar un paquete previamente '
                                'configurado para instalar múltiples programas '
                                'automáticamente.'),
                        _paragraph(
                          textTheme,
                          'Durante el proceso de instalación, la aplicación puede '
                              'mostrar información como:',
                        ),
                        _bulletList(textTheme, [
                          'El programa que está siendo instalado.',
                          'El estado del proceso.',
                          'Barras de progreso.',
                          'Posibles errores durante la instalación.',
                        ]),
                        _section(
                          textTheme,
                          '6. Resultados del proceso de instalación',
                          'Al finalizar el proceso de instalación, la aplicación '
                              'mostrará un resumen con información sobre:',
                        ),
                        _bulletList(textTheme, [
                          'Programas instalados correctamente.',
                          'Programas que no pudieron instalarse.',
                          'Estado final del proceso de instalación.',
                        ]),
                        _paragraph(
                          textTheme,
                          'Instaboo **no garantiza que todos los programas puedan '
                              'instalarse correctamente en todos los sistemas**, ya que el '
                              'resultado depende de factores externos como el sistema '
                              'operativo, dependencias del software o configuraciones del '
                              'instalador.',
                        ),
                        _section(
                          textTheme,
                          '7. Software de terceros',
                          'Instaboo permite gestionar e instalar **software desarrollado '
                              'por terceros**.\n\n'
                              'El usuario reconoce que:',
                        ),
                        _bulletList(textTheme, [
                          'Cada programa puede estar sujeto a **sus propias licencias de uso**.',
                          'Instaboo **no modifica el código ni el contenido de los programas de terceros**.',
                          'La aplicación puede **automatizar el proceso de instalación** utilizando parámetros de instalación silenciosa o configuraciones desatendidas cuando estas estén disponibles.',
                          'En algunos casos, los instaladores pueden haber sido configurados previamente por el usuario para permitir instalaciones automáticas.',
                        ]),
                        _paragraph(
                          textTheme,
                          'Instaboo **no es responsable del funcionamiento, seguridad, '
                              'licenciamiento o compatibilidad del software de terceros** '
                              'instalado mediante la aplicación.',
                        ),
                        _section(
                          textTheme,
                          '8. Responsabilidad del usuario',
                          'El usuario es responsable de:',
                        ),
                        _bulletList(textTheme, [
                          'Verificar la compatibilidad de los programas con su sistema.',
                          'Utilizar instaladores legítimos y seguros.',
                          'Cumplir con las licencias de software correspondientes.',
                          'Verificar la procedencia de los instaladores agregados a la biblioteca.',
                        ]),
                        _paragraph(
                          textTheme,
                          'El uso de la aplicación para instalar **software ilegal, '
                              'malicioso o sin licencia válida está prohibido**.',
                        ),
                        _section(
                          textTheme,
                          '9. Limitación de responsabilidad',
                          'Instaboo se proporciona **"tal cual"**, sin garantías '
                              'explícitas o implícitas.\n\n'
                              'El desarrollador no será responsable por:',
                        ),
                        _bulletList(textTheme, [
                          'daños en el sistema operativo',
                          'pérdida de datos',
                          'conflictos entre programas instalados',
                          'fallos en instaladores proporcionados por terceros',
                          'incompatibilidades entre software',
                          'errores derivados de configuraciones incorrectas del usuario',
                        ]),
                        _paragraph(
                          textTheme,
                          'El usuario utiliza la aplicación **bajo su propia responsabilidad**.',
                        ),
                        _section(
                          textTheme,
                          '10. Actualizaciones de la aplicación',
                          'Instaboo puede recibir actualizaciones periódicas que pueden '
                              'incluir:',
                        ),
                        _bulletList(textTheme, [
                          'nuevas funcionalidades',
                          'mejoras de rendimiento',
                          'correcciones de errores',
                          'cambios en la interfaz o funcionamiento',
                        ]),
                        _paragraph(
                          textTheme,
                          'Debido a que **Instaboo es una aplicación portable**, las '
                              'actualizaciones deberán ser **descargadas manualmente por el '
                              'usuario desde las fuentes oficiales del proyecto**.\n\n'
                              'El uso de versiones obtenidas desde fuentes no oficiales '
                              'puede representar riesgos de seguridad y queda bajo '
                              'responsabilidad del usuario.',
                        ),
                        _section(
                          textTheme,
                          '11. Propiedad intelectual y licencia del software',
                          'El código fuente del proyecto **Instaboo** puede estar '
                              'distribuido bajo la **Licencia MIT**, la cual permite su '
                              'uso, copia, modificación, compilación y redistribución '
                              'conforme a los términos establecidos en dicha licencia.\n\n'
                              'Sin embargo, las versiones compiladas y distribuidas '
                              'oficialmente bajo el nombre **Instaboo** son publicadas por '
                              'el autor o los mantenedores del proyecto y pueden estar '
                              'sujetas a condiciones adicionales relacionadas con:',
                        ),
                        _bulletList(textTheme, [
                          'autenticidad de la distribución oficial',
                          'integridad del software',
                          'uso del nombre o marca del proyecto',
                        ]),
                        _paragraph(
                          textTheme,
                          'El nombre **Instaboo**, así como su identidad visual y '
                              'distribución oficial, pueden estar reservados por el '
                              'desarrollador del proyecto.\n\n'
                              'Los usuarios son responsables de verificar que las '
                              'versiones del software que descarguen provengan de '
                              '**fuentes oficiales del proyecto**.\n\n'
                              'El uso de versiones modificadas o distribuidas por '
                              'terceros queda bajo responsabilidad del usuario.',
                        ),
                        _section(
                          textTheme,
                          '12. Modificaciones de los términos',
                          'Los presentes términos pueden ser modificados en cualquier '
                              'momento.\n\n'
                              'Las versiones actualizadas serán publicadas junto con la '
                              'aplicación o en los canales oficiales del proyecto.\n\n'
                              'El uso continuado de Instaboo después de dichos cambios '
                              'implica la aceptación de los nuevos términos.',
                        ),
                        _section(
                          textTheme,
                          '13. Contacto',
                          'Para consultas, soporte o reportes relacionados con '
                              'Instaboo, el usuario puede comunicarse con los '
                              'desarrolladores a través de los canales oficiales del '
                              'proyecto.',
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
        children: [
          Expanded(
            child: Text(
              'Términos y Condiciones de Uso',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
        children: [
          Text(
            'Instaboo',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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

  /// Builds a section with title and body text (plain, no markdown).
  /// Construye una sección con título y texto (sin formato markdown).
  Widget _section(TextTheme textTheme, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

  /// Builds a subsection (e.g. "Instalación manual").
  /// Construye una subsección.
  Widget _subsection(TextTheme textTheme, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          _paragraph(textTheme, body),
        ],
      ),
    );
  }

  /// Renders a paragraph, stripping simple **bold** markers for display.
  /// Renderiza un párrafo, eliminando marcadores **negrita** para mostrar.
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
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: RichText(
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
    final spans = <TextSpan>[];
    int start = 0;
    while (true) {
      final open = text.indexOf('**', start);
      if (open == -1) {
        spans.add(TextSpan(text: text.substring(start), style: textTheme.bodyMedium));
        break;
      }
      if (open > start) {
        spans.add(TextSpan(
          text: text.substring(start, open),
          style: textTheme.bodyMedium,
        ));
      }
      final close = text.indexOf('**', open + 2);
      if (close == -1) {
        spans.add(TextSpan(text: text.substring(open), style: textTheme.bodyMedium));
        break;
      }
      spans.add(TextSpan(
        text: text.substring(open + 2, close),
        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      ));
      start = close + 2;
    }
    return spans;
  }
}
