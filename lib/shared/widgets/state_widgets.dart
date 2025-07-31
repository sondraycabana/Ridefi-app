import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../constants/app_constants.dart';
import 'app_button.dart';

class AppLoadingWidget extends StatelessWidget {
  final String? message;
  final double? size;
  final Color? color;

  const AppLoadingWidget({
    super.key,
    this.message,
    this.size,
    this.color,
  });

  const AppLoadingWidget.small({
    super.key,
    this.message,
    this.color,
  }) : size = 24.0;

  const AppLoadingWidget.large({
    super.key,
    this.message,
    this.color,
  }) : size = 48.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size ?? AppConstants.iconL,
            height: size ?? AppConstants.iconL,
            child: CircularProgressIndicator(
              color: color ?? AppColors.primary,
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppConstants.spacingM),
            Text(
              message!,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class AppErrorWidget extends StatelessWidget {
  final String message;
  final String? title;
  final IconData? icon;
  final VoidCallback? onRetry;
  final String? retryText;
  final bool showIcon;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.title,
    this.icon,
    this.onRetry,
    this.retryText,
    this.showIcon = true,
  });

  const AppErrorWidget.network({
    super.key,
    this.message = 'Check your internet connection and try again.',
    this.title = 'Connection Error',
    this.onRetry,
    this.retryText,
    this.showIcon = true,
  }) : icon = Icons.wifi_off;

  const AppErrorWidget.server({
    super.key,
    this.message = 'Something went wrong on our end. Please try again later.',
    this.title = 'Server Error',
    this.onRetry,
    this.retryText,
    this.showIcon = true,
  }) : icon = Icons.error_outline;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) ...[
              Icon(
                icon ?? Icons.error_outline,
                size: AppConstants.iconXXL,
                color: AppColors.error,
              ),
              const SizedBox(height: AppConstants.spacingL),
            ],
            if (title != null) ...[
              Text(
                title!,
                style: AppTextStyles.h5.copyWith(color: AppColors.error),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingS),
            ],
            Text(
              message,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppConstants.spacingL),
              AppButton.outline(
                text: retryText ?? 'Try Again',
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: AppConstants.iconS),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AppEmptyWidget extends StatelessWidget {
  final String message;
  final String? title;
  final IconData? icon;
  final Widget? action;
  final bool showIcon;

  const AppEmptyWidget({
    super.key,
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.showIcon = true,
  });

  const AppEmptyWidget.search({
    super.key,
    this.message = 'No results found for your search.',
    this.title = 'No Results',
    this.action,
    this.showIcon = true,
  }) : icon = Icons.search_off;

  const AppEmptyWidget.data({
    super.key,
    this.message = 'No data available at the moment.',
    this.title = 'No Data',
    this.action,
    this.showIcon = true,
  }) : icon = Icons.inbox_outlined;

  const AppEmptyWidget.flights({
    super.key,
    this.message = 'No flights found for your search criteria.',
    this.title = 'No Flights Found',
    this.action,
    this.showIcon = true,
  }) : icon = Icons.flight_takeoff;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) ...[
              Icon(
                icon ?? Icons.inbox_outlined,
                size: AppConstants.iconXXL,
                color: AppColors.grey400,
              ),
              const SizedBox(height: AppConstants.spacingL),
            ],
            if (title != null) ...[
              Text(
                title!,
                style: AppTextStyles.h5.copyWith(color: AppColors.grey600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingS),
            ],
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey600),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: AppConstants.spacingL),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class AppPlaceholderWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? color;

  const AppPlaceholderWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
  });

  const AppPlaceholderWidget.rectangular({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.color,
  });

  const AppPlaceholderWidget.circular({
    super.key,
    required double size,
    this.color,
  }) : width = size,
        height = size,
        borderRadius = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppColors.grey200,
        borderRadius: borderRadius ?? BorderRadius.circular(AppConstants.radiusS),
      ),
      child: const SizedBox.shrink(),
    );
  }
}

class AppRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? color;
  final Color? backgroundColor;

  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? AppColors.primary,
      backgroundColor: backgroundColor ?? AppColors.surface,
      strokeWidth: 3,
      child: child,
    );
  }
}

class AppProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;
  final double? minHeight;

  const AppProgressIndicator({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 4.0,
    this.minHeight,
  });

  const AppProgressIndicator.thin({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.minHeight,
  }) : strokeWidth = 2.0;

  const AppProgressIndicator.thick({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.minHeight,
  }) : strokeWidth = 6.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: minHeight,
      child: LinearProgressIndicator(
        value: value,
        color: color ?? AppColors.primary,
        backgroundColor: backgroundColor ?? AppColors.grey200,
        minHeight: strokeWidth,
      ),
    );
  }
}