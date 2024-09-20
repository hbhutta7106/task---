import 'package:flutter/material.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({
    super.key,
    required this.onChanged,
    required this.onChangeDropDown,
    required this.controller,
  });

  final Function(String value) onChanged;
  final TextEditingController controller;
 

  final Function(String value) onChangeDropDown;

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  void initState() {
    super.initState();
  }

  String? initialTextFieldValue;
  String? initialDropDownValue="Text";


  List<String> listOfLabels = ["Text", "Number"];
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller:widget.controller ,
                    onChanged: (value) {
                      setState(() {
                        initialTextFieldValue = value;
                      });
                      widget.onChanged(value);
                    },
                    decoration: const InputDecoration(
                      label: Text("Value"),
                      hintText: "item Field",
                    ),
                  ),
                ),
                DropdownButton<String>(
                  underline: const SizedBox(),
                  value: initialDropDownValue,
                  items: listOfLabels.map((label) {
                    return DropdownMenuItem<String>(
                      value: label,
                      child: Text(label),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      initialDropDownValue = value!;
                    });
                    widget.onChangeDropDown(value!);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
