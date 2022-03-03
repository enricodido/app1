
import 'package:agros_app/model/team.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../model/label.dart';
import '../repositories/repository.dart';

class GetTeamBloc extends Bloc<GetTeamBlocEvent, GetTeamBlocState> {
  GetTeamBloc(GetTeamBlocState initialState) : super(GetTeamBlocStateLoading());

  @override
  Stream<GetTeamBlocState> mapEventToState(GetTeamBlocEvent event) async* {
    if (event is GetTeamBlocGetEvent) {
      List<TeamModel> teams = await getIt.get<Repository>().teamRepository!.get();

      yield GetTeamBlocStateLoaded(teams);
    } else {
      yield GetTeamBlocStateLoading();
    }
  }
}

abstract class GetTeamBlocEvent {}

class GetTeamBlocGetEvent extends GetTeamBlocEvent {
  GetTeamBlocGetEvent();

}

class GetTeamBlocRefreshEvent extends GetTeamBlocEvent {}

abstract class GetTeamBlocState {}

class GetTeamBlocStateLoading extends GetTeamBlocState {}

class GetTeamBlocStateLoaded extends GetTeamBlocState {
  GetTeamBlocStateLoaded(this.teams);
  final List<TeamModel> teams;
}
