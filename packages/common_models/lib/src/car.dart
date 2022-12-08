import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
@collection
class Car {
  Car(this.brand);

  Id? id = Isar.autoIncrement;

  String brand;

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CarToJson(this);
}
