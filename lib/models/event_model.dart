class EventModel{
  int? id;
  String? eventDate;
  String? eventType;
  String? nameOfMedicine;
  String? eventNotes;
 
  createMap(){
    return{
      if(id != null) "id" : id.toString(),
      "eventDate": this.eventDate,
      "eventType": this.eventType,
      "nameOfMedicine": this.nameOfMedicine,
      "eventNotes": this.eventNotes,
      
    };
  }
}

