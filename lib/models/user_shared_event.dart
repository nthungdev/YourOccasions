class UserSharedEvent {
  // PROPERTIES //
  int id;
  String userId;
  int eventId;
  int sharerId;
  DateTime creationDate;

  // CONSTRUCTORS //
  UserSharedEvent.create();
  UserSharedEvent({this.userId, this.eventId, this.sharerId}){
    creationDate = DateTime.now();
  }
  UserSharedEvent.createFromMap(Iterable<Map<String, dynamic>> map){
    map.forEach((item) {
      id = item['id'];
      userId = item['user_id'];
      eventId= item['event_id'];
      sharerId = item['sharer_id'];
      creationDate = item['creation_date'];
    });
  }

  // GETTERS //
  // int get id => _id;
  // String get userId => _userId;
  // int get eventId => _eventId;
  // int get sharerId => _sharerId;
  // DateTime get creationDate => _creationDate;

  // SETTERS //
  // set id(int id) => _id = id;
  // set userId(String userId) => _userId = userId;
  // set eventId(int eventId) => _eventId = eventId;
  // set sharerId(int sharerId) => _sharerId = sharerId;
  // set creationDate(DateTime creationDate) => _creationDate = creationDate;

  // METHODS //

  /// Return a Map<int, dynamic> with keys are the properties of UserSharedEvent, values are the properties' values.
  Map<String, dynamic> getProperties() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['userId'] = userId;
    map['eventId'] = eventId;
    map['sharerId'] = sharerId;
    map['creationDate'] = creationDate;
    return map;
  }

}