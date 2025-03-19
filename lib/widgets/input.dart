import 'package:flutter/material.dart';

class Input extends StatefulWidget {
   const Input(
      {super.key, required this.text,
      required this.validator,
      required this.mycontroller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.icon,
      this.showIconCondition});

  final String text;
  final String? Function(String?) validator;
  final TextEditingController mycontroller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? icon;
  final bool Function(String)? showIconCondition;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late ValueNotifier<bool> _showIcon;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _showIcon = ValueNotifier<bool>(
      widget.showIconCondition?.call(widget.mycontroller.text) ??
          widget.mycontroller.text.isNotEmpty,
    );
    widget.mycontroller.addListener(_updateIconVisibility);
  }

  void _updateIconVisibility() {
    final condition =
        widget.showIconCondition?.call(widget.mycontroller.text) ??
            widget.mycontroller.text.isNotEmpty;
    _showIcon.value = condition;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _showIcon,
        builder: (context, showIcon, _) {
          return TextFormField(
            controller: widget.mycontroller,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            obscureText: _obscureText,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: widget.text,
              prefixIcon: showIcon
                  ? (widget.icon ??
                      (widget.obscureText
                          ? IconButton(
                              onPressed: _toggleObscureText,
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off_sharp,
                              ),
                            )
                          : null))
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          );
        });
  }
}
