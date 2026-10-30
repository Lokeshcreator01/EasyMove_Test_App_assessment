import 'package:easymove/features/homescreen/domain/entities/Realestste_Entity.dart';

class UserModel extends ServicesEntity{

  UserModel({
    required super.listings,
    required super.meta,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    listings: List<ListingModel>.from(json["listings"].map((x) => ListingModel.fromJson(x))),
    meta: MetaModel.fromJson(json["meta"]),
  );

}

class ListingModel extends ListingEntity {

  ListingModel({
  required  super.id,
    required  super.vendorId,
    required  super.superAdminId,
    required  super.propertyList,
    required  super.propertyName,
    required  super.propertyType,
    required  super.bedrooms,
    required  super.price,
    required  super.location,
    required  super.isNegotiable,
    required  super.googlemap,
    required  super.landSize,
    required  super.amenities,
    required  super.viewingFee,
    required  super.viewAvailability,
    required  super.availableDateTimes,
    required  super.status,
    required super.videoPath,
    required super.uUid,
    required super.createdAt,
    required super.updatedAt,
    required super.deleted,
    required super.isFavourite,
    required super.images,
  });

  factory ListingModel.fromJson(Map<String, dynamic> json) => ListingModel(
    id: json["id"],
    vendorId: json["vendor_id"],
    superAdminId: json["super_admin_id"],
    propertyList: propertyListValues.map[json["property_list"]]!,
    propertyName: json["property_name"],
    propertyType: json["property_type"],
    bedrooms: json["bedrooms"],
    price: json["price"],
    location: googlemapValues.map[json["location"]]!,
    isNegotiable: json["is_negotiable"],
    googlemap: googlemapValues.map[json["googlemap"]]!,
    landSize: json["land_size"],
    amenities: List<dynamic>.from(json["amenities"].map((x) => x)),
    viewingFee: json["viewing_fee"],
    viewAvailability: json["view_availability"],
    availableDateTimes: List<AvailableDateTimeModel>.from(json["available_date_times"].map((x) => AvailableDateTimeModel.fromJson(x))),
    status: json["status"],
    videoPath: json["video_path"],
    uUid: json["u_uid"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deleted: json["deleted"],
    isFavourite: json["is_favourite"],
    images: List<ImageModel>.from(json["images"].map((x) => ImageModel.fromJson(x))),
  );

}

class AvailableDateTimeModel extends AvailableDateTimeEntity{

  AvailableDateTimeModel({
    required super.date,
    required super.time,
  });

  factory AvailableDateTimeModel.fromJson(Map<String, dynamic> json) => AvailableDateTimeModel(
    date: DateTime.parse(json["date"]),
    time: json["time"],
  );

}

final googlemapValues = EnumValues({
  "Ghana": Googlemap.GHANA
});

class ImageModel extends ImageEntity {

  ImageModel({
    required super.id,
    required super.realEstateListingId,
    required super.imagePath,
    required super.createdAt,
    required super.updatedAt,
    required super.originalName,
    required super.extension,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id: json["id"],
    realEstateListingId: json["real_estate_listing_id"],
    imagePath: json["image_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    originalName: json["original_name"],
    extension: extensionValues.map[json["extension"]]!,
  );

}

final extensionValues = EnumValues({
  "jpg": Extension.JPG,
  "png": Extension.PNG
});

final propertyListValues = EnumValues({
  "lease": PropertyList.LEASE,
  "rent": PropertyList.RENT,
  "sell": PropertyList.SELL
});

class MetaModel extends MetaEntity {

  MetaModel({
    required super.limit,
    required super.offset,
    required super.count,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
  );

}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}