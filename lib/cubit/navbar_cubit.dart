import 'package:bloc/bloc.dart';
part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(NavbarState(index: 0));

  void onItemTapped(int index) {
    emit(NavbarState(index: index));
  }
}
