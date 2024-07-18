import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadbiro/data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(InitialUserState()) {
    on<GetUserEvent>(_getUser);
  }

  void _getUser(GetUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingUserState());
    try {
      final user = await _userRepository.getUserByEmail(event.email);
      emit(LoadedUsersState(user));
    } catch (e) {
      emit(ErrorUserState(e.toString()));
    }
  }
}
