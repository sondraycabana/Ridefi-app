import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

enum AppTextFieldSize { small, medium, large }

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final AppTextFieldSize size;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool filled;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.focusNode,
    this.size = AppTextFieldSize.medium,
    this.contentPadding,
    this.borderRadius,
    this.fillColor,
    this.textStyle,
    this.hintStyle,
    this.filled = true,
  });

  const AppTextField.search({
    super.key,
    this.label,
    this.hint = 'Search...',
    this.helperText,
    this.errorText,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.controller,
    this.textInputAction = TextInputAction.search,
    this.readOnly = false,
    this.enabled = true,
    this.inputFormatters,
    this.focusNode,
    this.size = AppTextFieldSize.medium,
    this.contentPadding,
    this.borderRadius,
    this.fillColor,
    this.textStyle,
    this.hintStyle,
    this.filled = true,
  }) : prefixIcon = const Icon(Icons.search),
       keyboardType = TextInputType.text,
       obscureText = false,
       maxLines = 1,
       minLines = null,
       maxLength = null;

  const AppTextField.password({
    super.key,
    this.label,
    this.hint = 'Password',
    this.helperText,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.controller,
    this.textInputAction = TextInputAction.done,
    this.readOnly = false,
    this.enabled = true,
    this.inputFormatters,
    this.focusNode,
    this.size = AppTextFieldSize.medium,
    this.contentPadding,
    this.borderRadius,
    this.fillColor,
    this.textStyle,
    this.hintStyle,
    this.filled = true,
  }) : prefixIcon = const Icon(Icons.lock),
       suffixIcon = null, // Will be handled in build method
       keyboardType = TextInputType.visiblePassword,
       obscureText = true,
       maxLines = 1,
       minLines = null,
       maxLength = null;

  const AppTextField.multiline({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.controller,
    this.textInputAction = TextInputAction.newline,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 4,
    this.minLines = 2,
    this.maxLength,
    this.inputFormatters,
    this.focusNode,
    this.size = AppTextFieldSize.medium,
    this.contentPadding,
    this.borderRadius,
    this.fillColor,
    this.textStyle,
    this.hintStyle,
    this.filled = true,
  }) : keyboardType = TextInputType.multiline,
       obscureText = false;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputHeight = _getInputHeight();
    final defaultPadding = _getDefaultPadding();
    final textStyle = widget.textStyle ?? _getTextStyle();
    final hintStyle = widget.hintStyle ?? _getHintStyle();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTextStyles.inputLabel,
          ),
          const SizedBox(height: AppConstants.spacingXS),
        ],
        SizedBox(
          height: widget.maxLines == 1 ? inputHeight : null,
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            onTap: widget.onTap,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: _obscureText,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            style: textStyle,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: hintStyle,
              helperText: widget.helperText,
              errorText: widget.errorText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: _buildSuffixIcon(),
              filled: widget.filled,
              fillColor: widget.fillColor ?? _getFillColor(),
              border: _buildBorder(),
              enabledBorder: _buildBorder(),
              focusedBorder: _buildFocusedBorder(),
              errorBorder: _buildErrorBorder(),
              focusedErrorBorder: _buildFocusedErrorBorder(),
              disabledBorder: _buildDisabledBorder(),
              contentPadding: widget.contentPadding ?? defaultPadding,
              counterText: widget.maxLength != null ? null : '',
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: AppColors.textSecondary,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return widget.suffixIcon;
  }

  double _getInputHeight() {
    return switch (widget.size) {
      AppTextFieldSize.small => AppConstants.inputHeightSmall,
      AppTextFieldSize.medium => AppConstants.inputHeight,
      AppTextFieldSize.large => AppConstants.inputHeightLarge,
    };
  }

  EdgeInsetsGeometry _getDefaultPadding() {
    return switch (widget.size) {
      AppTextFieldSize.small => const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingS,
        ),
      AppTextFieldSize.medium => const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingM,
        ),
      AppTextFieldSize.large => const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingL,
          vertical: AppConstants.paddingL,
        ),
    };
  }

  TextStyle _getTextStyle() {
    return switch (widget.size) {
      AppTextFieldSize.small => AppTextStyles.bodySmall,
      AppTextFieldSize.medium => AppTextStyles.inputText,
      AppTextFieldSize.large => AppTextStyles.bodyLarge,
    };
  }

  TextStyle _getHintStyle() {
    return switch (widget.size) {
      AppTextFieldSize.small => AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
      AppTextFieldSize.medium => AppTextStyles.inputHint,
      AppTextFieldSize.large => AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
    };
  }

  Color _getFillColor() {
    if (!widget.enabled) return AppColors.grey200;
    if (widget.errorText != null) return AppColors.error.withValues(alpha: 0.05);
    return widget.fillColor ?? AppColors.surfaceVariant;
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? AppTheme.radiusMedium,
      borderSide: BorderSide.none,
    );
  }

  OutlineInputBorder _buildFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? AppTheme.radiusMedium,
      borderSide: const BorderSide(color: AppColors.primary, width: AppConstants.borderWidthThick),
    );
  }

  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? AppTheme.radiusMedium,
      borderSide: const BorderSide(color: AppColors.error, width: AppConstants.borderWidthThin),
    );
  }

  OutlineInputBorder _buildFocusedErrorBorder() {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? AppTheme.radiusMedium,
      borderSide: const BorderSide(color: AppColors.error, width: AppConstants.borderWidthThick),
    );
  }

  OutlineInputBorder _buildDisabledBorder() {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? AppTheme.radiusMedium,
      borderSide: BorderSide(color: AppColors.grey300, width: AppConstants.borderWidthThin),
    );
  }
}