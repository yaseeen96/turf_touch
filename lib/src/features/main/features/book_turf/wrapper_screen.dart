import 'package:flutter/material.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/main/features/book_turf/steppers/choose_date.dart';
import 'package:turf_touch/src/features/main/features/book_turf/steppers/payment_stepper.dart';
import 'package:turf_touch/src/features/main/features/book_turf/steppers/select_time.dart';
import 'package:turf_touch/src/shared/widgets/app_bar.dart';

class WrapperScreen extends StatefulWidget {
  @override
  _WrapperScreenState createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TurfTouchAppBar(),
      backgroundColor: CTheme.of(context).theme.backgroundColor,
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepTapped: (int step) => setState(() => _currentStep = step),
        onStepContinue:
            _currentStep < 2 ? () => setState(() => _currentStep += 1) : null,
        onStepCancel:
            _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
        steps: <Step>[
          Step(
            title: const Text('Select Date'),
            content: const ChooseDateStepper(),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: Text('Select Time'),
            content: SelectTimeStepper(),
            isActive: _currentStep >= 0,
            state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
          ),
          Step(
            title: Text('Pay'),
            content: const PaymentStepper(),
            isActive: _currentStep >= 0,
            state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
          ),
        ],
      ),
    );
  }
}
