

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:new_app/data/models/dolphin_model.dart';
import 'package:new_app/data/repository/dolphin_repository.dart';
import 'package:new_app/logic/dolphin_cubit.dart';
import 'package:new_app/web_services/dio_helper.dart';
//use mockito to we can use DolphinCubit  of context
class BlocMoc extends DolphinCubit with Mock{
  BlocMoc(super.dolphinRepository);
}
void main(){
  group('Test Dolphin', () {
    DioHelper.dolphinWebServices(); //init dio
    DioHelper dioHelper = DioHelper();
    DolphinRepository dolphinRepository = DolphinRepository(dioHelper);
    BlocMoc bloc = BlocMoc(dolphinRepository);

    //Verify that get date from api
    test('Test Get Data From Dio', () async {
      var data = await dioHelper.getDolphin();
      //data map is data!["raw"] is url we need
      expect(data!["raw"].isNotEmpty, true);
    });
    test('Test Repository', () {
      //Verify that get date from dio path to dolphinRepository

      var dolphinModel = dolphinRepository.getDolphin();

      expect(dolphinModel != null, true);
    });
    test('Test Dolphin add to Memory', () async {
      //Verify that add only five to memory
      List<DolphinModel> dolphinModelList = [
        DolphinModel(),
        DolphinModel(),
        DolphinModel(),
        DolphinModel(),
        DolphinModel(),
        DolphinModel(),
        DolphinModel(),
        DolphinModel(),
      ];
      dolphinModelList.forEach((element) {
        bloc.addToMemory(element);
      });
      expect(bloc.dolphinModelMemory.length == 5, true);
    });

    test('Test Dolphin Bloc getDolphin', () async {
      //Verify that get date from  dolphinRepository to DolphinCubit
      bloc.dolphinRepository.getDolphin().then((value) {
        expect(value!.url.isNotEmpty, true);
      });
    });

    test('Test Dolphin Bloc rewind', () async {
      //Verify that get date from  dolphinRepository to DolphinCubit
      bloc.dolphinRepository.getDolphin().then((value) {
        bloc.addToMemory(value);
        bloc.rewindDolphin();
        expect(bloc.counterMemory, 2);
      });
    });

    test('Test Dolphin Bloc play and Stop', () async {
//      // manually test
//        late Timer time;
//       int  counterMemory=0;
//
// //bloc.dolphinModelMemory=[];
//        time =Timer.periodic(const Duration(seconds: 2), (timer) {
//          counterMemory+=1;
//          var value= bloc.getDolphin();
//          //bloc.addToMemory(value);
//           if(counterMemory==1){
//             time.cancel();
//
//           }
//
//
//        });
//       await  Future.delayed(const Duration(seconds:9 ));
//
//       expect(bloc.dolphinModelMemory.length,1);
       // expect(counterMemory, 3);
       bloc.onPlay();
       await Future.delayed(const Duration(seconds: 6));
       bloc.onStop();
       expect(bloc.dolphinModelMemory.length>0, true);

  });
  });
}