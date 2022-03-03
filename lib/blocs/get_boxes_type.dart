
import 'package:agros_app/model/boxes_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../repositories/repository.dart';

class GetBoxesBloc extends Bloc<GetBoxesBlocEvent, GetBoxesBlocState> {
  GetBoxesBloc(GetBoxesBlocState initialState) : super(GetBoxesBlocStateLoading());

  @override
  Stream<GetBoxesBlocState> mapEventToState(GetBoxesBlocEvent event) async* {
    if (event is GetBoxesBlocGetEvent) {
      List<BoxModel> boxes = await getIt.get<Repository>().boxesRepository!.get();

      yield GetBoxesBlocStateLoaded(boxes);
    } else {
      yield GetBoxesBlocStateLoading();
    }
  }
}

abstract class GetBoxesBlocEvent {}

class GetBoxesBlocGetEvent extends GetBoxesBlocEvent {
  GetBoxesBlocGetEvent();

}

class GetBoxesBlocRefreshEvent extends GetBoxesBlocEvent {}

abstract class GetBoxesBlocState {}

class GetBoxesBlocStateLoading extends GetBoxesBlocState {}

class GetBoxesBlocStateLoaded extends GetBoxesBlocState {
  GetBoxesBlocStateLoaded(this.boxes);
  final List<BoxModel> boxes;
}
