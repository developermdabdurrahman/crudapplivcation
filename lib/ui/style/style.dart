
import 'package:flutter/material.dart';

InputDecoration AppInputDecoration(label,label1){
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
    hintText: label1,
    hintStyle: TextStyle(color: Colors.grey),
    prefixIcon: Icon(Icons.person, color: Colors.blue),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.green, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
  );
}


