import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

enum AppCardElevation { none, low, medium, high }
enum AppCardVariant { filled, outlined, elevated }

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final AppCardElevation elevation;
  final AppCardVariant variant;
  final VoidCallback? onTap;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation = AppCardElevation.low,
    this.variant = AppCardVariant.filled,
    this.onTap,
    this.border,
    this.boxShadow,
  });

  const AppCard.filled({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation = AppCardElevation.low,
    this.onTap,
    this.border,
    this.boxShadow,
  }) : variant = AppCardVariant.filled;

  const AppCard.outlined({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.width,
    this.height,
    this.borderRadius,
    this.onTap,
    this.border,
    this.boxShadow,
  }) : elevation = AppCardElevation.none,
        variant = AppCardVariant.outlined;

  const AppCard.elevated({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation = AppCardElevation.medium,
    this.onTap,
    this.border,
    this.boxShadow,
  }) : variant = AppCardVariant.elevated;

  @override
  Widget build(BuildContext context) {
    final cardPadding = padding ?? const EdgeInsets.all(AppConstants.paddingM);
    final cardMargin = margin ?? const EdgeInsets.all(AppConstants.marginS);
    final cardBorderRadius = borderRadius ?? AppTheme.radiusMedium;
    final cardColor = color ?? _getCardColor();

    Widget card = Container(
      width: width,
      height: height,
      margin: cardMargin,
      padding: cardPadding,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: cardBorderRadius,
        border: _getBorder(),
        boxShadow: _getBoxShadow(),
      ),
      child: child,
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: cardBorderRadius,
          child: card,
        ),
      );
    }

    return card;
  }

  Color _getCardColor() {
    return switch (variant) {
      AppCardVariant.filled => AppColors.surface,
      AppCardVariant.outlined => AppColors.surface,
      AppCardVariant.elevated => AppColors.surface,
    };
  }

  Border? _getBorder() {
    if (border != null) return border;
    
    return switch (variant) {
      AppCardVariant.outlined => Border.all(
          color: AppColors.grey300,
          width: AppConstants.borderWidthThin,
        ),
      _ => null,
    };
  }

  List<BoxShadow>? _getBoxShadow() {
    if (boxShadow != null) return boxShadow;
    if (variant == AppCardVariant.outlined) return null;

    return switch (elevation) {
      AppCardElevation.none => null,
      AppCardElevation.low => AppTheme.shadowSmall,
      AppCardElevation.medium => AppTheme.shadowMedium,
      AppCardElevation.high => AppTheme.shadowLarge,
    };
  }
}

class AppFlightCard extends StatelessWidget {
  final Widget header;
  final Widget content;
  final Widget? footer;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool isSelected;

  const AppFlightCard({
    super.key,
    required this.header,
    required this.content,
    this.footer,
    this.onTap,
    this.padding,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: padding ?? const EdgeInsets.all(AppConstants.paddingM),
      elevation: isSelected ? AppCardElevation.medium : AppCardElevation.low,
      border: isSelected 
          ? Border.all(color: AppColors.primary, width: AppConstants.borderWidthThick)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          header,
          const SizedBox(height: AppConstants.spacingM),
          content,
          if (footer != null) ...[
            const SizedBox(height: AppConstants.spacingM),
            footer!,
          ],
        ],
      ),
    );
  }
}

class AppInfoCard extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const AppInfoCard({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: padding ?? const EdgeInsets.all(AppConstants.paddingM),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppConstants.spacingM),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppConstants.spacingXS),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppConstants.spacingM),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class AppStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget? icon;
  final Color? accentColor;
  final String? subtitle;
  final VoidCallback? onTap;

  const AppStatsCard({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.accentColor,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.primary;

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppConstants.paddingS),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  ),
                  child: IconTheme(
                    data: IconThemeData(color: color, size: AppConstants.iconM),
                    child: icon!,
                  ),
                ),
                const SizedBox(width: AppConstants.spacingM),
              ],
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingS),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppConstants.spacingXS),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}