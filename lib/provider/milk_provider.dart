import 'package:farmapp/models/milk_model.dart';
import 'package:farmapp/services/milk_service.dart';
import 'package:flutter/cupertino.dart';

class MilkProvider with ChangeNotifier{

  MilkService _milkService = MilkService();
  List<MilkModel> milkRecordList = [];

  List<MilkModel> milkProducedRecordList = [];
  List<MilkModel> individualMilkProducedRecordList = [];

  double highestProductive = 0.0;
  double leastProductive = 0.0;

  String highestProductiveCow = "";
  String leastProductiveCow = "";
  
  

  double totalMilkedProduced = 0.0;
  double totalMilkedUsed = 0.0;
  double averageDailyMilk = 0.0;



  Future<List<MilkModel>> getAllMilkRecord() async {

    var response = await _milkService.getAllMilkRecord();
    print(response);
     milkProducedRecordList.clear();
     milkRecordList.clear();
    // individualMilkProducedRecordList.clear();
    // milkRecordList.clear();
 
totalMilkedProduced = 0.0;
totalMilkedUsed = 0.0;
   

    response.forEach((data) {
     
        var model = MilkModel();

        model.id = data['id'];
         model.milkDate = data['milkDate'];
        model.milkType = data['milkType'];
        model.milkTotalUsed = data['milkTotalUsed'];
        model.milkTotalProduced = data['milkTotalProduced'];
        model.cowMilked = data['cowMilked'];
        model.noOfCattleMilked = data['noOfCattleMilked'];

         //totalMilkedProduced = 0.0;

        totalMilkedProduced = totalMilkedProduced + double.parse(model.milkTotalProduced.toString());
        totalMilkedUsed =  totalMilkedUsed + double.parse(model.milkTotalUsed.toString());

        milkRecordList.add(model);

       
       milkProducedRecordList.add(model);

       if(model.milkType == "Individual Milk"){

         individualMilkProducedRecordList.add(model);

       }
    
    });


    averageDailyMilk = totalMilkedProduced == 0.0 ? 0.0 : totalMilkedProduced/milkProducedRecordList.length;

     individualMilkProducedRecordList
        .sort((a, b) => a.milkTotalProduced!.compareTo(b.milkTotalProduced!));
  
      leastProductive = individualMilkProducedRecordList.length > 0 ? double.parse(individualMilkProducedRecordList[0].milkTotalProduced.toString()) : 0.0;
     

      highestProductive = individualMilkProducedRecordList.length > 0 ? double.parse(individualMilkProducedRecordList[individualMilkProducedRecordList.length-1].milkTotalProduced.toString()) : 0.0;

      highestProductiveCow = individualMilkProducedRecordList.length > 0 ? individualMilkProducedRecordList[individualMilkProducedRecordList.length-1].cowMilked.toString() : "";
      leastProductiveCow = individualMilkProducedRecordList.length > 0 ? individualMilkProducedRecordList[0].cowMilked.toString() : "";
   
    notifyListeners();
    return milkRecordList;
   }



 
}