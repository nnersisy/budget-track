import 'package:budgetapp/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:budgetapp/models/expense.dart';
import 'package:budgetapp/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter',
        amount: 19,
        date: DateTime.now(),
        category: Category.food,
    ),
    Expense(
      title: 'Second',
      amount: 50,
      date: DateTime.now(),
      category: Category.other,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracking Your Budget"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add)
          ),
        ],
      ),
      body: Column(
        children: [

          const Text('The chart'),
          Expanded(
              child: ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,)
          ),
        ],
      ),
    );
  }
}