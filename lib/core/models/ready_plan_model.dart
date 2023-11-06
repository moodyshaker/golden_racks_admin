class ReadyPlanModel {
  int? id;
  String? planName;
  String? planDuration;
  int? numberOfFixedVisits;
  int? numberOEmregencyVisits;
  bool? isSpareParts;
  double? planPrice;
  int? numberOfRacks;
  double? racksUnitPrice;
  List<SpareParts>? spareParts;

  ReadyPlanModel({
    this.id,
    this.planName,
    this.planDuration,
    this.numberOfFixedVisits,
    this.numberOEmregencyVisits,
    this.isSpareParts,
    this.planPrice,
    this.numberOfRacks,
    this.racksUnitPrice,
    this.spareParts,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'planName': planName,
      'planDuration': planDuration,
      'numberOfFixedVisits': numberOfFixedVisits,
      'numberOEmregencyVisits': numberOEmregencyVisits,
      'isSpareParts': isSpareParts,
      'planPrice': planPrice,
      'numberOfRacks': numberOfRacks,
      'racksUnitPrice': racksUnitPrice,
      'spareParts': spareParts!.map((x) => x.toJson()).toList(),
    };
  }

  factory ReadyPlanModel.fromJson(Map<String, dynamic> json) {
    return ReadyPlanModel(
      id: json['id'] != null ? json['id'] as int : null,
      planName: json['planName'] != null ? json['planName'] as String : null,
      planDuration:
          json['planDuration'] != null ? json['planDuration'] as String : null,
      numberOfFixedVisits: json['numberOfFixedVisits'] != null
          ? json['numberOfFixedVisits'] as int
          : null,
      numberOEmregencyVisits: json['numberOEmregencyVisits'] != null
          ? json['numberOEmregencyVisits'] as int
          : null,
      isSpareParts:
          json['isSpareParts'] != null ? json['isSpareParts'] as bool : null,
      planPrice: json['planPrice'] != null ? json['planPrice'] as double : null,
      numberOfRacks:
          json['numberOfRacks'] != null ? json['numberOfRacks'] as int : null,
      racksUnitPrice: json['racksUnitPrice'] != null
          ? json['racksUnitPrice'] as double
          : null,
      spareParts: json['spareParts'] != null
          ? List<SpareParts>.from(
              (json['spareParts'] as List<dynamic>).map<SpareParts?>(
                (x) => SpareParts.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}

class SpareParts {
  String? name;
  double? sellingPrice;
  double? purchasingPrice;
  String? description;
  int? quantityInStock;
  String? madeIn;
  bool? isActive;
  List<SparePartsImages>? sparePartsImages;

  SpareParts({
    this.name,
    this.sellingPrice,
    this.purchasingPrice,
    this.description,
    this.quantityInStock,
    this.madeIn,
    this.isActive,
    this.sparePartsImages,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'sellingPrice': sellingPrice,
      'purchasingPrice': purchasingPrice,
      'description': description,
      'quantityInStock': quantityInStock,
      'madeIn': madeIn,
      'isActive': isActive,
      'sparePartsImages': sparePartsImages!.map((x) => x.toJson()).toList(),
    };
  }

  factory SpareParts.fromJson(Map<String, dynamic> json) {
    return SpareParts(
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
      sparePartsImages: json['sparePartsImages'] != null
          ? List<SparePartsImages>.from(
              (json['sparePartsImages'] as List<dynamic>)
                  .map<SparePartsImages?>(
                (x) => SparePartsImages.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}

class SparePartsImages {
  String? name;
  String? image;
  SparePartsImages({
    this.name,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'image': image,
    };
  }

  factory SparePartsImages.fromJson(Map<String, dynamic> json) {
    return SparePartsImages(
      name: json['name'] != null ? json['name'] as String : null,
      image: json['image'] != null ? json['image'] as String : null,
    );
  }
}
