import 'package:codefest_travel_app/core/utils/app_exports.dart';

class CustomTextInputField extends StatefulWidget {
  const CustomTextInputField({
    super.key,
    required this.context,
    required this.type,
    required this.hintLabel,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.maxLines,
    this.minLines,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.validator,
    this.enabled,
    this.readOnly,
    this.expands,
    this.obscureText,
    this.obscuringCharacter,
    this.keyboardType,
    this.autoFillHints,
    this.suffixIcon,
    this.prefixIcon,
    this.boxConstraints,
    this.inputFormatters,
    this.contentPadding,
    this.fillColor,
    this.filled,
    this.hintStyle,
    this.isCapitalized = false,
    this.label,
    this.suffixText = false,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.maxLength,
    this.autofillHints,
    this.inputDecoration,
    this.suffixBoxConstraints,
    this.isDense = true,
    this.cursorColor,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    this.prefixIconPath,
    this.inputLabel,
    this.borderRadius,
    this.backgroundColor,
    this.isAuthField = true,
  });

  final BuildContext context;
  final InputType type;
  final String hintLabel;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final int? maxLines;
  final int? minLines;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool? readOnly;
  final bool? expands;
  final bool? obscureText;
  final String? obscuringCharacter;
  final TextInputType? keyboardType;
  final Iterable<String>? autoFillHints;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BoxConstraints? boxConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final bool? filled;
  final TextStyle? hintStyle;
  final bool isCapitalized;
  final String? label;
  final bool suffixText;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final int? maxLength;
  final Function()? onTap;
  final Function(String)? onChanged;
  final List<String>? autofillHints;
  final InputDecoration? inputDecoration;
  final BoxConstraints? suffixBoxConstraints;
  final bool isDense;
  final Color? cursorColor;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final String? prefixIconPath;
  final String? inputLabel;
  final double? borderRadius;
  final Color? backgroundColor;
  final bool isAuthField;

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  FocusNode? _internalFocusNode;
  late bool _hasText;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode!;

  @override
  void initState() {
    super.initState();

    _hasText = widget.controller.text.isNotEmpty;
    widget.controller.addListener(_handleTextChange);

    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
    }
    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant CustomTextInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      final oldFocusNode = oldWidget.focusNode ?? _internalFocusNode;
      oldFocusNode?.removeListener(_handleFocusChange);

      if (oldWidget.focusNode == null && widget.focusNode != null) {
        _internalFocusNode?.dispose();
        _internalFocusNode = null;
      } else if (oldWidget.focusNode != null && widget.focusNode == null) {
        _internalFocusNode = FocusNode();
      }

      _effectiveFocusNode.addListener(_handleFocusChange);
    }
  }

  void _handleTextChange() {
    final hasText = widget.controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _handleFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    _effectiveFocusNode.removeListener(_handleFocusChange);
    _internalFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocused = _effectiveFocusNode.hasFocus;
    final bool isActive = isFocused || _hasText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FormField<String>(
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,

          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.0),
                    color: widget.isAuthField
                        ? (widget.backgroundColor ?? Theme.of(context).customColors.textFieldFillColor)
                        : (widget.backgroundColor ?? Theme.of(context).customColors.rectangleColor),
                    boxShadow: isFocused
                        ? [
                            BoxShadow(
                              color: Theme.of(context).customColors.primaryColor!.withValues(alpha: 0.6),
                              blurRadius: 8.0,
                            ),
                          ]
                        : [],
                  ),
                  child: TextFormField(
                    cursorColor: widget.cursorColor ?? Theme.of(context).customColors.primaryColor,
                    cursorWidth: 1.2,
                    clipBehavior: Clip.antiAlias,
                    controller: widget.controller,
                    focusNode: _effectiveFocusNode,
                    autofillHints: widget.autofillHints,
                    keyboardType: widget.keyboardType ?? _getKeyboardType(),
                    textInputAction: widget.textInputAction,
                    textCapitalization: _getTextCapitalization(),
                    maxLines: widget.maxLines ?? 1,
                    minLines: widget.minLines ?? 1,
                    validator: (_) => null,
                    textAlignVertical: TextAlignVertical.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400),
                    obscureText: widget.obscureText ?? false,
                    obscuringCharacter: widget.obscuringCharacter ?? '•',
                    maxLength: widget.maxLength,
                    enabled: widget.enabled ?? true,
                    onChanged: (value) {
                      widget.onChanged?.call(value);
                      field.didChange(value);
                      field.validate();
                    },
                    onFieldSubmitted: widget.onFieldSubmitted,
                    inputFormatters: widget.inputFormatters,
                    decoration:
                        widget.inputDecoration ??
                        InputDecoration(
                          counterText: '',
                          hintText: widget.hintLabel,
                          hintStyle:
                              widget.hintStyle ??
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 16.sp,
                                color: Theme.of(context).customColors.greyColor,
                                fontWeight: FontWeight.w400,
                              ),
                          contentPadding:
                              widget.contentPadding ?? const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                          prefixIcon:
                              widget.prefixIcon ??
                              (widget.prefixIconPath != null
                                  ? Container(
                                      margin: EdgeInsets.only(right: 7.0.w),
                                      height: 24.0.h,
                                      width: 55.0.w,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Theme.of(context).customColors.dividerColor!),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: CustomImageView(
                                        imagePath: widget.prefixIconPath,
                                        height: 24.0.h,
                                        color: isActive
                                            ? Theme.of(context).customColors.whiteColor
                                            : Theme.of(context).customColors.greyColor,
                                      ),
                                    )
                                  : null),
                          prefixIconConstraints:
                              widget.boxConstraints ??
                              (widget.prefixIconPath != null ? const BoxConstraints(maxWidth: 80.0) : null),
                          suffixIconConstraints: widget.suffixBoxConstraints ?? const BoxConstraints(maxWidth: 50.0),
                          fillColor: widget.isAuthField
                              ? (widget.backgroundColor ?? Theme.of(context).customColors.textFieldFillColor)
                              : (widget.backgroundColor ?? Theme.of(context).customColors.rectangleColor),
                          filled: widget.filled ?? true,
                          errorText: null,
                          errorStyle: const TextStyle(height: 0),
                          suffixIcon: widget.suffixIcon,
                          isDense: widget.isDense,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: widget.isAuthField
                                  ? Theme.of(context).customColors.borderColor!
                                  : Theme.of(context).customColors.lightBorderColor!,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: widget.isAuthField
                                  ? Theme.of(context).customColors.borderColor!
                                  : Theme.of(context).customColors.lightBorderColor!,
                              width: 1,
                            ),
                          ),
                          errorMaxLines: 2,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Theme.of(context).customColors.primaryColor!, width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Theme.of(context).customColors.errorColor!, width: 1),
                          ),
                        ),
                    autovalidateMode: AutovalidateMode.disabled,
                    cursorErrorColor: Theme.of(context).customColors.primaryColor,
                    errorBuilder: (context, errorText) => const SizedBox.shrink(),
                    readOnly: widget.readOnly ?? false,
                    onTap: widget.onTap,
                  ),
                ),

                if (field.errorText != null && field.errorText!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 5.0.h, left: 16.0),
                    child: Text(
                      field.errorText!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(color: Theme.of(context).customColors.redColor, fontSize: 12.sp),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.phoneNumber:
        return TextInputType.phone;
      case InputType.digits:
        return TextInputType.number;
      case InputType.decimalDigits:
        return const TextInputType.numberWithOptions(decimal: true);
      case InputType.multiline:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  TextCapitalization _getTextCapitalization() {
    switch (widget.type) {
      case InputType.password:
      case InputType.confirmPassword:
      case InputType.newPassword:
        // Opens keyboard with capital letters for easier password typing
        return TextCapitalization.sentences;
      case InputType.email:
        // Email should always be lowercase
        return TextCapitalization.none;
      case InputType.name:
        // Capitalize each word for names
        return TextCapitalization.words;
      default:
        // Normal sentence capitalization
        return TextCapitalization.sentences;
    }
  }
}

enum InputType {
  name,
  text,
  email,
  password,
  confirmPassword,
  newPassword,
  phoneNumber,
  digits,
  decimalDigits,
  multiline,
}
