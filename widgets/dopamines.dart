import 'package:dopamine_tracker/widgets/chart/chart.dart';
import 'package:dopamine_tracker/widgets/dopamine_list/dopamines_list.dart';
import 'package:dopamine_tracker/models/dopamine.dart';
import 'package:dopamine_tracker/widgets/new_dopamine.dart';
import 'package:flutter/material.dart';


class Dopamines extends StatefulWidget {
  const Dopamines({super.key});

  @override
  State<Dopamines> createState() {
    // TODO: implement createState
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Dopamines> {
  final List<Dopamine> _registeredExpenses = [
    Dopamine(
      title: 'Gaming',
      amount: 19.99,
      date: DateTime.now(),
      catergory: Category.work,
    ),
    Dopamine(
      title: 'Movie',
      amount: 15.69,
      date: DateTime.now(),
      catergory: Category.leisure,
    ),
  ];
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea:true ,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Dopamine expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Dopamine expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Dopamine deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No expense found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dopamine Tracker'),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                 ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
          bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          // Handle tab selection
          // You can navigate to different screens or update the content based on the selected tab.
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Practices',
          ),
        ],
      ), 
            
    );
  }
}
