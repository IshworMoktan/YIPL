import 'package:flutter/material.dart';

contentTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
  );
}

appbarTitle(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 25, color: Colors.black),
  );
}

contentBody(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 13, color: Colors.black),
  );
}

timestamp(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
  );
}
