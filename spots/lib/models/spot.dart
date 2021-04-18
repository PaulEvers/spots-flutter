import 'package:spots/models/coordinates.dart';
import 'package:json_annotation/json_annotation.dart';
part 'spot.g.dart';

@JsonSerializable()
class Spot {
  final String id;
  final String name;
  final String category;
  final Coordinates coordinates;
  final String city;
  final String country;
  final String description;
  final List<String> images;
  final List<String> facts;
  final String audioUrl;

  Spot(
      {this.id,
      this.name,
      this.category,
      this.coordinates,
      this.city,
      this.country,
      this.description,
      this.images,
      this.facts,
      this.audioUrl});

  factory Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);

  Map<String, dynamic> toJson() => _$SpotToJson(this);
}
