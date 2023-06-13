
class SpeakersModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? speakerBioAr;
  String? speakerBioEn;
  String? eventsId;
  String? oldSpeakerImage;
  String? image;
  String? dateDay;
  String? currentWork;
  String? certificates;
  String? experiences;

  SpeakersModel(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.speakerBioAr,
        this.speakerBioEn,
        this.eventsId,
        this.oldSpeakerImage,
        this.image,
        this.dateDay,
        this.currentWork,
        this.certificates,
        this.experiences});

  SpeakersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_Ar'];
    nameEn = json['name_En'];
    speakerBioAr = json['speaker_Bio_Ar'];
    speakerBioEn = json['speaker_Bio_En'];
    eventsId = json['eventsId'];
    oldSpeakerImage = json['oldSpeaker_Image'];
    image = json['image'];
    dateDay = json['dateDay'];
    currentWork = json['currentWork'];
    certificates = json['certificates'];
    experiences = json['experiences'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_Ar'] = this.nameAr;
    data['name_En'] = this.nameEn;
    data['speaker_Bio_Ar'] = this.speakerBioAr;
    data['speaker_Bio_En'] = this.speakerBioEn;
    data['eventsId'] = this.eventsId;
    data['oldSpeaker_Image'] = this.oldSpeakerImage;
    data['image'] = this.image;
    data['dateDay'] = this.dateDay;
    data['currentWork'] = this.currentWork;
    data['certificates'] = this.certificates;
    data['experiences'] = this.experiences;
    return data;
  }
}