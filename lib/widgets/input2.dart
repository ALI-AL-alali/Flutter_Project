import 'package:flutter/material.dart';

class Input2 extends StatefulWidget {
  const Input2(
      {super.key,
      required this.title,
      required this.controller,
      this.obscureText = false,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.icon,
      this.showIconCondition});
  final String title;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? icon;
  final bool Function(String)? showIconCondition;

  @override
  State<Input2> createState() => _Input2State();
}

class _Input2State extends State<Input2> {
  late ValueNotifier<bool> _showIcon;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _showIcon = ValueNotifier<bool>(
      widget.showIconCondition?.call(widget.controller.text) ??
          widget.controller.text.isNotEmpty,
    );
    widget.controller.addListener(_updateIconVisibility);
  }

  void _updateIconVisibility() {
    final condition = widget.showIconCondition?.call(widget.controller.text) ??
        widget.controller.text.isNotEmpty;
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
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: TextFormField(
              textAlign: TextAlign.right,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: _obscureText,
              validator: widget.validator,
              decoration: InputDecoration(
                  hintText: widget.title,
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
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none),
            ),
          );
        });
  }
}
