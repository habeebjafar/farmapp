import 'package:farmapp/models/event_model.dart';
import 'package:farmapp/repository/repository.dart';


class EventService {
  late Repository _repository;

  EventService() {
    _repository = Repository();
  }

  saveEvent(EventModel eventModel) async {
    return await _repository.saveItem("event", eventModel.createMap());
   
  }

  getAllEventRecord() async {
    return await _repository.getAllItem("event");
    
  }

  

  getTodoById(eventModelId) async {
    return await _repository.getItemById("event", eventModelId);
  }

  updateEvent(EventModel eventModel) async {
    return await _repository.updateItem("event", eventModel.createMap());
    
  }

  deleteEventById(eventModelId) async {
    return await _repository.deleteItemById("event", eventModelId);
  }

}
