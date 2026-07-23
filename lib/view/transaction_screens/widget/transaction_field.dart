import 'package:flutter/material.dart';

class TransactionTextField extends StatelessWidget {
  final String hint;
  final IconData? prefix;
  final IconData? suffix;

  const TransactionTextField({
    super.key,
    required this.hint,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (prefix != null)
            Icon(
              prefix,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant,
            ),

          if (prefix != null)
            const SizedBox(width: 8),

          Expanded(
            child: Text(
              hint,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 13,
              ),
            ),
          ),

          if (suffix != null)
            Icon(
              suffix,
              size: 16,
              color: theme.colorScheme.onSurfaceVariant,
            ),
        ],
      ),
    );
  }
}