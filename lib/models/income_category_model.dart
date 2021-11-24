class IncomeCategoryModel{
  int? id;
  String? incomeCategory;

   createMap() {
    return {
      if(id != null) "id" : id.toString(),
      "incomeCategory": this.incomeCategory,
      
     
      
    };
  }

}