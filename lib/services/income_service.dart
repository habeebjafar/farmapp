import 'package:farmapp/models/income_model.dart';
import 'package:farmapp/repository/repository.dart';


class IncomeService {
  late Repository _repository;

  IncomeService() {
    _repository = Repository();
  }

  saveIncome(IncomeModel income) async {
    return await _repository.saveItem("income", income.createMap());
   
  }

  getAllIncomeRecord() async {
    return await _repository.getAllItem("income");
    
  }

  

  getTodoById(incomeId) async {
    return await _repository.getItemById("income", incomeId);
  }

  updateTodo(IncomeModel incomeId) async {
    return await _repository.updateItem("income", incomeId.createMap());
    
  }

  deleteTodoById(incomeId) async {
    return await _repository.deleteItemById("income", incomeId);
  }

}
