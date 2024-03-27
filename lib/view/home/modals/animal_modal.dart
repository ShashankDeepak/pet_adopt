// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AnimalModal {
  String name = "";
  String species = "";
  int age = 0;
  int price = 0;
  String image = "";
  bool isAdopted = false;
  DateTime? date;
  AnimalModal({
    required this.name,
    required this.species,
    required this.age,
    required this.price,
    required this.image,
    this.isAdopted = false,
    this.date,
  });

  AnimalModal copyWith({
    String? name,
    String? species,
    int? age,
    int? price,
    String? image,
    bool? isAdopted,
    DateTime? date,
  }) {
    return AnimalModal(
      name: name ?? this.name,
      species: species ?? this.species,
      age: age ?? this.age,
      price: price ?? this.price,
      image: image ?? this.image,
      isAdopted: isAdopted ?? this.isAdopted,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'species': species,
      'age': age,
      'price': price,
      'image': image,
      'isAdopted': isAdopted,
      'date': date!.millisecondsSinceEpoch,
    };
  }

  factory AnimalModal.fromMap(Map<String, dynamic> map) {
    return AnimalModal(
      name: map['name'] as String,
      species: map['species'] as String,
      age: map['age'] as int,
      price: map['price'] as int,
      image: map['image'] as String,
      isAdopted: map['isAdopted'] as bool,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimalModal.fromJson(String source) =>
      AnimalModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnimalModal(name: $name, species: $species, age: $age, price: $price, image: $image, isAdopted: $isAdopted, date: $date)';
  }

  @override
  bool operator ==(covariant AnimalModal other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.species == species &&
        other.age == age &&
        other.price == price &&
        other.image == image &&
        other.isAdopted == isAdopted &&
        other.date == date;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        species.hashCode ^
        age.hashCode ^
        price.hashCode ^
        image.hashCode ^
        isAdopted.hashCode ^
        date.hashCode;
  }
}
