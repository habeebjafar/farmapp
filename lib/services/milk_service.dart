import 'package:farmapp/models/milk_model.dart';
import 'package:farmapp/repository/repository.dart';


class MilkService {
  late Repository _repository;

  MilkService() {
    _repository = Repository();
  }

  saveMilk(MilkModel milkModel) async {
    return await _repository.saveItem("milk", milkModel.createMap());
   
  }

  getAllMilkRecord() async {
    return await _repository.getAllItem("milk");
    
  }

  

  getTodoById(milkModelId) async {
    return await _repository.getItemById("milk", milkModelId);
  }

  updateMilk(MilkModel milkModel) async {
    return await _repository.updateItem("milk", milkModel.createMap());
    
  }

  deleteTodoById(milkModelId) async {
    return await _repository.deleteItemById("milk", milkModelId);
  }

}
