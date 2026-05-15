 abstract class UserState{}

 class UserInitialState extends UserState{}

 class UserLoadingState extends UserState{}

 class UserSuccessSate extends UserState{}

 class UserFailureState extends UserState{
  String errorMsg;
  UserFailureState({required this.errorMsg});
 }