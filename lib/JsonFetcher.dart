class JsonFetcher{
  final String garageDoor;
  final String openClose;
  final String dateTime;
  JsonFetcher._({this.garageDoor, this.openClose, this.dateTime});
 factory JsonFetcher.fromJson(Map<String, dynamic> json){
   return new JsonFetcher._(
       garageDoor: json['GARAGE'],
       openClose: json['OPENCLOSE'],
       dateTime: json['DATETIME']
   );
 }
}