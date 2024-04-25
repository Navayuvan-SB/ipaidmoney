import 'package:flutter/material.dart';
import 'package:ipaidmoney/config/theme.dart';
import 'package:ipaidmoney/models/expenses/expense-model.dart';
import 'package:ipaidmoney/models/init.dart';
import 'package:ipaidmoney/screens/home/expense-item.widget.dart';
import 'package:ipaidmoney/widgets/defaults/default-bottom-sheet.dart';
import 'package:ipaidmoney/widgets/expenses/add-edit-expense-form.dart';
import 'package:isar/isar.dart';

class TodayTab extends StatefulWidget {
  const TodayTab({super.key});

  @override
  State<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends State<TodayTab> {
  void openExpenseAddEditBottomSheet(Expense? expense) {
    openDefaultBottomSheet(
      context: context,
      child: AddEditExpenseForm(
        expense: expense,
      ),
    );
  }

  void onExpenseTap(Expense expense) {
    openExpenseAddEditBottomSheet(expense);
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime startDateTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 0, 0, 0);
    DateTime endDateTime = DateTime(
        currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Today"),
        backgroundColor: DarkTheme.scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: LocalDB.instance.expenses
            .filter()
            .dateBetween(startDateTime, endDateTime,
                includeLower: true, includeUpper: true)
            .sortByDateDesc()
            .watch(fireImmediately: true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }

          List<Expense>? expenses = snapshot.data;
          if (expenses == null || expenses.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "There are no expenses for today, Add some using the FAB below 👇",
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
