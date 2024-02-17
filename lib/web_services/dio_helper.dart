import 'package:dio/dio.dart';
import 'package:new_app/constant/strings_manager.dart';


class DioHelper{
  static late Dio dio;
  static dolphinWebServices(){
    dio=Dio(
        BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true,

        )
    );
  }

  Future<Map<String, dynamic>?> getDolphin() async {
    try{
      Response response= await dio.get('photos/random',queryParameters: {'query':'dolphin','client_id':"1vR4WmEyaLw0ZRA9pwnecx8DnC4_osZY4_z-alw-VMM"});
     // print(response.data);
    //  dolphinModel=DolphinModel.fromJson(response.data['urls']);
     // print(dolphinModel.url);
      return response.data['urls'];
    }
    catch( error){
      print(error);
      // return{"raw":"https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg"};
      
    }

  }

}