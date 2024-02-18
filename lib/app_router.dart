import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/data/repository/dolphin_repository.dart';
import 'package:new_app/logic/dolphin_cubit.dart';
import 'package:new_app/logic/dolphin_state.dart';
import 'package:new_app/web_services/dio_helper.dart';

import 'constant/strings_manager.dart';
import 'presentation/screens/dolphin_screen.dart';

class AppRouter{
   late DolphinCubit dolphinCubit;
   late DolphinRepository dolphinRepository;
   AppRouter(){
       dolphinRepository=DolphinRepository(DioHelper());
       dolphinCubit=DolphinCubit(dolphinRepository);
   }
   
    Route ?generateRoute(RouteSettings settings){
        switch(settings.name){
            case dolphinScreen:
                return  MaterialPageRoute(builder: (_)=>BlocProvider(create: (BuildContext context)=>dolphinCubit..onPlay(),child: DolphinScreen(dolphinModel: dolphinCubit.getDolphin(),)));
        }
    }
}