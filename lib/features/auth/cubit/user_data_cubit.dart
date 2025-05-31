import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataState {
  final String name;
  final String email;

  UserDataState({required this.name, required this.email});
}

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataState(name: "", email: ""));

  void setUser(String name, String email) {
    emit(UserDataState(name: name, email: email));
  }

  void clearUser() {
    emit(UserDataState(name: "", email: ""));
  }
}