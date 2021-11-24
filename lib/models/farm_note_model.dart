class FarmNoteModel{
  int? id;
  String? title;
  String? message;
  String? date;

  createMap(){
    return{
      if(id != null) "id" : id.toString(),
      "title": this.title,
      "message": this.message,
      "date": this.date
      
    };
  }
}