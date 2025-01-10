import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeState {
  final bool isDark;
  ThemeState(this.isDark);
}

class ThemeBloc extends Cubit<ThemeState> {
  ThemeBloc() : super(ThemeState(false));

  void toggleTheme() {
    final isDark = !state.isDark;
    emit(ThemeState(isDark));
  }
}
