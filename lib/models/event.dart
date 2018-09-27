class Event {
  // PROPERTIES //
  int _id;
  int _hostId;
  String _name;
  String _description;
  String _locationName;
  DateTime _startTime;
  DateTime _endTime;
  int _age;
  int _price;
  String _category;
  int _one;
  int _two;
  int _three;
  int _four;
  int _five;
  num _rating;
  bool _isUsed;
  DateTime _creationDate;

  // CONSTRUCTORS //
  Event.create();
  Event({int hostId, String name, String description, String locationName, DateTime startTime, DateTime endTime, 
  int age,int price, String category, int one, int two, int three, int four, int five, num rating, bool isUsed=true}) {
    hostId = hostId;
    name = name;
    description = description;
    locationName = locationName;
    startTime = startTime;
    endTime = endTime;
    age = age;
    price = price;
    category = category;
    one = one;
    two = two;
    three = three;
    four = four;
    five = five;
    rating = rating;
    isUsed = isUsed;
    creationDate = DateTime.now();
  }
  Event.createFromMap(Iterable<Map<String, dynamic>> map){
    map.forEach((item) {
      this._id = item['id'];
      this._hostId = item['host_id'];
      this._name = item['name'];
      this._description = item['description'];
      this._locationName = item['locationName'];
      this._startTime= item['startTime'];
      this._endTime = item['endTime'];
      this._age = item['age'];
      this._price = item['price'];
      this._category = item['category'];
      this._one = item['one'];
      this._two = item['two'];
      this._three = item['three'];
      this._four = item['four'];
      this._five = item['five'];
      this._rating = item['rating'];
      this._isUsed = item['isUsed'];
      this._creationDate = item['creationDate'];
    });
  }

  // GETTERS //
  int get id => _id;
  int get hostId => _hostId;
  String get name => _name;
  String get description => _description;
  String get locationName => _locationName;
  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  int get age => _age;
  int get price => _price;
  String get category => _category;
  int get one => _one;
  int get two => _two;
  int get three => _three;
  int get four => _four;
  int get five => _five;
  num get rating => _rating;
  bool get isUsed => _isUsed;
  DateTime get creationDate => _creationDate;

  // SETTERS //
  set id(int id) => _id = id;
  set hostId(int hostId) => _hostId = hostId;
  set name(String name) => _name = name;
  set description(String description) => _description = description;
  set locationName(String locationName) => _locationName = locationName;
  set startTime(DateTime startTime) => _startTime = startTime;
  set endTime(DateTime endTime) => _endTime = endTime;
  set age(int age) => _age = age;
  set price(int price) => _price = price;
  set category(String category) => _category = category;
  set one(int one) => _one = one;
  set two(int two) => _two = two;
  set three(int three) => _three = three;
  set four(int four) => _four = four;
  set five(int five) => _five = five;
  set rating(num rating) => _rating = rating;
  set isUsed(bool isUsed) => _isUsed = isUsed;
  set creationDate(DateTime creationDate) => _creationDate = creationDate;

  // METHODS //
  /// Return a Map<String, dynamic> with keys are the properties of User, values are the properties' values.
  Map<String, dynamic> getProperties() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['hostId'] = hostId;
    map['name'] = name;
    map['description'] = description;
    map['locationName'] = locationName;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['age'] = age;
    map['price'] = price;
    map['category'] = category;
    map['one'] = one;
    map['two'] = two;
    map['three'] = three;
    map['four'] = four;
    map['five'] = five;
    map['rating'] = rating;
    map['isUsed'] = isUsed;
    map['creationDate'] = creationDate;

    return map;
  }

  String toString() => "An instance of Event id=$id, name=$name";

}