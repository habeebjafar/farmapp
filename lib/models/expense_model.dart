class ExpenseModel{
  int? id;
  String? expenseDate;
  String? expenseType;
  String? selectedValueExpenseCategory;
  String? expenseCategoryId;
  String? otherExpense;
  String? amountSpent;
  String? expenseNotes;
  String? receiptNo;
  
 
  createMap(){
    return{
      if(id != null) "id" : id.toString(),
      "expenseDate": this.expenseDate,
      "expenseType": this.expenseType,
      "selectedValueExpenseCategory": this.selectedValueExpenseCategory,
      "expenseCategoryId": this.expenseCategoryId,
      "otherExpense": this.otherExpense,
      "expenseNotes": this.expenseNotes,
      "amountSpent": this.amountSpent,
      "receiptNo": this.receiptNo
      
    };
  }
}

