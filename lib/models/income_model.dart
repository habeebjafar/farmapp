class IncomeModel{
  int? id;
  String? incomeDate;
  String? incomeType;
  String? milkQty;
  String? incomeNotes;
  String? amountEarned;
  String? receiptNo;
 
  createMap(){
    return{
      if(id != null) "id" : id.toString(),
      "incomeDate": this.incomeDate,
      "incomeType": this.incomeType,
      "milkQty": this.milkQty,
      "incomeNotes": this.incomeNotes,
      "amountEarned": this.amountEarned,
      "receiptNo": this.receiptNo
      
    };
  }
}

