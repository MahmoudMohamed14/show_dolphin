import 'package:new_app/data/models/dolphin_model.dart';
import 'package:new_app/web_services/dio_helper.dart';

class DolphinRepository{
  final DioHelper dioHelper;
  DolphinRepository(this.dioHelper);
  Future<DolphinModel?> getDolphin() async {

     final   dolphins= await dioHelper.getDolphin();
    return DolphinModel.fromJson(dolphins!);



  }


}