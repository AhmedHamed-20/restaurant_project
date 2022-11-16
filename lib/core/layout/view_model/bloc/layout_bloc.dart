import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'layout_event.dart';
part 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  LayoutBloc() : super(LayoutInitial()) {
    on<LayoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
