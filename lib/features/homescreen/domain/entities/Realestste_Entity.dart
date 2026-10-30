import 'package:equatable/equatable.dart';

class ServicesEntity extends Equatable{
  final List<ListingEntity> listings;
  final MetaEntity meta;

  ServicesEntity({
    required this.listings,
    required this.meta,
  });

  @override
  List<Object?> get props => [listings, meta];

}

class ListingEntity extends Equatable{
  final int id;
  final int? vendorId;
  final int? superAdminId;
  final PropertyList propertyList;
  final String propertyName;
  final String propertyType;
  final int bedrooms;
  final String price;
  final Googlemap location;
  final bool isNegotiable;
  final Googlemap googlemap;
  final String landSize;
  final List<dynamic> amenities;
  final String viewingFee;
  final int viewAvailability;
  final List<AvailableDateTimeEntity> availableDateTimes;
  final int status;
  final String? videoPath;
  final String uUid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int deleted;
  final int isFavourite;
  final List<ImageEntity> images;

  ListingEntity({
    required this.id,
    required this.vendorId,
    required this.superAdminId,
    required this.propertyList,
    required this.propertyName,
    required this.propertyType,
    required this.bedrooms,
    required this.price,
    required this.location,
    required this.isNegotiable,
    required this.googlemap,
    required this.landSize,
    required this.amenities,
    required this.viewingFee,
    required this.viewAvailability,
    required this.availableDateTimes,
    required this.status,
    required this.videoPath,
    required this.uUid,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
    required this.isFavourite,
    required this.images,
  });

  @override
  List<Object?> get props => [
        id,
        vendorId,
        superAdminId,
        propertyList,
        propertyName,
        propertyType,
        bedrooms,
        price,
        location,
        isNegotiable,
        googlemap,
        landSize,
        amenities,
        viewingFee,
        viewAvailability,
        availableDateTimes,
        status,
        videoPath,
        uUid,
        createdAt,
        updatedAt,
        deleted,
        isFavourite,
        images
      ];

}

class AvailableDateTimeEntity extends Equatable{
  final DateTime date;
  final String time;

  AvailableDateTimeEntity({
    required this.date,
    required this.time,
  });

  @override
  List<Object?> get props => [date, time];

}

enum Googlemap {
  GHANA
}

class ImageEntity extends Equatable{
  final int id;
  final int realEstateListingId;
  final String imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String originalName;
  final Extension extension;

  ImageEntity({
    required this.id,
    required this.realEstateListingId,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.originalName,
    required this.extension,
  });

  @override
  List<Object?> get props => [id, realEstateListingId, imagePath, createdAt, updatedAt, originalName, extension];

}

enum Extension {
  JPG,
  PNG
}

enum PropertyList {
  LEASE,
  RENT,
  SELL
}

class MetaEntity extends Equatable{
  final int limit;
  final int offset;
  final int count;

  MetaEntity({
    required this.limit,
    required this.offset,
    required this.count,
  });

  @override
  List<Object?> get props => [limit, offset, count];

}
