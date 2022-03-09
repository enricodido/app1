
import 'package:agros_app/model/shipment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../repositories/repository.dart';

class GetShipmentBloc extends Bloc<GetShipmentBlocEvent, GetShipmentBlocState> {
  GetShipmentBloc(GetShipmentBlocState initialState) : super(GetShipmentBlocStateLoading());

  @override
  Stream<GetShipmentBlocState> mapEventToState(GetShipmentBlocEvent event) async* {
    if (event is GetShipmentBlocGetEvent) {
      List<Shipment> shipments = await getIt.get<Repository>().shipmentRepository!.get();

      yield GetShipmentBlocStateLoaded(shipments);
    } else {
      yield GetShipmentBlocStateLoading();
    }
  }
}

abstract class GetShipmentBlocEvent {}

class GetShipmentBlocGetEvent extends GetShipmentBlocEvent {
  GetShipmentBlocGetEvent();

}

class GetShipmentBlocRefreshEvent extends GetShipmentBlocEvent {}

abstract class GetShipmentBlocState {}

class GetShipmentBlocStateLoading extends GetShipmentBlocState {}

class GetShipmentBlocStateLoaded extends GetShipmentBlocState {
  GetShipmentBlocStateLoaded(this.shipments);
  final List<Shipment> shipments;
}
