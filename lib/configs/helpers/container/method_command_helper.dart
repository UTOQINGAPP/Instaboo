import 'package:process_run/process_run.dart';

enum MethodCommandInfoHelper { powershell, cmd, all, empty }

class MethodCommandHelper {
  /// Check if 'cmd' is available on the system.
  static Future<bool> existCmd() async {
    try {
      var result =
          await runExecutableArguments('cmd', ['/c', 'echo Verificando CMD']);
      return result.exitCode == 0;
    } catch (e) {
      return false;
    }
  }

  /// Check if 'PowerShell' is available on the system.
  static Future<bool> existPowerShell() async {
    try {
      var result = await runExecutableArguments(
          'powershell', ['-Command', 'echo Verificando PowerShell']);
      return result.exitCode == 0;
    } catch (e) {
      return false;
    }
  }

  /// Checks if 'cmd', 'PowerShell', or neither exists.
  static Future<MethodCommandInfoHelper> check() async {
    bool cmdAvailable = await existCmd();
    bool powershellAvailable = await existPowerShell();

    if (cmdAvailable && powershellAvailable) {
      return MethodCommandInfoHelper.all;
    } else if (cmdAvailable) {
      return MethodCommandInfoHelper.cmd;
    } else if (powershellAvailable) {
      return MethodCommandInfoHelper.powershell;
    } else {
      return MethodCommandInfoHelper.empty;
    }
  }
}
