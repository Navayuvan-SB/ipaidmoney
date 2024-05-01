import 'package:flutter/material.dart';
import 'package:ipaidmoney/config/theme.dart';
import 'package:ipaidmoney/models/expenses/expense-model.dart';
import 'package:ipaidmoney/models/init.dart';
import 'package:ipaidmoney/screens/home/all.tab.dart';
import 'package:ipaidmoney/screens/home/expense-item.widget.dart';
import 'package:ipaidmoney/screens/home/today.tab.dart';
import 'package:ipaidmoney/widgets/defaults/default-bottom-sheet.dart';
import 'package:ipaidmoney/widgets/expenses/add-edit-expense-form.dart';
import 'package:isar/isar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

List<Widget> tabs = <Widget>[
  const TodayTab(),
  const AllTab(),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  late PageController _pageController;

  List<Widget> tabs = [TodayTab(), AllTab()];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPageIndex);
  }

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
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openExpenseAddEditBottomSheet(null);
          },
          tooltip: 'Add Expense',
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(LucideIcons.calendar),
              icon: Icon(LucideIcons.calendar),
              label: 'Today',
            ),
            NavigationDestination(
              selectedIcon: Icon(LucideIcons.notepadText),
              icon: Icon(LucideIcons.notepadText),
              label: 'All',
            ),
          ],
        ),
        body: PageView(
          onPageChanged: (value) {
            if (value != currentPageIndex) {
              setState(() {
                currentPageIndex = value;
              });
            }
          },
          controller: _pageController,
          children: tabs,
        ));
  }
}
