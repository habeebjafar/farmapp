import 'package:farmapp/models/event_individual_model.dart';
import 'package:farmapp/models/event_model.dart';
import 'package:farmapp/repository/repository.dart';


class EventIndividualService {
  late Repository _repository;

  EventIndividualService() {
    _repository = Repository();
  }

  saveEvent(EventIndividualModel eventModel) async {
    return await _repository.saveItem("eventIndividual", eventModel.createMap());
   
  }

  getAllEventRecord() async {
    return await _repository.getAllItem("eventIndividual");
    
  }

  

  getTodoById(eventModelId) async {
    return await _repository.getItemById("eventIndividual", eventModelId);
  }

  updateTodo(EventIndividualModel eventModel) async {
    return await _repository.updateItem("eventIndividual", eventModel.createMap());
    
  }

  deleteTodoById(eventModelId) async {
    return await _repository.deleteItemById("eventIndividual", eventModelId);
  }

}
