
class DolphinModel{

  late String url;
  DolphinModel({this.url=''});

  DolphinModel.fromJson(Map<String,dynamic>  json){

    url=json["raw"];

  }



}