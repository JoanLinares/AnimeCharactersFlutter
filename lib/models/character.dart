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
  final String       description;
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

  factory Character.fromJson(Map<String, dynamic> j) {
    return Character(
      id:          j['id']         as int?    ?? 0,
      name:        j['name']       as String? ?? 'Unknown',
      image:       j['image']      as String? ?? 'https://via.placeholder.com/150',
      size:        j['size']       as String? ?? '',
      age:         j['age']        as String? ?? '',
      bounty:      j['bounty']     as String? ?? '0',
      job:         j['job']        as String? ?? '',
      status:      j['status']     as String? ?? '',
      description: j['description']as String? ?? '',
      crew:  Crew.fromJson(j['crew']  as Map<String,dynamic>?),
      fruit: DevilFruit.fromJson(j['fruit'] as Map<String,dynamic>?),
    );
  }
}
