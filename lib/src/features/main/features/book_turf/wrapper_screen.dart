import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turf_touch/src/config/theme/app_theme.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/main/features/book_turf/providers/book_turf_providers.dart';
import 'package:turf_touch/src/features/main/features/book_turf/steppers/choose_date.dart';
import 'package:turf_touch/src/features/main/features/book_turf/steppers/payment_stepper.dart';
import 'package:turf_touch/src/features/main/features/book_turf/steppers/select_time.dart';
import 'package:turf_touch/src/shared/widgets/app_bar.dart';

class WrapperScreen extends ConsumerStatefulWidget {
  const WrapperScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends ConsumerState<WrapperScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TurfTouchAppBar(),
      backgroundColor: CTheme.of(context).theme.backgroundColor,
      body: Theme(
        data: ThemeData(
            colorScheme:
                (CTheme.of(context).theme.cthemeMode == CthemeMode.light)
                    ? const ColorScheme.light(
                        primary: Colors.red,
                      )
                    : const ColorScheme.dark(
                        background: Colors.black,
                        secondary: Colors.red,
                        shadow: Colors.white,
                      )),
        child: Stepper(
          controlsBuilder: (context, details) => Row(
            children: [
              if (_currentStep != 0)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              const Spacer(),
              if (_currentStep != 2)
                TextButton(
                  onPressed: details.onStepContinue,
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepTapped: (int step) => setState(() {
            _currentStep = step;
          }),
          onStepContinue: _currentStep < 2
              ? () {
                  if (_currentStep == 0) {
                    final selectedDate = ref.read(selectedDateProvider);
                    if (selectedDate == null) {
                      return;
                    }
                  } else if (_currentStep == 1) {
                    final selectedTimeSlots =
                        ref.read(selectedTimeSlotsProvider);
                    if (selectedTimeSlots.isEmpty) {
                      return;
                    }
                  }
                  setState(() {
                    _currentStep += 1;
                  });
                }
              : null,
          onStepCancel: _currentStep > 0
              ? () => setState(() {
                    _currentStep -= 1;
                  })
              : null,
          steps: [
            Step(
              title: const Text('Date'),
              content: const ChooseDateStepper(),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: const Text('Time'),
              content: (_currentStep == 1)
                  ? const SelectTimeStepper()
                  : const Placeholder(),
              isActive: _currentStep >= 1,
              state:
                  _currentStep >= 1 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: const Text('Pay'),
              content: (_currentStep == 2)
                  ? PaymentStepper(
                      currentStep: _currentStep,
                    )
                  : const Placeholder(),
              isActive: _currentStep == 2,
              state:
                  _currentStep >= 2 ? StepState.complete : StepState.disabled,
            ),
          ],
        ),
      ),
    );
  }
}
