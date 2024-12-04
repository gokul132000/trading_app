import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_app/features/home_main/prensentation/bloc/home_main_bloc/home_main_event.dart';
import 'package:trading_app/features/home_main/prensentation/bloc/home_main_bloc/home_main_state.dart';

class HomeMainBloc extends Bloc<HomeMainEvent, HomeMainState> {
  HomeMainBloc() : super(const HomeMainInitial()) {
    on<HomeMainNavTabChanged>((event, emit) {
      emit(HomeMainNavChanged(event.index));
    });
  }
}