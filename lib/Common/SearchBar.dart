import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function() function;
  SearchBar(
      {required this.controller,
      required this.function,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onEditingComplete: function,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: Icon(
                  Icons.search,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                  },
                ),
                hintText: hintText,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
