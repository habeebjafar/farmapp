import 'package:farmapp/models/expense_category_model.dart';
import 'package:farmapp/models/expense_model.dart';
import 'package:farmapp/models/income_category_model.dart';
import 'package:farmapp/models/income_model.dart';
import 'package:farmapp/repository/repository.dart';
import 'package:farmapp/services/expense_category_service.dart';
import 'package:farmapp/services/expense_service.dart';
import 'package:farmapp/services/income_category_service.dart';
import 'package:farmapp/services/income_service.dart';
import 'package:flutter/cupertino.dart';

class TransactionsProvider with ChangeNotifier {
   Repository _repository = Repository();
  IncomeService _incomeService = IncomeService();
  List<IncomeModel> incomeList = [];

  IncomeCategoryService _incomeCategoryService = IncomeCategoryService();
  List<IncomeCategoryModel> incomeCategoryList = [];
  List<String> incomeCategoryNameList = [];
  List<String> incomeCategoryIdList = [];

  ExpenseService _expenseService = ExpenseService();
  List<ExpenseModel> expenseList = [];

  ExpenseCategoryService _expenseCategoryService = ExpenseCategoryService();
  List<ExpenseCategoryModel> expenseCategoryList = [];
  List<String> expenseCategoryNameList = [];
  List<String> expenseCategoryIdList = [];

  String selectedValueIncomeCategory = "";

  String selectedValueExpenseCategory = "";


   saveIncome(incomeDate, incomeNote, incomeType, milkQty, receiptNum, amountEarned, selectedValueIncomeCategory, incomeCategoryId, otherSource, {updateId}) async {
    var incomeModel = IncomeModel();

    incomeModel.incomeDate = incomeDate;
    incomeModel.incomeNotes = incomeNote;
    incomeModel.incomeType = incomeType;
    incomeModel.milkQty = milkQty;
    incomeModel.receiptNo = receiptNum;
    incomeModel.amountEarned = amountEarned;
    incomeModel.selectedValueIncomeCategory = selectedValueIncomeCategory;
    incomeModel.incomeCategoryId = incomeCategoryId;
    incomeModel.otherSource = otherSource;

    var response;
    if(updateId != null){
      incomeModel.id = updateId;
      response = await _incomeService.updateIncome(incomeModel);


    }else{
      response = await _incomeService.saveIncome(incomeModel);
    }
    

    if (response > 0) {
      print("added successfully $response");
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => MassEvent()));
    } else {
      print("no value added");
    }
    notifyListeners();
  }
 

  getAllIncomeRecord() async {
    var response = await _incomeService.getAllIncomeRecord();
    print(response);
    incomeList.clear();

    response.forEach((data) {
      var model = IncomeModel();

      model.id = data['id'];
      model.incomeDate = data['incomeDate'];
      model.incomeType = data['incomeType'];
      model.milkQty = data['milkQty'];
      model.selectedValueIncomeCategory = data['selectedValueIncomeCategory'];
      model.incomeCategoryId = data['incomeCategoryId'];
      model.otherSource = data['otherSource'];
      model.amountEarned = data['amountEarned'];
      model.receiptNo = data['receiptNo'];
      model.incomeNotes = data['incomeNotes'];

      incomeList.add(model);

     
    });
     notifyListeners();
  }

  Future<List<IncomeCategoryModel>> getAllIncomeCategory() async {
   
    var response = await _incomeCategoryService.getAllIncomeCategories();
    print(response);
    incomeCategoryList.clear();
    incomeCategoryIdList.clear();
    incomeCategoryNameList.clear();

    response.forEach((data) {
      var model = IncomeCategoryModel();
      model.id = data['id'];
      model.incomeCategory = data['incomeCategory'];

      incomeCategoryList.add(model);
      incomeCategoryNameList.add(model.incomeCategory!);
      incomeCategoryIdList.add(model.id.toString());

       
    });

    notifyListeners();
      
   

     return incomeCategoryList;
     
  }

   updateIncomeSingleField(conditionalColumn, colunmName, colunmValue, id) async{
   await _incomeService.updateIncomeSingleField(conditionalColumn, colunmName, colunmValue, id);
    notifyListeners();
  }

  
deleteIncomeCategoryById(incomeCategoryId) async{

    var response = await _incomeCategoryService.deleteIncomeCategoryById(incomeCategoryId);

    if(response > 0){

      print("incomeCategoryId deleted");

       var incomeIdResponse =  await _repository.deleteByColunmName("income", "incomeCategoryId", incomeCategoryId);
           if(incomeIdResponse > 0){
        print("incomeIdResponse event deleted");

      } else { print("No incomeIdResponse event deleted"); }

     


    }else {
      print("No Income Category deleted");
    }

    notifyListeners();

}


   saveExpense(expenseDate, expenseNote, expenseType, receiptNum, amountSpent, selectedValueExpenseCategory, expenseCategoryId, otherExpense, {updateId}) async {
    var expenseModel = ExpenseModel();

    expenseModel.expenseDate = expenseDate;
    expenseModel.expenseNotes = expenseNote;
    expenseModel.expenseType = expenseType;
    expenseModel.receiptNo = receiptNum;
    expenseModel.amountSpent = amountSpent;
    expenseModel.selectedValueExpenseCategory = selectedValueExpenseCategory;
    expenseModel.expenseCategoryId = expenseCategoryId;
    expenseModel.otherExpense = otherExpense;

    var response;
    if(updateId != null){
      expenseModel.id = updateId;
      response = await _expenseService.updateExpense(expenseModel);


    }else{
      response = await _expenseService.saveIncome(expenseModel);
    }
    

    if (response > 0) {
      print("added successfully $response");
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => MassEvent()));
    } else {
      print("no value added");
    }
    notifyListeners();
  }

    getAllExpensesRecord() async {
    var response = await _expenseService.getAllExpenseRecord();
    print(response);
    expenseList.clear();

    response.forEach((data) {
     
        var model = ExpenseModel();

        model.id = data['id'];
       model.expenseDate = data['expenseDate'];
        model.expenseType = data['expenseType'];
        model.amountSpent = data['amountSpent'];
        model.receiptNo = data['receiptNo'];
        model.expenseNotes = data['expenseNotes'];
        model.selectedValueExpenseCategory = data['selectedValueExpenseCategory'];
        model.expenseCategoryId = data['expenseCategoryId'];
        model.otherExpense = data['otherExpense'];

        expenseList.add(model);
     
    });
    notifyListeners();
  }

  Future<List<ExpenseCategoryModel>> getAllExpenseCategory() async {
    var response = await _expenseCategoryService.getAllExpenseCategories();
    expenseCategoryList.clear();
    expenseCategoryNameList.clear();
    expenseCategoryIdList.clear();

    response.forEach((data) {

      var model = ExpenseCategoryModel();

      model.id = data['id'];
      model.expenseCategory = data['expenseCategory'];

      expenseCategoryList.add(model);
      expenseCategoryNameList.add(model.expenseCategory!);
      expenseCategoryIdList.add(model.id.toString());

      

     
     
    });

     notifyListeners();

     return expenseCategoryList;
  }

  
   updateExpenseSingleField(conditionalColumn, colunmName, colunmValue, id) async{
   await _expenseService.updateExpenseSingleField(conditionalColumn, colunmName, colunmValue, id);
    notifyListeners();
  }

  
deleteExpenseById(expenseCategoryId) async{

    var response = await _expenseCategoryService.deleteExpensiveCategoryById(expenseCategoryId);

    if(response > 0){

      print("expenseCategoryId deleted");

       var expenseCategoryResponse =  await _repository.deleteByColunmName("expenses", "expenseCategoryId", expenseCategoryId);
           if(expenseCategoryResponse > 0){
        print("expenseCategoryId event deleted");

      } else { print("No expenseCategoryId event deleted"); }

     


    }else {
      print("No expenseCategoryId Category deleted");
    }

    notifyListeners();

}
  
}
