
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'navbar_state.dart';

/* ::::::::::::::::::::::::: StateNotifierProvider ::::::::::::::::::::::::: */

// class NavbarNotifier extends StateNotifier<NavbarState> {
//   NavbarNotifier() : super(NavbarState(index: 0));

//   void onItemTapped(int index) {
//     state = NavbarState(index: index);
//   }
// }

// final navbarProvider = StateNotifierProvider<NavbarNotifier, NavbarState>((ref) {
//   return NavbarNotifier();
// });

/* ::::::::::::::::::::::::: with NavbarState ::::::::::::::::::::::::: */

// final stateProvider = Provider<NavbarState>((ref) {
//   return NavbarState(index: 0);
// });

// final navProvider = StateProvider<int>((ref) {
//   var state = ref.read(stateProvider);
//   return state.index;
// });

/* ::::::::::::::::::::::::: without NavbarState [SIMPLE]::::::::::::::::::::::::: */
final navProvider = StateProvider<int>((ref) {
  return 0;
});
