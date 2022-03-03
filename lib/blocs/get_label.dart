
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../model/label.dart';
import '../repositories/repository.dart';

class GetLabelBloc extends Bloc<GetLabelBlocEvent, GetLabelBlocState> {
  GetLabelBloc(GetLabelBlocState initialState) : super(GetLabelBlocStateLoading());

  @override
  Stream<GetLabelBlocState> mapEventToState(GetLabelBlocEvent event) async* {
    if (event is GetLabelBlocGetEvent) {
      List<Label> labels = await getIt.get<Repository>().labelRepository!.get();

      yield GetLabelBlocStateLoaded(labels);
    } else {
      yield GetLabelBlocStateLoading();
    }
  }
}

abstract class GetLabelBlocEvent {}

class GetLabelBlocGetEvent extends GetLabelBlocEvent {
  GetLabelBlocGetEvent();

}

class GetLabelBlocRefreshEvent extends GetLabelBlocEvent {}

abstract class GetLabelBlocState {}

class GetLabelBlocStateLoading extends GetLabelBlocState {}

class GetLabelBlocStateLoaded extends GetLabelBlocState {
  GetLabelBlocStateLoaded(this.labels);
  final List<Label> labels;
}
