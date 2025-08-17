import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyTap;
  const CustomKeyboard({super.key, required this.onKeyTap});

  @override
  Widget build(BuildContext context) {
    final keys = [
      ["Draw", "«", "»", "DEL"],
      ["7", "8", "9", "C"],
      ["4", "5", "6", "+"],
      ["1", "2", "3", "-"],
      ["0", ".", "x", "*"],
      ["sin(", "cos(", "tan(", "/"],
      ["e", "(", ")", "^"],
    ];

    final theme = Theme.of(context);

    return SizedBox(
      height: 400,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant.withOpacity(0.95),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: keys.map((row) {
            return Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: row.map((key) {
                  final isGraph = key == "Draw";
                  final isAction = ["DEL", "C", "«", "»"].contains(key);

                  if (isGraph) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          onPressed: () => onKeyTap(key),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                            foregroundColor: theme.colorScheme.onSecondary,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            "Draw",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        onPressed: () => onKeyTap(key),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAction
                              ? theme.colorScheme.primary
                              : theme.colorScheme.surface,
                          foregroundColor: isAction
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurface,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: isAction ? 4 : 1,
                        ),
                        child: Text(
                          key,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
