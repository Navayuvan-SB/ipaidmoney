import 'package:flutter/material.dart';
import 'package:ipaidmoney/models/expenses/expense-model.dart';
import 'package:ipaidmoney/models/init.dart';
import 'package:ipaidmoney/utils/configs.dart';
import 'package:ipaidmoney/utils/extentions.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final void Function()? onTap;

  const ExpenseItem({super.key, required this.expense, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color categoryColor = expense.category != null
        ? CategoryColorConfig[expense.category]!
        : Colors.red;
    IconData paymentMethodIcon =
        PaymentMethodIconConfig[expense.paymentMethod]!;

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
        visualDensity: VisualDensity.comfortable,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              expense.name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Text(
              "-Rs. ${expense.cost}",
              style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Theme(
                data: Theme.of(context)
                    .copyWith(canvasColor: categoryColor.withOpacity(0.1)),
                child: Chip(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  label: expense.category != null
                      ? Text(
                          expense.category!.name.capitalize(),
                          style: TextStyle(
                              color: categoryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )
                      : Text(
                          "Uncategorized",
                          style: TextStyle(
                              color: categoryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                  labelPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: -4),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(6), // Set the border radius here
                    side: const BorderSide(
                        color: Colors.transparent), // Add a border
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    paymentMethodIcon,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(expense.paymentMethod.name.capitalize()),
                ],
              )
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
