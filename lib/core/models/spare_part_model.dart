class SparePartModel {
  int? id;
  String? name;
  double? sellingPrice;
  double? purchasingPrice;
  String? description;
  int? quantityInStock;
  String? madeIn;
  bool? isActive;
  List<SparePartImages>? sparePartImages;

  SparePartModel({
    this.id,
    this.name,
    this.sellingPrice,
    this.purchasingPrice,
    this.description,
    this.quantityInStock,
    this.madeIn,
    this.isActive,
    this.sparePartImages,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'sellingPrice': sellingPrice,
      'purchasingPrice': purchasingPrice,
      'description': description,
      'quantityInStock': quantityInStock,
      'madeIn': madeIn,
      'isActive': isActive,
      'sparePartImages': sparePartImages!.map((x) => x.toJson()).toList(),
    };
  }

  factory SparePartModel.fromJson(Map<String, dynamic> json) {
    return SparePartModel(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? json['name'] as String : null,
      sellingPrice:
          json['sellingPrice'] != null ? json['sellingPrice'] as double : null,
      purchasingPrice: json['purchasingPrice'] != null
          ? json['purchasingPrice'] as double
          : null,
      description:
          json['description'] != null ? json['description'] as String : null,
      quantityInStock: json['quantityInStock'] != null
          ? json['quantityInStock'] as int
          : null,
      madeIn: json['madeIn'] != null ? json['madeIn'] as String : null,
      isActive: json['isActive'] != null ? json['isActive'] as bool : null,
      sparePartImages: json['sparePartImages'] != null
          ? List<SparePartImages>.from(
              (json['sparePartImages'] as List<dynamic>).map<SparePartImages?>(
                (x) => SparePartImages.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}

class SparePartImages {
  int? sparePartId;
  String? imageURL;
  bool? isActive;
  SparePartImages({
    this.sparePartId,
    this.imageURL,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sparePartId': sparePartId,
      'imageURL': imageURL,
      'isActive': isActive,
    };
  }

  factory SparePartImages.fromJson(Map<String, dynamic> json) {
    return SparePartImages(
      sparePartId:
          json['sparePartId'] != null ? json['sparePartId'] as int : null,
      imageURL: json['imageURL'] != null ? json['imageURL'] as String : null,
      isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    );
  }
}
