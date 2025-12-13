class Reminder {
  final String id;
  final String title;
  final String description;
  final DateTime nextReminder;
  final int frequencyDays;
  final bool isActive;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.nextReminder,
    required this.frequencyDays,
    required this.isActive,
  });

  Reminder copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? nextReminder,
    int? frequencyDays,
    bool? isActive,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      nextReminder: nextReminder ?? this.nextReminder,
      frequencyDays: frequencyDays ?? this.frequencyDays,
      isActive: isActive ?? this.isActive,
    );
  }
}
