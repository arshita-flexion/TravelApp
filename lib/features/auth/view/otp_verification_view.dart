import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:codefest_travel_app/features/auth/bloc/auth_bloc.dart';
import 'package:codefest_travel_app/core/routes/app_routes.dart';
import 'package:codefest_travel_app/core/utils/navigator_service.dart';

class OtpVerificationView extends StatefulWidget {
  final String email;
  const OtpVerificationView({super.key, required this.email});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.bottomNavigationView);
        } else if (state.status == AuthStatus.profileIncomplete) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.setProfileRoute);
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Invalid OTP')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'VERIFICATION',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 2),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the 6-digit code sent to ${widget.email}',
                  style: const TextStyle(color: Color(0xFF999999), fontSize: 16, fontFamily: 'Satoshi'),
                ),
                const SizedBox(height: 48),
                Center(
                  child: Pinput(
                    length: 6,
                    controller: _otpController,
                    autofocus: true,
                    defaultPinTheme: PinTheme(
                      width: 50,
                      height: 56,
                      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFF5F5F5),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 50,
                      height: 56,
                      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                    ),
                    onCompleted: (pin) {
                      context.read<AuthBloc>().add(VerifyOtpRequested(widget.email, pin));
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: state.status == AuthStatus.loading
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                        )
                      : TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(ResendOtpRequested(widget.email));
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP Resent')));
                          },
                          child: const Text(
                            'RESEND CODE',
                            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black, letterSpacing: 1),
                          ),
                        ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: state.status == AuthStatus.loading
                      ? null
                      : () {
                          if (_otpController.text.length == 6) {
                            context.read<AuthBloc>().add(VerifyOtpRequested(widget.email, _otpController.text));
                          }
                        },
                  child: const Text(
                    'VERIFY & PROCEED',
                    style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
