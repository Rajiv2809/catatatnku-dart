import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../models/note_model.dart';

class PrioritySelector extends StatelessWidget {
  final NotePriority selectedPriority;
  final Function(NotePriority) onPrioritySelected;

  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onPrioritySelected,
  });

  @override
  Widget build(BuildContext context) {
    final priorities = [
      NotePriority.rendah,
      NotePriority.sedang,
      NotePriority.tinggi,
    ];

    return Row(
      children: priorities.map((priority) {
        final isSelected = selectedPriority == priority;
        final isLast = priority == NotePriority.tinggi;

        return Expanded(
          child: GestureDetector(
            onTap: () => onPrioritySelected(priority),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: isLast ? 0 : 8),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? priority.color : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? priority.color : AppColors.border,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: priority.color.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  priority.label,
                  style: TextStyle(
                    fontFamily: AppStyles.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color:
                        isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
