import 'package:easymove/features/Services_screen/domain/entities/Services_entity.dart';

class Servicesdata_model extends Servicesdata_entity {
  const Servicesdata_model({required super.services});

  factory Servicesdata_model.fromJson(Map<String, dynamic> json) {
    final entity = Servicesdata_entity.fromJson(json);
    return Servicesdata_model(services: entity.services);
  }
}
