import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ipaidmoney/models/expenses/expense-model.dart';
import 'package:ipaidmoney/models/init.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final void Function()? onTap;

  const ExpenseItem({super.key, required this.expense, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(expense.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actionsPadding: const EdgeInsets.only(right: 10, bottom: 10),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              content: Text(
                'Are you sure you want to delete ${expense.name}?',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'No',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Delete',
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) async {
        await LocalDB.instance.writeTxn(() async {
          await LocalDB.isar.expenses.delete(expense.id);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Expense deleted')),
        );
      },
      child: ListTile(
        leading: const Icon(Icons.payments, size: 30),
        titleAlignment: ListTileTitleAlignment.titleHeight,
        visualDensity: VisualDensity.comfortable,
        title: Text(expense.name),
        subtitle: Row(
          children: [
            const Icon(
              Icons.schedule,
              size: 14,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              DateFormat('MMMM dd, yyyy').format(expense.date),
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
        trailing: Text(
          "- ₹ ${expense.cost}",
          style: TextStyle(color: Colors.red[300], fontSize: 16),
        ),
        onTap: onTap,
      ),
    );
  }
}
