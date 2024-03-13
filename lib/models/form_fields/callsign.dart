

import 'package:formz/formz.dart';

enum CallsignValidationError { invalid }

final class Callsign extends FormzInput<String, CallsignValidationError>{
  const Callsign.pure([super.value = '']) : super.pure();
  const Callsign.dirty([super.value = '']) : super.dirty();

  static final _callsignRegex = RegExp(r'[a-zA-Z0-9]{1,3}[0-9][a-zA-Z0-9]{0,3}[a-zA-Z]');

  @override
  CallsignValidationError? validator(String? value){
    return _callsignRegex.hasMatch(value ?? '') ? null : CallsignValidationError.invalid;
  }
}