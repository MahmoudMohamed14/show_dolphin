import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/data/models/dolphin_model.dart';
import 'package:new_app/logic/dolphin_state.dart';

import '../data/repository/dolphin_repository.dart';

class DolphinCubit extends Cubit<DolphinStates > {
  DolphinRepository dolphinRepository;
  late Timer time;

 late int counterMemory;
  DolphinCubit(this.dolphinRepository) : super( DolphinInitState());

  static DolphinCubit get(context) {
    return BlocProvider.of(context);
  }

  DolphinModel dolphinModel =  DolphinModel();
   List<DolphinModel>dolphinModelMemory=[];
  DolphinModel getDolphin(){
   // emit(DolphinGetLoadingState());
    /*
    now we use memory one time when open app if we want to reuse we play use code in down
    listDolphinModel=[];


     */
    dolphinRepository.getDolphin().then((dolphinModel) {

      this.dolphinModel=dolphinModel!;
      addToMemory(dolphinModel);
      emit(DolphinGetSuccessState(dolphinModel));



    }).catchError((onError){
      onStop();
     emit( DolphinGetErrorState());

    });
    return dolphinModel;

  }
  void addToMemory(dolphinModel){
    if(dolphinModelMemory.length<5){
      dolphinModelMemory.add(dolphinModel);
    }
  }
 void rewindDolphin(){

   onPlay(isRewindDolphin: true);

  }

  void onStop(){
    time.cancel();
  }
 void  onPlay({bool isRewindDolphin=false}){
  counterMemory=0;

    time =Timer.periodic(const Duration(seconds: 2), (timer) {

      if(!isRewindDolphin){
        getDolphin();

      }
      else{

        if(counterMemory<dolphinModelMemory.length) {
          // print(dolphinModelMemory[counterMemory]);
          emit(DolphinGetSuccessState(dolphinModelMemory[counterMemory]));
          counterMemory+=1;
        }
        else {


          emit(DolphinMemoryCompletionState ("Cannot remember any more dolphins"));
          onStop();
          isRewindDolphin=!isRewindDolphin;

        }

      }

    });

  }
  void closeMemoryMessage(){
    emit(DolphinCloseMemoryCompletionState());
  }



}