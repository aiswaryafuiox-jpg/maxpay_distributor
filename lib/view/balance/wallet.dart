import 'package:flutter/material.dart';

import 'package:maxpay/core/constants/colors.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class WalletBalanceScreen extends StatefulWidget {
  const WalletBalanceScreen({super.key});

  @override
  State<WalletBalanceScreen> createState() => _WalletBalanceScreenState();
}

class _WalletBalanceScreenState extends State<WalletBalanceScreen> {
  bool _showBalance = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Wallet Balance"),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 22, 26, 0),
          child: _BalanceCard(
            showBalance: _showBalance,
            onToggleVisibility: () {
              setState(() {
                _showBalance = !_showBalance;
              });
            },
          ),
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final bool showBalance;
  final VoidCallback onToggleVisibility;

  const _BalanceCard({
    required this.showBalance,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.clrPrimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onToggleVisibility,
                child: Icon(
                  showBalance ? Symbols.visibility_off : Symbols.visibility,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Symbols.currency_rupee,
                color: Colors.white,
                weight: 800,
                size: 20,
              ),
              Text(
                showBalance ? "1,245,780" : '*******',
                style:
                    theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,
                    ) ??
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
