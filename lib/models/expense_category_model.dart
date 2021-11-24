class ExpenseCategoryModel{
  int? id;
  String? expenseCategory;

   createMap() {
    return {
      if(id != null) "id" : id.toString(),
      "expenseCategory": this.expenseCategory,
      
     
      
    };
  }

}