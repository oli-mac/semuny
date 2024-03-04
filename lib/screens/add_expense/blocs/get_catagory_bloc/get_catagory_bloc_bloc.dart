import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_catagory_bloc_event.dart';
part 'get_catagory_bloc_state.dart';

class GetCatagoryBlocBloc extends Bloc<GetCatagoryBlocEvent, GetCatagoryBlocState> {
  GetCatagoryBlocBloc() : super(GetCatagoryBlocInitial()) {
    on<GetCatagoryBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
