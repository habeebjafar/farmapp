
class EventIndividualModel{
  int? id;
  String? eventDate;
  String? eventType;
  String? nameOfMedicine;
  String? eventNotes;
  String? cattleId;
  String? cattleTagNo;
 
  createMap(){
    return{
      if(id != null) "id" : id.toString(),
      "eventDate": this.eventDate,
      "eventType": this.eventType,
      "nameOfMedicine": this.nameOfMedicine,
      "eventNotes": this.eventNotes,
      "cattleId": this.cattleId,
      "cattleTagNo": this.cattleTagNo
      
    };
  }
}

