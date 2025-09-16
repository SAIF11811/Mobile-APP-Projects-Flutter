import 'package:flutter/material.dart';

/// ----------------------
/// Text Field
/// ----------------------
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscure : false,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        enabled: widget.enabled,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: widget.enabled ? Colors.black87 : Colors.grey.shade500,
        ),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon,
              color: widget.enabled ? Colors.grey.shade700 : Colors.grey.shade400)
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey.shade700,
            ),
            onPressed: () => setState(() => _obscure = !_obscure),
          )
              : null,
          hintText: widget.hintText,
          filled: true,
          fillColor: widget.enabled ? Colors.grey.shade50 : Colors.grey.shade200,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
        ),
      ),
    );
  }
}

/// ----------------------
/// Elevated Button
/// ----------------------
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool fullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final IconData? icon;
  final bool iconRight;
  final bool selected;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.fullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 12,
    this.elevation = 4,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    this.icon,
    this.iconRight = false,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = selected
        ? const Color(0xFFcdcc00)
        : (backgroundColor ?? Colors.white30);

    final fgColor = selected
        ? Colors.white
        : (textColor ?? Colors.white);

    final buttonChild = isLoading
        ? const SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null && !iconRight) ...[
          Icon(icon, size: 20, color: fgColor),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: fgColor,
          ),
        ),
        if (icon != null && iconRight) ...[
          const SizedBox(width: 8),
          Icon(icon, size: 20, color: fgColor),
        ],
      ],
    );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: selected
                ? BorderSide(color: Colors.white, width: 1.5)
                : BorderSide.none,
          ),
          padding: padding,
          elevation: elevation,
          disabledBackgroundColor: Colors.grey.shade400,
          disabledForegroundColor: Colors.grey.shade200,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: buttonChild,
        ),
      ),
    );
  }
}
