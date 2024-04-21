import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:intl/intl.dart';
import 'package:ipaidmoney/models/expenses/expense-model.dart';
import 'package:ipaidmoney/models/init.dart';
import 'package:ipaidmoney/utils/extentions.dart';
import 'package:ipaidmoney/widgets/defaults/default-chip-with-dropdown.dart';

class AddEditExpenseForm extends StatefulWidget {
  final Expense? expense;
  const AddEditExpenseForm({super.key, this.expense});

  @override
  State<AddEditExpenseForm> createState() => _AddEditExpenseFormState();
}

class _AddEditExpenseFormState extends State<AddEditExpenseForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  Expense expense =
      Expense('', 0.0, DateTime.now(), ExpenseCategory.food, PaymentMethod.account);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    setState(() {
      expense = widget.expense ?? expense;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: expense.date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (picked != null && picked != expense.date) {
      setState(() {
        expense.date = picked;
      });
    }
  }

  void createExpense() async {
    _formKey.currentState?.save();
    if (expense.name.isEmpty) {
      return;
    }

    if (expense.cost == 0) {
      return;
    }

    if (widget.expense != null) {
      await LocalDB.instance.writeTxn(() async {
        await LocalDB.instance.expenses.put(expense);
      });
      _formKey.currentState?.reset();
      _focusNode.requestFocus();
      Navigator.pop(context);
      return;
    }

    Expense newExpense = expense.clone();
    await LocalDB.instance.writeTxn(() async {
      await LocalDB.instance.expenses.put(newExpense);
    });
    _formKey.currentState?.reset();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onForegroundGained: () {
        _focusNode.requestFocus();
      },
      onForegroundLost: () {
        _focusNode.unfocus();
      },
      child: Container(
        color: Theme.of(context).dialogBackgroundColor,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 8,
          top: 8,
          left: 12,
          right: 12,
        ),
        width: double.maxFinite,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 45,
                child: FormBuilderTextField(
                  focusNode: _focusNode,
                  name: "name",
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  enableInteractiveSelection: true,
                  enableSuggestions: true,
                  textCapitalization: TextCapitalization.sentences,
                  initialValue: expense.name,
                  decoration: const InputDecoration(
                    hintText: 'Expense name',
                    hintStyle: TextStyle(
                      color: Colors.white24,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    if (value != null) expense.name = value;
                  },
                  onReset: () {
                    expense.name = "";
                  },
                ),
              ),
              SizedBox(
                height: 38,
                child: FormBuilderTextField(
                  name: "cost",
                  keyboardType: TextInputType.number,
                  initialValue:
                      expense.cost != 0 ? expense.cost.toString() : "",
                  decoration: const InputDecoration(
                      prefixIcon: Text(
                        "₹ ",
                        style: TextStyle(color: Colors.white24, fontSize: 15),
                      ),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                      hintText: 'Amount (e.g. 500)',
                      errorStyle: TextStyle(height: 0.05),
                      hintStyle: TextStyle(
                          color: Colors.white24,
                          fontWeight: FontWeight.w400,
                          fontSize: 15)),
                  style: const TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    createExpense();
                  },
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty)
                      expense.cost = double.parse(value);
                  },
                  onReset: () {
                    expense.cost = 0;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Chip(
                              label: Text(
                                DateFormat('MMMM dd, yyyy')
                                    .format(expense.date),
                                style: const TextStyle(color: Colors.green),
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.white12), // Outline color
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                              ),
                              avatar: const Icon(Icons.calendar_month),
                              backgroundColor:
                                  Theme.of(context).dialogBackgroundColor,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          ChipWithDropdownPopup<PaymentMethod>(
                            initialSelectedValue: expense.paymentMethod,
                            options: PaymentMethod.values,
                            icon: const Icon(
                              Icons.currency_rupee,
                              color: Colors.white70,
                            ),
                            renderLabel: (paymentMethod) {
                              return paymentMethod.name.capitalize();
                            },
                            onChanged: (paymentMethod) {
                              expense.paymentMethod = paymentMethod;
                            },
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          ChipWithDropdownPopup<ExpenseCategory>(
                            initialSelectedValue: expense.category,
                            options: ExpenseCategory.values,
                            icon: const Icon(
                              Icons.category_outlined,
                              color: Colors.white70,
                            ),
                            renderLabel: (category) {
                              return category.name.capitalize();
                            },
                            onChanged: (expenseCategory) {
                              expense.category = expenseCategory;
                            },
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                    width: 40,
                    height: 40,
                    child: IconButton(
                      onPressed: createExpense,
                      icon: const Icon(
                        Icons.done,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
