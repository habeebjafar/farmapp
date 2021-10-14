import 'package:farmapp/models/cattle_model.dart';
import 'package:farmapp/repository/repository.dart';


class CattleService {
  late Repository _repository;

  CattleService() {
    _repository = Repository();
  }

  saveCattle(CattleModel cattle) async {
    return await _repository.saveItem("cattle", cattle.createMap());
   
  }

  getAllTCattles() async {
    return await _repository.getAllItem("cattle");
    
  }

  

  getTodoById(cattleId) async {
    return await _repository.getItemById("cattle", cattleId);
  }

  updateTodo(CattleModel cattle) async {
    return await _repository.updateItem("cattle", cattle.createMap());
    
  }

  deleteTodoById(cattleId) async {
    return await _repository.deleteItemById("cattle", cattleId);
  }
}
