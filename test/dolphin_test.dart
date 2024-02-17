import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:new_app/data/models/dolphin_model.dart';
import 'package:new_app/data/repository/dolphin_repository.dart';
import 'package:new_app/logic/dolphin_cubit.dart';
import 'package:new_app/web_services/dio_helper.dart';
class BlocMoc extends DolphinCubit with Mock{
  BlocMoc(super.dolphinRepository);
}
void main(){
  group('Test Dolphin', () {
    DioHelper.dolphinWebServices();
    DioHelper dioHelper=DioHelper();
    DolphinRepository dolphinRepository=DolphinRepository(dioHelper);

    test('Test Get Data From Dio', ()
    async {



      var test=await dioHelper.getDolphin();

      expect(test!["raw"].isNotEmpty, true);

    }
    );
    test('Test Repository', ()
    {

    var dolphinModel= dolphinRepository.getDolphin();

      expect(dolphinModel!=null, true);
    }
    );
    test('Test Dolphin Bloc', () async {
      BlocMoc bloc=BlocMoc(dolphinRepository);

     bloc.dolphinRepository.getDolphin().then((value) {
       bloc.addToMemory(value);
       expect(bloc.dolphinModelMemory.length, 1);
     });






    });
  });



}