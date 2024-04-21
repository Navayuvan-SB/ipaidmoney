import 'package:isar/isar.dart';

part 'expense-model.g.dart';

enum ExpenseCategory { shopping, travel, food }

enum PaymentMethod { credit, cash, account }

@Collection()
class Expense {
  Id id = Isar.autoIncrement;

  String name;

  double cost;

  DateTime date;

  @Enumerated(EnumType.name)
  ExpenseCategory category;

  @Enumerated(EnumType.name)
  PaymentMethod paymentMethod;

  Expense(this.name, this.cost, this.date, this.category, this.paymentMethod);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cost': cost,
      'date': date,
      'category': category.name,
      'paymentMethod': paymentMethod.name
    };
  }

  Expense clone() {
    return Expense(name, cost, date, category, paymentMethod);
  }
}
