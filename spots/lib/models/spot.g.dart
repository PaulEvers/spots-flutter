// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spot _$SpotFromJson(Map<String, dynamic> json) {
  return Spot(
    id: json['id'] as String,
    name: json['name'] as String,
    category: json['category'] as String,
    coordinates: json['coordinates'] == null
        ? null
        : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
    city: json['city'] as String,
    country: json['country'] as String,
    description: json['description'] as String,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
    facts: (json['facts'] as List)?.map((e) => e as String)?.toList(),
    audioUrl: json['audioUrl'] as String,
  );
}

Map<String, dynamic> _$SpotToJson(Spot instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('category', instance.category);
  writeNotNull('coordinates', instance.coordinates);
  writeNotNull('city', instance.city);
  writeNotNull('country', instance.country);
  writeNotNull('description', instance.description);
  writeNotNull('images', instance.images);
  writeNotNull('facts', instance.facts);
  writeNotNull('audioUrl', instance.audioUrl);
  return val;
}
