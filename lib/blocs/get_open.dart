
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../model/label.dart';
import '../repositories/repository.dart';

class GetOpenBloc extends Bloc<GetOpenBlocEvent, GetOpenBlocState> {
  GetOpenBloc(GetOpenBlocState initialState) : super(GetOpenBlocStateLoading());

  @override
  Stream<GetOpenBlocState> mapEventToState(GetOpenBlocEvent event) async* {
    if (event is GetOpenBlocGetEvent) {
      List<Label> labels = await getIt.get<Repository>().labelRepository!.getNoClose();

      yield GetOpenBlocStateLoaded(labels);
    } else {
      yield GetOpenBlocStateLoading();
    }
  }
}

abstract class GetOpenBlocEvent {}

class GetOpenBlocGetEvent extends GetOpenBlocEvent {
  GetOpenBlocGetEvent();

}

class GetOpenBlocRefreshEvent extends GetOpenBlocEvent {}

abstract class GetOpenBlocState {}

class GetOpenBlocStateLoading extends GetOpenBlocState {}

class GetOpenBlocStateLoaded extends GetOpenBlocState {
  GetOpenBlocStateLoaded(this.labels);
  final List<Label> labels;
}
