import 'crew.dart';
import 'devil_fruit.dart';

class Character {
  final int          id;
  final String       name;
  final String       image;
  final String       size;
  final String       age;
  final String       bounty;
  final String       job;
  final String       status;
  final String       description; // si la API lo aporta
  final Crew         crew;
  final DevilFruit?  fruit;

  Character({
    required this.id,
    required this.name,
    required this.image,
    required this.size,
    required this.age,
    required this.bounty,
    required this.job,
    required this.status,
    required this.description,
    required this.crew,
    this.fruit,
  });

  factory Character.fromJson(Map<String, dynamic> j) => Character(
    id:          j['id'],
    name:        j['name'],
    image:       j['image'],
    size:        j['size']    ?? '',
    age:         j['age']     ?? '',
    bounty:      j['bounty']  ?? '',
    job:         j['job']     ?? '',
    status:      j['status']  ?? '',
    description: j['description'] ?? '',
    crew:        Crew.fromJson(j['crew']),
    fruit:       j['fruit'] != null ? DevilFruit.fromJson(j['fruit']) : null,
  );
}
