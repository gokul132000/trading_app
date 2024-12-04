import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_app/utiles/globals.dart' as globals;
import '../repositories/app_repository.dart';


part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppStateStarted()) {
    on<AppEventInit>((event, emit) {
      emit(const AppStateStarted());
    });

    on<AppEventFetchUserData>((event, emit) async {
      fetchUserData(emit);
    });
  }

  Future<void> fetchUserData(Emitter<AppState> emit) async {
    globals.socketService.connectSocket();
    final isUserLogin = await AppRepository().checkUserStatus();
      emit(isUserLogin ? const AppStateAuthenticated() : const AppStateUnAuthenticated());
  }
}