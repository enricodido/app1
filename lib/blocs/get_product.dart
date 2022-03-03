
import 'package:agros_app/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';
import '../model/label.dart';
import '../repositories/repository.dart';

class GetProductBloc extends Bloc<GetProductBlocEvent, GetProductBlocState> {
  GetProductBloc(GetProductBlocState initialState) : super(GetProductBlocStateLoading());

  @override
  Stream<GetProductBlocState> mapEventToState(GetProductBlocEvent event) async* {
    if (event is GetProductBlocGetEvent) {
      List<ProductModel> products = await getIt.get<Repository>().productRepository!.get();

      yield GetProductBlocStateLoaded(products);
    } else {
      yield GetProductBlocStateLoading();
    }
  }
}

abstract class GetProductBlocEvent {}

class GetProductBlocGetEvent extends GetProductBlocEvent {
  GetProductBlocGetEvent();

}

class GetProductBlocRefreshEvent extends GetProductBlocEvent {}

abstract class GetProductBlocState {}

class GetProductBlocStateLoading extends GetProductBlocState {}

class GetProductBlocStateLoaded extends GetProductBlocState {
  GetProductBlocStateLoaded(this.products);
  final List<ProductModel> products;
}
