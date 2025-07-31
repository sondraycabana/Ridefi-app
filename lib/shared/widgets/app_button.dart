import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../constants/app_constants.dart';

enum AppButtonSize { small, medium, large }
enum AppButtonVariant { primary, secondary, outline, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonSize size;
  final AppButtonVariant variant;
  final bool isLoading;
  final Widget? icon;
  final bool isExpanded;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.isExpanded = false,
    this.padding,
    this.borderRadius,
  });

  const AppButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.isExpanded = false,
    this.padding,
    this.borderRadius,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.isExpanded = false,
    this.padding,
    this.borderRadius,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.isExpanded = false,
    this.padding,
    this.borderRadius,
  }) : variant = AppButtonVariant.outline;

  const AppButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.isExpanded = false,
    this.padding,
    this.borderRadius,
  }) : variant = AppButtonVariant.text;

  @override
  Widget build(BuildContext context) {
    final buttonHeight = _getButtonHeight();
    final textStyle = _getTextStyle();
    final buttonPadding = padding ?? _getDefaultPadding();
    final radius = borderRadius ?? BorderRadius.circular(AppConstants.radiusRound);

    Widget child = isLoading
        ? SizedBox(
            width: _getLoadingSize(),
            height: _getLoadingSize(),
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.textOnPrimary),
            ),
          )
        : _buildButtonContent(textStyle);

    Widget button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            elevation: AppConstants.elevationCard,
            shadowColor: AppColors.shadow,
            shape: RoundedRectangleBorder(borderRadius: radius),
            padding: buttonPadding,
            minimumSize: Size(AppConstants.buttonMinWidth, buttonHeight),
            disabledBackgroundColor: AppColors.grey300,
            disabledForegroundColor: AppColors.grey500,
          ),
          child: child,
        ),
      AppButtonVariant.secondary => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.textOnPrimary,
            elevation: AppConstants.elevationCard,
            shadowColor: AppColors.shadow,
            shape: RoundedRectangleBorder(borderRadius: radius),
            padding: buttonPadding,
            minimumSize: Size(AppConstants.buttonMinWidth, buttonHeight),
            disabledBackgroundColor: AppColors.grey300,
            disabledForegroundColor: AppColors.grey500,
          ),
          child: child,
        ),
      AppButtonVariant.outline => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary, width: AppConstants.borderWidthThin),
            shape: RoundedRectangleBorder(borderRadius: radius),
            padding: buttonPadding,
            minimumSize: Size(AppConstants.buttonMinWidth, buttonHeight),
            disabledForegroundColor: AppColors.grey500,
          ),
          child: child,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: buttonPadding,
            minimumSize: Size(AppConstants.buttonMinWidth, buttonHeight),
            shape: RoundedRectangleBorder(borderRadius: radius),
            disabledForegroundColor: AppColors.grey500,
          ),
          child: child,
        ),
    };

    return isExpanded ? SizedBox(width: double.infinity, child: button) : button;
  }

  Widget _buildButtonContent(TextStyle textStyle) {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          SizedBox(width: AppConstants.spacingS),
          Text(text, style: textStyle),
        ],
      );
    }
    return Text(text, style: textStyle);
  }

  double _getButtonHeight() {
    return switch (size) {
      AppButtonSize.small => AppConstants.buttonHeightS,
      AppButtonSize.medium => AppConstants.buttonHeightM,
      AppButtonSize.large => AppConstants.buttonHeightL,
    };
  }

  TextStyle _getTextStyle() {
    final baseStyle = switch (size) {
      AppButtonSize.small => AppTextStyles.buttonSmall,
      AppButtonSize.medium => AppTextStyles.buttonMedium,
      AppButtonSize.large => AppTextStyles.buttonLarge,
    };

    return switch (variant) {
      AppButtonVariant.primary || AppButtonVariant.secondary => baseStyle,
      AppButtonVariant.outline || AppButtonVariant.text => baseStyle.copyWith(
          color: AppColors.primary,
        ),
    };
  }

  EdgeInsetsGeometry _getDefaultPadding() {
    return switch (size) {
      AppButtonSize.small => const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingS,
        ),
      AppButtonSize.medium => const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingL,
          vertical: AppConstants.paddingM,
        ),
      AppButtonSize.large => const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingXL,
          vertical: AppConstants.paddingL,
        ),
    };
  }

  double _getLoadingSize() {
    return switch (size) {
      AppButtonSize.small => AppConstants.iconS,
      AppButtonSize.medium => AppConstants.iconM,
      AppButtonSize.large => AppConstants.iconL,
    };
  }
}