import 'package:flutter/material.dart';
import 'package:budgetapp/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now,
    );//makes sure to get value
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid'),
            content: const Text('Make sure you input valid terms'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(ctx);
                  },
                child: const Text('Okay'),
              ),
            ],
          ),
      );
      return;
    }

    widget.onAddExpense(
        Expense(
            title: _titleController.text,
            amount: enteredAmount,
            date: _selectedDate!,
            category: _selectedCategory
        ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
          children:[
            TextField(
              controller: _titleController,
              maxLength: 20,
              decoration: const InputDecoration(
                label: Text('Title')
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount')
                      ),
                    ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null ? 'No Date Selected' : formatter.format(_selectedDate!),),
                      IconButton(
                        onPressed: _presentDate,
                          icon: const Icon(
                              Icons.calendar_month,
                          ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                    items: Category.values.map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                    ).toList(),
                    onChanged: (value) {
                      if(value==null){return;}
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                ),
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
      ),
    );
  }
}