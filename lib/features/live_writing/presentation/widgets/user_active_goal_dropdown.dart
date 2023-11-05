import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActiveGoalDropdown extends HookConsumerWidget {
  const ActiveGoalDropdown({
    required this.selectedResolutionGoal,
    required this.activeResolutionList,
    required this.isSubmitted,
    super.key,
  });

  final ValueNotifier<String> selectedResolutionGoal;
  final ValueNotifier<bool> isSubmitted;
  final List<String> activeResolutionList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownMenu<String>(
        width: 200,
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        trailingIcon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
          size: 15,
        ),
        enabled: !isSubmitted.value,
        initialSelection: selectedResolutionGoal.value,
        onSelected: (newValue) {
          if (!isSubmitted.value) {
            selectedResolutionGoal.value = newValue!;
          }
        },
        dropdownMenuEntries:
            activeResolutionList.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(
            value: value,
            label: value,
          );
        }).toList(),
      ),
    );
  }
}
