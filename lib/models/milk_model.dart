class MilkModel{
  int? id;
  String? milkDate;
  String? milkType;
  String? milkTotalUsed;
  String? milkTotalProduced;
  String? cowMilked;
  String? noOfCattleMilked;

  createMap(){
    return{
      if(id != null) "id" : id.toString(),
      "milkDate": this.milkDate,
      "milkType": this.milkType,
      "milkTotalUsed": this.milkTotalUsed,
      "milkTotalProduced": this.milkTotalProduced,
      "cowMilked": this.cowMilked,
      "noOfCattleMilked": this.noOfCattleMilked,
    };
  }
}

