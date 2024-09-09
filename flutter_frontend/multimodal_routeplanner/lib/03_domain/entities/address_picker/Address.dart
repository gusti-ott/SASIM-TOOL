import 'package:json_annotation/json_annotation.dart';
import 'package:multimodal_routeplanner/03_domain/entities/address_picker/Properties.dart';

import 'Geometry.dart';

part 'Address.g.dart';

@JsonSerializable()
class Address {
  final Properties properties;
  final Geometry geometry;

  Address(this.properties, this.geometry);

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

// make extension that returns the address name
extension AddressName on Address {
  String get name {
    if (properties.city != null && properties.postcode != null) {
      if (properties.name != null) {
        return '${properties.name}, ${properties.postcode.toString()} ${properties.city}';
      } else if (properties.street != null && properties.housenumber != null) {
        return '${properties.street} ${properties.housenumber.toString()}, ${properties.postcode.toString()} ${properties.city}';
      }
    }
    return 'kein Name gefunden';
  }
}
