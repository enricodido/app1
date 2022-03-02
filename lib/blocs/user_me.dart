
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';
import '../model/user.dart';
import '../repositories/repository.dart';

class UserMeBloc extends Bloc<UserMeBlocEvent, UserMeBlocState> {
  UserMeBloc(UserMeBlocState initialState) : super(UserMeBlocStateLoading());

  Stream<UserMeBlocState> mapEventToState(UserMeBlocEvent event) async* {
    if (event is UserMeBlocGetEvent) {
      UserModel user = await getIt.get<Repository>().userRepository!.me();
      yield UserMeBlocStateLoaded(user);
    } else {
      yield UserMeBlocStateLoading();
    }
  }
}

abstract class UserMeBlocEvent {}

class UserMeBlocGetEvent extends UserMeBlocEvent {}

class UserMeBlocRefreshEvent extends UserMeBlocEvent {}

abstract class UserMeBlocState {}

class UserMeBlocStateLoading extends UserMeBlocState {}

class UserMeBlocStateLoaded extends UserMeBlocState {
  UserMeBlocStateLoaded(this.user);
  final UserModel user;
}
