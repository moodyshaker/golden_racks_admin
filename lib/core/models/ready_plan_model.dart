class ReadyPlanModel {
  int? id;
  String? planDuration;
  int? numberOfFixedVisits;
  int? numberOEmregencyVisits;
  bool? isSpareParts;
  double? planPrice;
  String? sparePartsName;
  double? sparePartsPrice;
  double? totalCost;
  String? sparePartsDescription;
  int? quntityInStock;
  String? madeIn;
  bool? isActive;
  int? numberOfRacks;
  double? racksUnitPrice;
  List<String>? sparePartsImages;

  ReadyPlanModel({
    this.id,
    this.planDuration,
    this.numberOfFixedVisits,
    this.numberOEmregencyVisits,
    this.isSpareParts,
    this.planPrice,
    this.sparePartsName,
    this.sparePartsPrice,
    this.totalCost,
    this.sparePartsDescription,
    this.quntityInStock,
    this.madeIn,
    this.isActive,
    this.numberOfRacks,
    this.racksUnitPrice,
    this.sparePartsImages,
  });

  factory ReadyPlanModel.fromJson(Map<String, dynamic> json) {
    return ReadyPlanModel(
      id: json['id'],
      planDuration: json['planDuration'],
      numberOfFixedVisits: json['numberOfFixedVisits'],
      numberOEmregencyVisits: json['numberOEmregencyVisits'],
      isSpareParts: json['isSpareParts'],
      planPrice: json['planPrice'],
      sparePartsName: json['sparePartsName'],
      sparePartsPrice: json['sparePartsPrice'],
      totalCost: json['totalCost'],
      sparePartsDescription: json['sparePartsDescription'],
      quntityInStock: json['quntityInStock'],
      madeIn: json['madeIn'],
      isActive: json['isActive'],
      numberOfRacks: json['numberOfRacks'],
      racksUnitPrice: json['racksUnitPrice'],
      sparePartsImages: json['sparePartsImages'] != null
          ? List<String>.from(
              (json['sparePartsImages'] as List<dynamic>),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['planDuration'] = this.planDuration;
    data['numberOfFixedVisits'] = this.numberOfFixedVisits;
    data['numberOEmregencyVisits'] = this.numberOEmregencyVisits;
    data['isSpareParts'] = this.isSpareParts;
    data['planPrice'] = this.planPrice;
    data['sparePartsName'] = this.sparePartsName;
    data['sparePartsPrice'] = this.sparePartsPrice;
    data['totalCost'] = this.totalCost;
    data['sparePartsDescription'] = this.sparePartsDescription;
    data['quntityInStock'] = this.quntityInStock;
    data['madeIn'] = this.madeIn;
    data['isActive'] = this.isActive;
    data['numberOfRacks'] = this.numberOfRacks;
    data['racksUnitPrice'] = this.racksUnitPrice;
    data['sparePartsImages'] = this.sparePartsImages;
    return data;
  }
}
