
import 'dart:core';

class CattleModel {
  int? id;
  String? cattleBreed;
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



   createMap() {
    return {
      if(id != null) "id" : id.toString(),
      "cattleBreed": this.cattleBreed,
      "cattleName": this.cattleName, 
      "cattleTagNo": this.cattleTagNo, 
      "cattleGender": this.cattleGender, 
      "cattleStage": this.cattleStage, 
      "cattleWeight": this.cattleWeight, 
      "cattleDOB": this.cattleDOB, 
      "cattleDOE": this.cattleDOE, 
      "cattleObtainMethod": this.cattleObtainMethod, 
      "cattleMotherTagNo": this.cattleMotherTagNo, 
      "cattleFatherTagNo": this.cattleFatherTagNo, 
      "cattleNotes": this.cattleName, 
      
    };
  }

  
}