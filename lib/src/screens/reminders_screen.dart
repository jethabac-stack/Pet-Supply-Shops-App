import 'package:flutter/material.dart';
import 'reminder.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  List<Reminder> reminders = [
    Reminder(
      id: '1',
      title: 'Dog Food',
      description: 'Time to reorder dog food',
      nextReminder: DateTime.now().add(const Duration(days: 15)),
      frequencyDays: 30,
      isActive: true,
    ),
  ];

  bool autoReorderEnabled = false;

  void _addReminder(Reminder reminder) {
    setState(() {
      reminders.add(reminder);
    });
  }

  void _editReminder(int index, Reminder reminder) {
    setState(() {
      reminders[index] = reminder;
    });
  }

  void _showReminderForm({Reminder? reminder, int? index}) {
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController(text: reminder?.title ?? '');
    final _descriptionController = TextEditingController(text: reminder?.description ?? '');
    final _frequencyController = TextEditingController(text: reminder?.frequencyDays.toString() ?? '30');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(reminder == null ? 'Add New Reminder' : 'Edit Reminder'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
                ),
                TextFormField(
                  controller: _frequencyController,
                  decoration: const InputDecoration(labelText: 'Frequency (days)'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Please enter frequency' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newReminder = Reminder(
                  id: reminder?.id ?? DateTime.now().toString(),
                  title: _titleController.text,
                  description: _descriptionController.text,
                  nextReminder: reminder?.nextReminder ?? DateTime.now().add(Duration(days: int.tryParse(_frequencyController.text) ?? 30)),
                  frequencyDays: int.tryParse(_frequencyController.text) ?? 30,
                  isActive: true,
                );
                if (index != null) {
                  _editReminder(index, newReminder);
                } else {
                  _addReminder(newReminder);
                }
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _toggleAutoReorder() {
    setState(() {
      autoReorderEnabled = !autoReorderEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders & Subscriptions'),
        backgroundColor: Colors.teal.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ...reminders.map((reminder) => Card(
              elevation: 8,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.teal.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.restaurant,
                    color: Colors.teal.shade600,
                    size: 32,
                  ),
                  title: Text(
                    '${reminder.title} - every ${reminder.frequencyDays} days',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  subtitle: Text(
                    'Next reminder: ${reminder.nextReminder.toString().split(' ')[0]}',
                    style: TextStyle(color: Colors.teal.shade600),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => _showReminderForm(
                      reminder: reminder,
                      index: reminders.indexOf(reminder),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Edit'),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            )),
            const SizedBox(height: 16),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.teal.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.autorenew,
                    color: Colors.teal.shade600,
                    size: 32,
                  ),
                  title: Text(
                    'Auto-Reorder: ${autoReorderEnabled ? 'On' : 'Off'}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  subtitle: Text(
                    'Automatically reorder when stock is low',
                    style: TextStyle(color: Colors.teal.shade600),
                  ),
                  trailing: OutlinedButton(
                    onPressed: _toggleAutoReorder,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.teal.shade600),
                      foregroundColor: Colors.teal.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(autoReorderEnabled ? 'Disable' : 'Enable'),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _showReminderForm(),
                icon: const Icon(Icons.add),
                label: const Text('Add New Reminder'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
