
import 'package:agros_app/model/shipment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../model/shipment_detail.dart';
import '../repositories/repository.dart';

class GetShipmentDetailBloc extends Bloc<GetShipmentDetailBlocEvent, GetShipmentDetailBlocState> {
  GetShipmentDetailBloc(GetShipmentDetailBlocState initialState) : super(GetShipmentDetailBlocStateLoading());

  @override
  Stream<GetShipmentDetailBlocState> mapEventToState(GetShipmentDetailBlocEvent event) async* {
    if (event is GetShipmentDetailBlocGetEvent) {
      List<ShipmentDetail> shipping_details = await getIt.get<Repository>().shipmentRepository!.getDetail(shipment_id: event.shipment_id);

      yield GetShipmentDetailBlocStateLoaded(shipping_details);
    } else {
      yield GetShipmentDetailBlocStateLoading();
    }
  }
}

abstract class GetShipmentDetailBlocEvent {}

class GetShipmentDetailBlocGetEvent extends GetShipmentDetailBlocEvent {
  GetShipmentDetailBlocGetEvent({required this.shipment_id});
final String shipment_id;
}

class GetShipmentDetailBlocRefreshEvent extends GetShipmentDetailBlocEvent {}

abstract class GetShipmentDetailBlocState {}

class GetShipmentDetailBlocStateLoading extends GetShipmentDetailBlocState {}

class GetShipmentDetailBlocStateLoaded extends GetShipmentDetailBlocState {
  GetShipmentDetailBlocStateLoaded(this.shipping_details);
  final List<ShipmentDetail> shipping_details;
}
