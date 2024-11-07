import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TaskField extends StatelessWidget {
  TaskField({
    super.key,
    this.controller,this.hintText,this.maxLine=1
  });

  String? hintText;
  TextEditingController? controller;
  int? maxLine;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.roboto().copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: Colors.grey),
      maxLines: maxLine,
      controller:controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.roboto().copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
