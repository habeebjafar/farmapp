import 'package:farmapp/models/farm_note_model.dart';
import 'package:farmapp/repository/repository.dart';

class FarmNoteService{

  late Repository _repository;
  FarmNoteService(){
    _repository = Repository();
  }


  saveFarmNote(FarmNoteModel model) async{
    return await _repository.saveItem("farmNotes", model.createMap());
  }

  getAllFarmNotes() async{
    return await _repository.getAllItem("farmNotes");
  }
  

  getFarmNoteById(farmNoteId) async{
    return await _repository.getItemById("farmNotes", farmNoteId);
  }

  updateFarmNote(FarmNoteModel model) async{
    return await _repository.updateItem("farmNotes", model.createMap());
  }

  deleteFarmNote(farmNoteId) async{
    return await _repository.deleteItemById("farmNotes", farmNoteId);
  }


}