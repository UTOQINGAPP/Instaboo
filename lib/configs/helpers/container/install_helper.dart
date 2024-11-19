import 'dart:io';

class InstallHelper {

   /// Executes a PowerShell command to run an installer located at the specified path
  static Future<(int exitCode, String? errorMessage)> powershell(
      String path) async {
    try {
      String directoryPath = _getDirectoryPath(path);
      Directory.current = directoryPath;

      final process = await Process.start(
        'powershell',
        [
          '-NoProfile',
          '-Command',
          'Start-Process -FilePath "$path" '
              '-ArgumentList "/S /sAll /rs /l /qb- /norestart /quiet /verysilent /agree /nocancel /close /autoexit /noeula /finishmessage=0" '
              '-Wait'
        ],
        runInShell: true,
      );

      await stdout.addStream(process.stdout);
      await stderr.addStream(process.stderr);

      final exitCode = await process.exitCode;
      return (exitCode, null);
    } catch (e) {
      return (-1, e.toString());
    }
  }

  /// Executes a Command Prompt command to run an installer located at the specified path
  static Future<(int exitCode, String? errorMessage)> cmd(String path) async {
    try {
      String directoryPath = _getDirectoryPath(path);
      Directory.current = directoryPath;

      final process = await Process.start(
        'cmd',
        [
          '/C',
          'start',
          '/wait',
          '"Setup"',
          '"$path"',
          '/S /sAll /rs /l /qb- /norestart /quiet /verysilent /agree /nocancel /close /autoexit /noeula /finishmessage=0'
        ],
        runInShell: true,
      );

      await stdout.addStream(process.stdout);
      await stderr.addStream(process.stderr);

      final exitCode = await process.exitCode;
      return (exitCode, null);
    } catch (e) {
      return (-1, e.toString());
    }
  }

  /// Helper function to extract the directory path from a file path
  static String _getDirectoryPath(String path) {
    int lastSeparatorIndex = path.lastIndexOf(r'\');
    return path.substring(0, lastSeparatorIndex);
  }
}
