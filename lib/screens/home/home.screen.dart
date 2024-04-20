import 'package:flutter/material.dart';
import 'package:ipaidmoney/config/theme.dart';
import 'package:ipaidmoney/models/expenses/expense-model.dart';
import 'package:ipaidmoney/models/init.dart';
import 'package:ipaidmoney/screens/home/expense-item.widget.dart';
import 'package:ipaidmoney/widgets/defaults/default-bottom-sheet.dart';
import 'package:ipaidmoney/widgets/expenses/add-edit-expense-form.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void openExpenseAddEditBottomSheet(Expense? expense) {
    openDefaultBottomSheet(
        context: context,
        child: AddEditExpenseForm(
          expense: expense,
        ));
  }

  void onExpenseTap(Expense expense) {
    openExpenseAddEditBottomSheet(expense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openExpenseAddEditBottomSheet(null);
        },
        tooltip: 'Add Expense',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Expenses"),
        backgroundColor: DarkTheme.scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: LocalDB.instance.expenses
            .where()
            .sortByDateDesc()
            .watch(fireImmediately: true),
        builder: (context, snapshot) {
          List<Expense>? expenses = snapshot.data;
          if (expenses == null || expenses.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "There are no expenses, Add some using the FAB below 👇",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.white10,
                height: 1, // Adjust the height of the divider as needed
              );
            },
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return ExpenseItem(
                expense: expense,
                onTap: () {
                  onExpenseTap(expense);
                },
              );
            },
          );
        },
      )),
    );
  }
}
