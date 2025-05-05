import 'origin_planet.dart';
import 'transformation.dart';

class Character {
  final int                  id;
  final String               name;
  final String               ki;
  final String               maxKi;
  final String               race;
  final String               gender;
  final String               description;
  final String               image;
  final String               affiliation;
  final OriginPlanet         originPlanet;
  final List<Transformation> transformations;

  Character({
    required this.id,
    required this.name,
    required this.ki,
    required this.maxKi,
    required this.race,
    required this.gender,
    required this.description,
    required this.image,
    required this.affiliation,
    required this.originPlanet,
    required this.transformations,
  });

  factory Character.fromJson(Map<String, dynamic> j) {
    return Character(
      id:              j['id']            as int?    ?? 0,
      name:            j['name']          as String? ?? 'Unknown',
      ki:              j['ki']            as String? ?? '0',
      maxKi:           j['maxKi']         as String? ?? '0',
      race:            j['race']          as String? ?? '',
      gender:          j['gender']        as String? ?? '',
      description:     j['description']   as String? ?? '',
      image:           j['image']         as String? ?? '',
      affiliation:     j['affiliation']   as String? ?? '',
      originPlanet:    OriginPlanet.fromJson(j['originPlanet'] as Map<String, dynamic>?),
      transformations: (j['transformations'] as List<dynamic>?)
                          ?.map((e) => Transformation.fromJson(e as Map<String, dynamic>))
                          .toList() ?? <Transformation>[],
    );
  }
}
