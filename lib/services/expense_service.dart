import 'package:farmapp/models/expense_model.dart';
import 'package:farmapp/repository/repository.dart';


class ExpenseService {
  late Repository _repository;

  ExpenseService() {
    _repository = Repository();
  }

  saveIncome(ExpenseModel expense) async {
    return await _repository.saveItem("expenses", expense.createMap());
   
  }

  getAllExpenseRecord() async {
    return await _repository.getAllItem("expenses");
    
  }

  

  getTodoById(expenseId) async {
    return await _repository.getItemById("expenses", expenseId);
  }

  updateExpense(ExpenseModel expense) async {
    return await _repository.updateItem("expenses", expense.createMap());
    
  }

   updateExpenseSingleField(conditionalColumn, colunmName, colunmValue, id) async{

    return await _repository.updateSingleField("expenses", conditionalColumn, colunmName, colunmValue, id);
  }

  deleteExpenseById(expenseId) async {
    return await _repository.deleteItemById("expenses", expenseId);
  }

}
