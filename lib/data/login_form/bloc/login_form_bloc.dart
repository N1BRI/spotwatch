import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:spotwatch/models/form_fields/callsign.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(const LoginFormState()) {
    on<CallsignChanged>(_onCallsignChanged);
    on<CallsignUnfocused>(_onCallsignUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }
  void _onCallsignChanged(CallsignChanged event, Emitter<LoginFormState> emit) {
    final callsign = Callsign.dirty(event.callsign);
    emit(state.copyWith(
        callsign: callsign.isValid ? callsign : Callsign.pure(event.callsign),
        isValid: Formz.validate([callsign]),
        status: FormzSubmissionStatus.initial));
  }

    void _onCallsignUnfocused(CallsignUnfocused event, Emitter<LoginFormState> emit) {
    final callsign = Callsign.dirty(state.callsign.value);
    emit(
      state.copyWith(
        callsign: callsign,
        isValid: Formz.validate([callsign]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<LoginFormState> emit,
  ) async {
    final callsign = Callsign.dirty(state.callsign.value);
    emit(
      state.copyWith(
        callsign: callsign,
        isValid: Formz.validate([callsign]),
        status: FormzSubmissionStatus.initial,
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    }
  }
}
