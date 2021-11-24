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

  updateIncome(IncomeModel incomeId) async {
    return await _repository.updateItem("income", incomeId.createMap());
    
  }

   updateIncomeSingleField(conditionalColumn, colunmName, colunmValue, id) async{

    return await _repository.updateSingleField("income", conditionalColumn, colunmName, colunmValue, id);
  }

  deleteSaveById(incomeId) async {
    return await _repository.deleteItemById("income", incomeId);
  }

}
