import 'package:farmapp/models/income_category_model.dart';
import 'package:farmapp/repository/repository.dart';


class IncomeCategoryService {
  late Repository _repository;

  IncomeCategoryService() {
    _repository = Repository();
  }

  saveIncomeCategory(IncomeCategoryModel income) async {
    return await _repository.saveItem("incomeCategory", income.createMap());
   
  }

  getAllIncomeCategories() async {
    return await _repository.getAllItem("incomeCategory");
    
  }

  

  getTodoById(incomeCategoryId) async {
    return await _repository.getItemById("incomeCategory", incomeCategoryId);
  }

  updateIncomeCategory(IncomeCategoryModel income) async {
    return await _repository.updateItem("incomeCategory", income.createMap());
    
  }

  deleteIncomeCategoryById(incomeCategoryId) async {
    return await _repository.deleteItemById("incomeCategory", incomeCategoryId);
  }

}
