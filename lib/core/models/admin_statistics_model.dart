class StatisticsModel {
  int? numberOfUnSubscriberEmergency;
  int? numberOfUnSubscriberNormal;
  int? numberOfSubscriberEmergency;
  int? numberOfSubscriberNormalComeFromSystem;
  int? numberOfWaitingActivation;
  int? numberActiveOfReadyPlan;
  int? numberActiveOfSparePart;

  StatisticsModel({
    this.numberOfUnSubscriberEmergency,
    this.numberOfUnSubscriberNormal,
    this.numberOfSubscriberEmergency,
    this.numberOfSubscriberNormalComeFromSystem,
    this.numberOfWaitingActivation,
    this.numberActiveOfReadyPlan,
    this.numberActiveOfSparePart,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'numberOfUnSubscriberEmergency': numberOfUnSubscriberEmergency,
      'numberOfUnSubscriberNormal': numberOfUnSubscriberNormal,
      'numberOfSubscriberEmergency': numberOfSubscriberEmergency,
      'numberOfSubscriberNormalComeFromSystem':
          numberOfSubscriberNormalComeFromSystem,
      'numberOfWaitingActivation': numberOfWaitingActivation,
      'numberActiveOfReadyPlan': numberActiveOfReadyPlan,
      'numberActiveOfSparePart': numberActiveOfSparePart,
    };
  }

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      numberOfUnSubscriberEmergency:
          json['numberOfUnSubscriberEmergency'] != null
              ? json['numberOfUnSubscriberEmergency'] as int
              : null,
      numberOfUnSubscriberNormal: json['numberOfUnSubscriberNormal'] != null
          ? json['numberOfUnSubscriberNormal'] as int
          : null,
      numberOfSubscriberEmergency: json['numberOfSubscriberEmergency'] != null
          ? json['numberOfSubscriberEmergency'] as int
          : null,
      numberOfSubscriberNormalComeFromSystem:
          json['numberOfSubscriberNormalComeFromSystem'] != null
              ? json['numberOfSubscriberNormalComeFromSystem'] as int
              : null,
      numberOfWaitingActivation: json['numberOfWaitingActivation'] != null
          ? json['numberOfWaitingActivation'] as int
          : null,
      numberActiveOfReadyPlan: json['numberActiveOfReadyPlan'] != null
          ? json['numberActiveOfReadyPlan'] as int
          : null,
      numberActiveOfSparePart: json['numberActiveOfSparePart'] != null
          ? json['numberActiveOfSparePart'] as int
          : null,
    );
  }
}
