import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/constant/size_manager.dart';
import 'package:new_app/data/models/dolphin_model.dart';
import 'package:new_app/logic/dolphin_cubit.dart';
import 'package:new_app/logic/dolphin_state.dart';

class DolphinScreen extends StatelessWidget {
  DolphinModel dolphinModel;

  String message='';

 DolphinScreen({Key? key,required this.dolphinModel}) : super(key: key);




  Widget showCircularProgressIndicator(){
    return const Center(child: CircularProgressIndicator());
  }

  Widget designImage(context){
    return Column(
      children: [
        Expanded(
            child:  Container(
              width: AppSize.sInfinity,

              decoration: BoxDecoration(


                  borderRadius: BorderRadius.circular(AppSize.s20),
                  image:DecorationImage(image: NetworkImage( dolphinModel.url,),fit: BoxFit.fill)


              ),

            )
        ),

        const SizedBox(height: AppSize.s20,),
        Row(
          children: [
            Expanded(child: ElevatedButton(onPressed: (){
              BlocProvider.of<DolphinCubit>(context).onStop();
            }, child: const Text('Stop'))),
            const SizedBox(width: AppSize.s20,),
            Expanded(child: ElevatedButton(onPressed: (){
              BlocProvider.of<DolphinCubit>(context).onStart();
            }, child:  const Text('Play'))),
            const SizedBox(width: AppSize.s20,),
            Expanded(child: ElevatedButton(onPressed: (){
              BlocProvider.of<DolphinCubit>(context).rewindDolphin();
            }, child:  const Text('Rewind'))),
          ],
        )
      ],
    );
  }

  Widget designError(context){
    return const  Center(
      child: Text('')// Image(image:AssetImage('assets/error.gif')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          title:const Text('Dolphin',style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: BlocConsumer<DolphinCubit,DolphinStates>(
            listener: (context,state){
              if(state is DolphinGetSuccessState){dolphinModel=state.dolphinModel;}

              if(state is DolphinMemoryCompletionState){
                message=state.message;
              }
            },
            builder: (context,state){
              return Stack(

                children: [

                  Visibility(
                    // this code use to load when get image from api
                    // visible: state is DolphinGetLoadingState,
                    // child: showCircularProgressIndicator(),
                    visible: dolphinModel.url.isNotEmpty,
                    child: designImage(context),
                    replacement:designError(context),// dolphinModel.url.isNotEmpty?designImage(context)  : designError(context),

                  ),


                  Visibility(
                    visible: state is DolphinMemoryCompletionState,
                    child: Container(
                      margin: EdgeInsets.all(AppSize.s10),

                      width: AppSize.sInfinity,

                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(.3),
                        border: Border.all(),

                        borderRadius: BorderRadius.circular(AppSize.s20),



                      ),


                      child:  Row(
                        children: [
                          Expanded(

                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child: Text(message,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                            ),
                          ),
                         
                          IconButton(onPressed:(){
                            BlocProvider.of<DolphinCubit>(context).closeMemoryMessage();
                          },icon: Icon(Icons.close,color: Colors.red,))

                        ],
                      ),
                    ),
                  ),
                ],
              );
            },

          ),
        )
    );
  }
}

