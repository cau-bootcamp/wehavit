import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActiveGoalDropdown extends HookConsumerWidget {
  const ActiveGoalDropdown({
    required this.isSubmitted,
    required this.onResolutionGoalSelected,
    super.key,
  });

  final ValueNotifier<bool> isSubmitted;
  final void Function(String) onResolutionGoalSelected;
  final activeResolutionGoals = const [
    '1',
    '2',
    '3',
    '4',
    '5',
  ]; // TODO: fetch from server

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGoal = useState('1');

    if (!isSubmitted.value) {
      return Container(
        width: double.infinity,
        height: 50,
        color: Colors.amber,
        child: DropdownButton<String>(
          value: selectedGoal.value,
          onChanged: (String? newValue) {
            onResolutionGoalSelected(newValue ?? '');
          },
          items: activeResolutionGoals
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text('목표 $value'),
            );
          }).toList(),
        ),
      );
    }
    return const Placeholder();
  }
}
