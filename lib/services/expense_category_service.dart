import 'package:farmapp/models/expense_category_model.dart';
import 'package:farmapp/repository/repository.dart';


class ExpenseCategoryService {
  late Repository _repository;

  ExpenseCategoryService() {
    _repository = Repository();
  }

  saveExpenseCategory(ExpenseCategoryModel expense) async {
    return await _repository.saveItem("expenseCategory", expense.createMap());
   
  }

  getAllExpenseCategories() async {
    return await _repository.getAllItem("expenseCategory");
    
  }

  

  getTodoById(incomeCategoryId) async {
    return await _repository.getItemById("expenseCategory", incomeCategoryId);
  }

  updateExpensiveCategory(ExpenseCategoryModel expense) async {
    return await _repository.updateItem("expenseCategory", expense.createMap());
    
  }

  deleteExpensiveCategoryById(expenseCategoryId) async {
    return await _repository.deleteItemById("expenseCategory", expenseCategoryId);
  }

}
