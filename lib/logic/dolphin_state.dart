import 'package:new_app/data/models/dolphin_model.dart';

abstract class DolphinStates{}
class DolphinInitState extends  DolphinStates{}
class DolphinGetLoadingState extends  DolphinStates{}
class DolphinGetSuccessState extends  DolphinStates{
 late DolphinModel dolphinModel;
 DolphinGetSuccessState(this.dolphinModel);
}
class DolphinGetRewindState extends DolphinStates{
 late DolphinModel dolphinModel;
 DolphinGetRewindState(this.dolphinModel);
}
class DolphinGetErrorState extends DolphinStates{

}
class DolphinMemoryCompletionState extends DolphinStates{
 late String message;
 DolphinMemoryCompletionState(this.message);
}
class DolphinCloseMemoryCompletionState extends DolphinStates{

}
