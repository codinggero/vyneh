import 'package:flutter/material.dart';
import 'package:textfield_search/textfield_search.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const CustomTextFieldWidget({
    super.key,
    this.controller,
    this.obscureText = false,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          errorStyle: const TextStyle(color: Colors.black),
        ),
        textInputAction: TextInputAction.next,
        validator: validator,
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}

class SearchPlaces extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final List<dynamic>? initialList;
  final TextStyle? textStyle;
  final Function? future;
  final Function? onSelected;
  final InputDecoration? decoration;
  final ScrollbarDecoration? scrollbarDecoration;
  final int itemsInView;
  final int minStringLength;

  final String? hintText;
  final void Function()? onTap;
  final Widget? child;
  final InputBorder? border;

  const SearchPlaces({
    super.key,
    required this.label,
    required this.controller,
    this.initialList,
    this.textStyle,
    this.future,
    this.onSelected,
    this.decoration,
    this.scrollbarDecoration,
    this.itemsInView = 5,
    this.minStringLength = 3,
    this.hintText,
    this.onTap,
    this.child,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldSearch(
      initialList: initialList,
      label: label,
      controller: controller!,
      textStyle: textStyle,
      future: future,
      getSelectedValue: onSelected,
      decoration: decoration ??
          InputDecoration(
            hintText: hintText,
            prefixIcon: InkWell(
              onTap: onTap,
              child: child,
            ),
            border: border,
          ),
      scrollbarDecoration: scrollbarDecoration,
      itemsInView: itemsInView,
      minStringLength: minStringLength,
    );
  }
}
