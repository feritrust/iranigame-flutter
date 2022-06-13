import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iranigame/common/utils.dart';
import 'package:iranigame/data/repo/auth_repository.dart';
import 'package:iranigame/ui/auth/otp/bloc/otp_bloc.dart';
import 'package:iranigame/ui/auth/username/username.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen(
      {Key? key, required this.username, required this.password})
      : super(key: key);
  final String username;
  final String password;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final TextEditingController textEditingController;


  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          body: BlocProvider<OtpBloc>(
              create: (context) {
                final bloc =  OtpBloc(authRepository, widget.username, widget.password);
                bloc.stream.listen((state) {
                  if (state is OtpSuccess) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UsernameScreen(phone: widget.username,password: widget.password,),));
                  }else if (state is OtpError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.exception.message),
                    ));
                  }
                });
                return bloc;
              },
          child: BlocBuilder<OtpBloc, OtpState>(
              builder: (context, state) {
                return Center(
                  child: SingleChildScrollView(
                    physics: defaultScrollPhysics,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: themeData.colorScheme.onSecondary,
                                width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Directionality(textDirection: TextDirection.ltr,child: OtpWidget(controller: textEditingController,)),
                              const OtpTimer(),
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if(textEditingController.text.length > 6){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('کد راه کامل وارد کنید'),
                                        ),
                                      );
                                    }else{
                                      BlocProvider.of<OtpBloc>(context)
                                          .add(OtpButtonClicked(textEditingController.value.text));
                                    }
                                  },
                                  child: const Text('تایید'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
      ),
    );
  }
}

class OtpTimer extends StatefulWidget {
  const OtpTimer({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: durationRetryResendCode);

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds =
    strDigits(myDuration.inSeconds.remainder(durationRetryResendCode));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                } else {
                  return Colors.transparent;
                }
              },
            ),
          ),
          onPressed: myDuration.inSeconds > 0
              ? null
              : () {
            myDuration = const Duration(seconds: durationRetryResendCode);
            startTimer();
            BlocProvider.of<OtpBloc>(context).add(OtpRetrySendCode());
          },
          child: const Text("ارسال مجدد کد تایید"),
        ),
        Text("$seconds ثانیه"),
      ],
    );
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }
}

class OtpWidget extends StatefulWidget {
  const OtpWidget({
    Key? key, required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: TextStyle(
        color: Colors.green.shade600,
        fontWeight: FontWeight.bold,
      ),
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 60,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        selectedColor: Colors.white,
        inactiveColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
      ),
      cursorColor: Colors.grey,
      animationDuration: const Duration(milliseconds: 300),
      textStyle: const TextStyle(fontSize: 20, color: Colors.black),
      enableActiveFill: true,
      controller: widget.controller,
      keyboardType: TextInputType.number,
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: (value) {
        print(value);
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
