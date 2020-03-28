class Canteen {
  final int id;
  final String name;
  final String description;

  Canteen({this.id, this.name, this.description});

  Canteen.fromData(Map<String, dynamic> data)
    : id = data['CanteenID'],
      name = data['CanteenName'],
      description = data['CanteenDescription'];

  Map<String, dynamic> toJson() {
    return {
      'CanteenID' : id,
      'CanteenName' : name,
      'CanteenDescription' : description
    };
  }
}