
import 'package:agros_app/model/customers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../model/carrier.dart';
import '../repositories/repository.dart';

class GetCarrierBloc extends Bloc<GetCarrierBlocEvent, GetCarrierBlocState> {
  GetCarrierBloc(GetCarrierBlocState initialState) : super(GetCarrierBlocStateLoading());

  @override
  Stream<GetCarrierBlocState> mapEventToState(GetCarrierBlocEvent event) async* {
    if (event is GetCarrierBlocGetEvent) {
      List<CarrierModel> carriers = await getIt.get<Repository>().carrierRepository!.get();

      yield GetCarrierBlocStateLoaded(carriers);
    } else {
      yield GetCarrierBlocStateLoading();
    }
  }
}

abstract class GetCarrierBlocEvent {}

class GetCarrierBlocGetEvent extends GetCarrierBlocEvent {
  GetCarrierBlocGetEvent();

}

class GetCarrierBlocRefreshEvent extends GetCarrierBlocEvent {}

abstract class GetCarrierBlocState {}

class GetCarrierBlocStateLoading extends GetCarrierBlocState {}

class GetCarrierBlocStateLoaded extends GetCarrierBlocState {
  GetCarrierBlocStateLoaded(this.carriers);
  final List<CarrierModel> carriers;
}
