import 'package:corporita_task/core/constants/constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveHelper {
  static initHive() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    await Hive.openBox(Constants.hiveBoxName);
  }
}
