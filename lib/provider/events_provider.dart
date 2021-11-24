import 'package:farmapp/models/event_individual_model.dart';
import 'package:farmapp/models/event_model.dart';
import 'package:farmapp/services/event_individual_service.dart';
import 'package:farmapp/services/event_service.dart';
import 'package:flutter/foundation.dart';

class EventsProvider with ChangeNotifier {
  EventIndividualService _eventService = EventIndividualService();
  List<EventIndividualModel> individualEventsList = [];
  List<EventIndividualModel> treatededCattleEventsList = [];
  List<EventIndividualModel> dryOffCattleEventsList = [];
  List<EventIndividualModel> matedCattleEventsList = [];
  List<EventIndividualModel> abortedCattleEventsList = [];
  List<EventIndividualModel> weighedCattleEventsList = [];
  List<EventIndividualModel> birthedCattleEventsList = [];
  List<EventIndividualModel> weanedCattleEventsList = [];
  List<EventIndividualModel> vaccinatedCattleEventsList = [];
  List<EventIndividualModel> pregnantCattleEventsList = [];
  List<EventIndividualModel> castratedCattleEventsList = [];
  List<EventIndividualModel> otherCattleEventsList = [];

  EventService _masseventService = EventService();
  List<EventModel> massEventsList = [];
  List<EventModel> treatededCattleMassEventsList = [];
  List<EventModel> vaccinatedCattleMassEventsList = [];
  List<EventModel> herdSprayCattleMassEventsList = [];
  List<EventModel> taggedCattleMassEventsList = [];
  List<EventModel> otherCattleMassEventsList = [];

  var provider;

  Future<List<EventIndividualModel>> getAllIndividualEventRecord(
      {cattleId, searchEventType}) async {
    var response = await _eventService.getAllEventRecord();
    print(response);

    individualEventsList.clear();
    treatededCattleEventsList.clear();
    dryOffCattleEventsList.clear();
    matedCattleEventsList.clear();
    weighedCattleEventsList.clear();
    birthedCattleEventsList.clear();
    weanedCattleEventsList.clear();
    vaccinatedCattleEventsList.clear();
    pregnantCattleEventsList.clear();
    abortedCattleEventsList.clear();
    castratedCattleEventsList.clear();
    otherCattleEventsList.clear();

    response.forEach((data) {
      var model = EventIndividualModel();

      model.id = data['id'];
      model.cattleId = data['cattleId'];
      model.eventDate = data['eventDate'];
      model.eventType = data['eventType'];
      model.nameOfMedicine = data['nameOfMedicine'];
      model.eventNotes = data['eventNotes'];
      model.cattleTagNo = data['cattleTagNo'];

      if (model.eventType == "Treated/Medicated") {
        treatededCattleEventsList.add(model);
      } else if (model.eventType == "Inseminated/Mated") {
        matedCattleEventsList.add(model);
      } else if (model.eventType == "Weighed") {
        weighedCattleEventsList.add(model);
      } else if (model.eventType == "Gave Birth") {
        birthedCattleEventsList.add(model);
      } else if (model.eventType == "Weaned") {
        weanedCattleEventsList.add(model);
      } else if (model.eventType == "Vaccinated") {
        vaccinatedCattleEventsList.add(model);
      } else if (model.eventType == "Pregnant") {
        pregnantCattleEventsList.add(model);
      } else if (model.eventType == "Castrated") {
        castratedCattleEventsList.add(model);
      } else if (model.eventType == "Dry Off") {
        dryOffCattleEventsList.add(model);
      } else if (model.eventType == "Aborted Pregnancy") {
        abortedCattleEventsList.add(model);
      } else if (model.eventType == "Other") {
        otherCattleEventsList.add(model);
      }

      if (model.cattleId == cattleId.toString()) {
        individualEventsList.add(model);
      }

      if (searchEventType.toString() == "All") {
        individualEventsList.add(model);
      }
    });

    notifyListeners();

    return individualEventsList;
  }

  Future<List<EventModel>> getAllMassEventRecord({getAll}) async {
    var response = await _masseventService.getAllEventRecord();
    print(response);

    massEventsList.clear();
    treatededCattleMassEventsList.clear();
    vaccinatedCattleMassEventsList.clear();
    herdSprayCattleMassEventsList.clear();
    taggedCattleMassEventsList.clear();
    otherCattleMassEventsList.clear();

    response.forEach((data) {
      var model = EventModel();

      model.id = data['id'];
      model.eventDate = data['eventDate'];
      model.eventType = data['eventType'];
      model.nameOfMedicine = data['nameOfMedicine'];
      model.eventNotes = data['eventNotes'];

      if (model.eventType == "Treatment/Medication") {
        treatededCattleMassEventsList.add(model);
      } else if (model.eventType == "Vacination/Injection") {
        vaccinatedCattleMassEventsList.add(model);
      } else if (model.eventType == "Herd Spraying") {
        herdSprayCattleMassEventsList.add(model);
      } else if (model.eventType == "Tagging") {
        taggedCattleMassEventsList.add(model);
      } else if (model.eventType == "Other") {
        otherCattleMassEventsList.add(model);
      }

      if (getAll == "All") {
        massEventsList.add(model);
      }
    });

    notifyListeners();
    return massEventsList;
  }
}
