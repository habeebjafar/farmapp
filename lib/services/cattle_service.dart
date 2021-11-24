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

  

  getCattleById(cattleId) async {
    return await _repository.getItemById("cattle", cattleId);
  }

  updateCattle(CattleModel cattle) async {
    return await _repository.updateItem("cattle", cattle.createMap());
    
  }

  updateCattleSingleField(conditionalColumn, colunmName, colunmValue, id) async{

    return await _repository.updateSingleField("cattle", conditionalColumn, colunmName, colunmValue, id);
  }

  deleteTodoById(cattleId) async {
    return await _repository.deleteItemById("cattle", cattleId);
  }
}
