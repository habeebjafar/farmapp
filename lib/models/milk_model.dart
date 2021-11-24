class MilkModel{
  int? id;
  String? cattleId;
  String? milkDate;
  String? milkType;
  String? milkTotalUsed;
  String? milkTotalProduced;
  String? cowMilked;
  String? noOfCattleMilked;

  createMap(){
    return{
      if(id != null) "id" : id.toString(),
      "cattleId": this.cattleId,
      "milkDate": this.milkDate,
      "milkType": this.milkType,
      "milkTotalUsed": this.milkTotalUsed,
      "milkTotalProduced": this.milkTotalProduced,
      "cowMilked": this.cowMilked,
      "noOfCattleMilked": this.noOfCattleMilked,
    };
  }
}

