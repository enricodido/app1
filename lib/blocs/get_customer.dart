
import 'package:agros_app/model/customers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../repositories/repository.dart';

class GetCustomerBloc extends Bloc<GetCustomerBlocEvent, GetCustomerBlocState> {
  GetCustomerBloc(GetCustomerBlocState initialState) : super(GetCustomerBlocStateLoading());

  @override
  Stream<GetCustomerBlocState> mapEventToState(GetCustomerBlocEvent event) async* {
    if (event is GetCustomerBlocGetEvent) {
      List<CustomerModel> customers = await getIt.get<Repository>().customerRepository!.get();

      yield GetCustomerBlocStateLoaded(customers);
    } else {
      yield GetCustomerBlocStateLoading();
    }
  }
}

abstract class GetCustomerBlocEvent {}

class GetCustomerBlocGetEvent extends GetCustomerBlocEvent {
  GetCustomerBlocGetEvent();

}

class GetCustomerBlocRefreshEvent extends GetCustomerBlocEvent {}

abstract class GetCustomerBlocState {}

class GetCustomerBlocStateLoading extends GetCustomerBlocState {}

class GetCustomerBlocStateLoaded extends GetCustomerBlocState {
  GetCustomerBlocStateLoaded(this.customers);
  final List<CustomerModel> customers;
}
