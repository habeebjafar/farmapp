import 'package:farmapp/models/cattle_breed_model.dart';
import 'package:farmapp/repository/repository.dart';


class CattleBreedService {
  late Repository _repository;

  CattleBreedService() {
    _repository = Repository();
  }

  saveCattle(CattleBreedModel cattle) async {
    return await _repository.saveItem("cattleBreed", cattle.createMap());
   
  }

  getAllTCattleBreeds() async {
    return await _repository.getAllItem("cattleBreed");
    
  }

  

  getTodoById(cattleId) async {
    return await _repository.getItemById("cattleBreed", cattleId);
  }

  updateTodo(CattleBreedModel cattle) async {
    return await _repository.updateItem("cattleBreed", cattle.createMap());
    
  }

  deleteTodoById(cattleId) async {
    return await _repository.deleteItemById("cattleBreed", cattleId);
  }

}
