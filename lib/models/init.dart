import 'package:ipaidmoney/models/expenses/expense-model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalDB {
  static late Isar isar;

  static Future initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ExpenseSchema],
      directory: dir.path,
    );
  }

  static Isar get instance {
    return isar;
  }
}
