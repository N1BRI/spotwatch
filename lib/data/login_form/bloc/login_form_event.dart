part of 'login_form_bloc.dart';

sealed class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

final class CallsignChanged extends LoginFormEvent {
  final String callsign;

  const CallsignChanged({required this.callsign});

  @override
  List<Object> get props => [callsign];
}

final class CallsignUnfocused extends LoginFormEvent {}

final class FormSubmitted extends LoginFormEvent {}
