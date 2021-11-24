import 'package:farmapp/models/farm_note_model.dart';
import 'package:farmapp/services/farm_note_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FarmNoteProvider with ChangeNotifier {
  FarmNoteService _service = FarmNoteService();
  List<FarmNoteModel> farmNoteList = [];

  Future<bool> saveFarmNote(title, message, {updateId}) async {
    var date = DateTime.now();
    var time = TimeOfDay.now();
    var response;
    var model = FarmNoteModel();
    model.title = title;
    model.message = message;
    model.date = date.toString();

    if (updateId != null) {
      model.id = updateId;
      response = await _service.updateFarmNote(model);
    } else {
      response = await _service.saveFarmNote(model);
    }
    notifyListeners();

    if (response > 0) {
      print(response);
      return true;
    }
    return false;
  }

  Future<List<FarmNoteModel>> getAllFarmNotes() async {
     var response = await _service.getAllFarmNotes();
    farmNoteList.clear();
   
    response.forEach((data) {
      var model = FarmNoteModel();
      model.id = data['id'];
      model.title = data['title'];
      model.message = data['message'];
      model.date = data['date'];
      farmNoteList.add(model);
    });

    notifyListeners();
    return farmNoteList;
  }

 Future<bool> deleteFarmNoteById(farmNoteId) async{
    var response = await _service.deleteFarmNote(farmNoteId);
    if(response > 0){
      return true;
    }
    return false;
  }
}
