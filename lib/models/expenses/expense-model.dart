import 'package:isar/isar.dart';

part 'expense-model.g.dart';

@Collection()
class Expense {
  Id id = Isar.autoIncrement;

  String name;

  double cost;

  DateTime date;

  Expense(this.name, this.cost, this.date);

  Map<String, dynamic> toMap() {
    return {'name': name, 'cost': cost, 'date': date};
  }

  Expense clone() {
    return Expense(name, cost, date);
  }
}
