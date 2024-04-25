// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ipaidmoney/models/expenses/expense-model.dart';

Map<ExpenseCategory, Color> CategoryColorConfig = {
  ExpenseCategory.food: Colors.blue,
  ExpenseCategory.shopping: Colors.green,
  ExpenseCategory.travel: Colors.orange,
};

Map<PaymentMethod, IconData> PaymentMethodIconConfig = {
  PaymentMethod.account: Icons.account_balance,
  PaymentMethod.cash: Icons.currency_rupee,
  PaymentMethod.credit: Icons.credit_card,
};
