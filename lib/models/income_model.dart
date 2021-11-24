class IncomeModel{
  int? id;
  String? incomeDate;
  String? incomeType;
  String? milkQty;
  String? selectedValueIncomeCategory;
  String? incomeCategoryId;
  String? otherSource;
  String? incomeNotes;
  String? amountEarned;
  String? receiptNo;
 
  createMap(){
    return{
      if(id != null) "id" : id.toString(),
      "incomeDate": this.incomeDate,
      "incomeType": this.incomeType,
      "milkQty": this.milkQty,
      "selectedValueIncomeCategory": this.selectedValueIncomeCategory,
      "otherSource": this.otherSource,
      "incomeCategoryId": this.incomeCategoryId,
      "incomeNotes": this.incomeNotes,
      "amountEarned": this.amountEarned,
      "receiptNo": this.receiptNo
      
    };
  }
}

