import 'dart:core';

class CattleModel {
  int? id;
  String? cattleBreed;
  String? cattleBreedId;
  String? cattleName;
  String? cattleTagNo;
  String? cattleGender;
  String? cattleStage;
  String? cattleWeight;
  String? cattleDOB;
  String? cattleDOE;
  String? cattleObtainMethod;
  String? cattleMotherTagNo;
  String? cattleFatherTagNo;
  String? cattleNote;
  String? cattleStatus;
  String? cattleArchive;
  String? cattleArchiveReason;
   String? cattleArchiveOtherReason;
  String? cattleArchiveDate;
  String? cattleArchiveNotes;
  String? cattleOtherSource;

  createMap() {
    return {
      if (id != null) "id": id.toString(),
      "cattleBreed": this.cattleBreed,
      "cattleBreedId": this.cattleBreedId,
      "cattleName": this.cattleName,
      "cattleTagNo": this.cattleTagNo,
      "cattleGender": this.cattleGender,
      "cattleStage": this.cattleStage,
      "cattleWeight": this.cattleWeight,
      "cattleDOB": this.cattleDOB,
      "cattleDOE": this.cattleDOE,
      "cattleObtainMethod": this.cattleObtainMethod,
      "cattleOtherSource": this.cattleOtherSource,
      "cattleMotherTagNo": this.cattleMotherTagNo,
      "cattleFatherTagNo": this.cattleFatherTagNo,
      "cattleNotes": this.cattleNote,
      "cattleStatus": this.cattleStatus,
      "cattleArchive": this.cattleArchive,
      "cattleArchiveReason": this.cattleArchiveReason,
      "cattleArchiveDate": this.cattleArchiveDate,
      "cattleArchiveNotes": this.cattleArchiveNotes,
       "cattleArchiveOtherReason": this.cattleArchiveOtherReason,
    };
  }
}
