part of 'login_form_bloc.dart';

final class LoginFormState extends Equatable {
  const LoginFormState({this.callsign = const Callsign.pure(), this.isValid = false, this.status = FormzSubmissionStatus.initial});
  
  final Callsign callsign;
  final FormzSubmissionStatus status;
  final bool isValid;

  LoginFormState copyWith({
    Callsign? callsign,
    bool? isValid,
    FormzSubmissionStatus? status}){
    return LoginFormState(callsign: callsign ?? this.callsign, isValid: isValid ?? this.isValid, status: status ?? this.status);
  }

  @override
  List<Object> get props => [callsign, status];
}

final class LoginFormInitial extends LoginFormState {}
