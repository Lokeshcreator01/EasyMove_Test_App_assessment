import 'package:equatable/equatable.dart';

class Servicesdata_entity extends Equatable {
  final List<Service_entity> services;

  const Servicesdata_entity({required this.services});

  factory Servicesdata_entity.fromJson(Map<String, dynamic> json) {
    final rawServices = json['services'] ?? json['data'];
    return Servicesdata_entity(
      services: rawServices is List
          ? rawServices
                .whereType<Map<String, dynamic>>()
                .map(Service_entity.fromJson)
                .toList()
          : const [],
    );
  }

  @override
  List<Object?> get props => [services];
}

class Service_entity extends Equatable {
  final int id;
  final String name;
  final int deleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Service_entity({
    required this.id,
    required this.name,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Service_entity.fromJson(Map<String, dynamic> json) {
    return Service_entity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      deleted: (json['deleted'] as num?)?.toInt() ?? 0,
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt:
          DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  List<Object?> get props => [id, name, deleted, createdAt, updatedAt];
}
