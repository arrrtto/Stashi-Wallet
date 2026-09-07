import 'package:flutter/material.dart';

import '../../design/tokens/colors.dart';
import '../../design/tokens/spacing.dart';
import '../../design/tokens/typography.dart';
import '../atoms/p_icon_button.dart';
import '../../core/i18n/arb_text_localizer.dart';

class BalanceHero extends StatelessWidget {
  static const String _maskedBalanceText = '*******';

  const BalanceHero({
    required this.balanceText,
    this.label = 'Balance',
    this.secondaryText,
    this.helperText,
    this.compact = false,
    this.isHidden = false,
    this.onToggleVisibility,
    this.onSwapDisplay,
    super.key,
  });

  final String balanceText;
  final String label;
  final String? secondaryText;
  final String? helperText;
  final bool compact;
  final bool isHidden;
  final VoidCallback? onToggleVisibility;
  final VoidCallback? onSwapDisplay;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final displayText = isHidden ? _maskedBalanceText : balanceText;
    final displaySecondaryText = secondaryText == null
        ? null
        : (isHidden ? _maskedBalanceText : secondaryText!);
    final cardPadding = compact ? PSpacing.sm : PSpacing.lg;
    final titleStyle = compact
        ? PTypography.heading4(color: AppColors.textPrimary)
        : PTypography.displaySmall(color: AppColors.textPrimary);

    return Container(
      decoration: BoxDecoration(
        color: isLight ? const Color(0xC8FFF8EA) : const Color(0xA8110D09),
        borderRadius: BorderRadius.circular(PSpacing.radiusCard),
        border: Border.all(
          color: AppColors.highlight.withValues(alpha: 0.72),
          width: 1.35,
        ),
        gradient: LinearGradient(
          colors: [
            AppColors.gradientAStart.withValues(alpha: isLight ? 0.12 : 0.10),
            (isLight ? const Color(0xA8FFF8EA) : const Color(0x78120E09)),
            AppColors.gradientBEnd.withValues(alpha: isLight ? 0.08 : 0.14),
          ],
          stops: const [0.0, 0.52, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gradientAStart.withValues(alpha: 0.10),
            blurRadius: compact ? 14 : 24,
            spreadRadius: compact ? 0 : 1,
            offset: Offset(0, compact ? 4 : 8),
          ),
          BoxShadow(
            color: AppColors.shadowStrong,
            blurRadius: compact ? 8 : 16,
            offset: Offset(0, compact ? 4 : 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                label,
                style: PTypography.labelLarge(color: AppColors.textSecondary),
              ),
              const Spacer(),
              if (onToggleVisibility != null)
                PIconButton(
                  icon: Icon(
                    isHidden ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: onToggleVisibility,
                  tooltip: isHidden ? 'Show balance'.tr : 'Hide balance'.tr,
                  size: compact
                      ? PIconButtonSize.medium
                      : PIconButtonSize.large,
                ),
            ],
          ),
          SizedBox(height: compact ? PSpacing.xxs : PSpacing.sm),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 120),
            child: FittedBox(
              key: ValueKey(displayText),
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                displayText,
                style: titleStyle.copyWith(
                  color: AppColors.highlight,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: AppColors.gradientAStart.withValues(alpha: 0.18),
                      blurRadius: 12,
                    ),
                  ],
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
          if (displaySecondaryText != null) ...[
            SizedBox(height: compact ? PSpacing.xxs : PSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: Text(
                    displaySecondaryText,
                    style: PTypography.labelSmall(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onSwapDisplay != null)
                  PIconButton(
                    icon: Icon(Icons.swap_vert, color: AppColors.textSecondary),
                    onPressed: onSwapDisplay,
                    tooltip: 'Swap balance display'.tr,
                    size: compact
                        ? PIconButtonSize.medium
                        : PIconButtonSize.large,
                  ),
              ],
            ),
          ],
          if (helperText != null) ...[
            SizedBox(height: compact ? PSpacing.xxs : PSpacing.sm),
            Text(
              helperText!,
              style: PTypography.bodySmall(color: AppColors.textSecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
