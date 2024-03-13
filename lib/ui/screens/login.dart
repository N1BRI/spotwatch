import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:spotwatch/data/login_form/bloc/login_form_bloc.dart';
import 'package:spotwatch/data/reverse_beacon/bloc/reverse_beacon_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _callsignFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _callsignFocusNode.addListener(() {
      if (!_callsignFocusNode.hasFocus) {
        context.read<LoginFormBloc>().add(CallsignUnfocused());
        FocusScope.of(context).requestFocus(_callsignFocusNode);
      }
    });
  }

  @override
  void dispose() {
    _callsignFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFormBloc, LoginFormState>(
      listener: (BuildContext context, LoginFormState state) {
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pushNamed(context, '/app');
          context.read<ReverseBeaconBloc>().add(ReverseBeaconConnected(state.callsign.value));
        }
        if (state.status.isInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Submitting...')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'SPOTWATCH',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 64, 62, 167)),
                ),
                const Icon(
                  Icons.radar_sharp,
                  size: 200,
                  color: Color.fromARGB(255, 64, 62, 167),
                ),
                const SizedBox(
                  height: 10,
                ),
                CallsignInput(focusNode: _callsignFocusNode),
                const SizedBox(
                  height: 15,
                ),
                const SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CallsignInput extends StatelessWidget {
  const CallsignInput({required this.focusNode, super.key});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.callsign.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.badge_outlined),
            labelText: 'Callsign',
            helperText: 'Please Enter a valid amateur radio callsign',
            errorText: state.callsign.displayError != null
                ? 'Please ensure the callsign entered is valid'
                : null,
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            context.read<LoginFormBloc>().add(CallsignChanged(callsign: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isValid = context.select((LoginFormBloc bloc) => bloc.state.isValid);
    return ElevatedButton(
      onPressed: isValid
          ? () => context.read<LoginFormBloc>().add(FormSubmitted())
          : null,
      child: const Text('Start Listening'),
    );
  }
}
