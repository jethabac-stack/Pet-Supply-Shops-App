class Pet {
  final String name;
  final String type;
  final String breed;
  final String birthDate;
  final double weight;
  final String imageUrl;

  Pet({
    required this.name,
    required this.type,
    required this.breed,
    required this.birthDate,
    required this.weight,
    required this.imageUrl,
  });

  int get age {
    final birth = DateTime.parse(birthDate);
    final now = DateTime.now();
    return now.year - birth.year - (now.month < birth.month || (now.month == birth.month && now.day < birth.day) ? 1 : 0);
  }
}
