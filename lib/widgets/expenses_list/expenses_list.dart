import 'package:budgetapp/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:budgetapp/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //automatically scrollable, create only when visible
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) =>Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
            },
          child: ExpenseItem(expenses[index]
          ),
      ), //gets called based on count
    );
  }
}