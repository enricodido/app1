
import 'package:agros_app/model/pallet_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../repositories/repository.dart';

class GetPalletBloc extends Bloc<GetPalletBlocEvent, GetPalletBlocState> {
  GetPalletBloc(GetPalletBlocState initialState) : super(GetPalletBlocStateLoading());

  @override
  Stream<GetPalletBlocState> mapEventToState(GetPalletBlocEvent event) async* {
    if (event is GetPalletBlocGetEvent) {
      List<PalletModel> pallets = await getIt.get<Repository>().palletRepository!.get();

      yield GetPalletBlocStateLoaded(pallets);
    } else {
      yield GetPalletBlocStateLoading();
    }
  }
}

abstract class GetPalletBlocEvent {}

class GetPalletBlocGetEvent extends GetPalletBlocEvent {
  GetPalletBlocGetEvent();

}

class GetPalletBlocRefreshEvent extends GetPalletBlocEvent {}

abstract class GetPalletBlocState {}

class GetPalletBlocStateLoading extends GetPalletBlocState {}

class GetPalletBlocStateLoaded extends GetPalletBlocState {
  GetPalletBlocStateLoaded(this.pallets);
  final List<PalletModel> pallets;
}
