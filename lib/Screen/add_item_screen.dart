import 'package:flutter/material.dart';
import 'package:interview/Widgtes/custom_widget.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  Map<String, String> fields = {};
  List<Widget> customWidgets = [];
  final List<TextEditingController> _controllers = [];
  final List<String> _dropDownValue = [];

  bool showFields = false;
  final _nameController = TextEditingController();

  void _addField() {
    setState(() {
      _controllers.add(TextEditingController());
      _dropDownValue.add("Text");
    });
  }

  void removeIndex(int index) {
    _controllers[index].dispose();
    _controllers.removeAt(index);
    _dropDownValue.removeAt(index);
  }

  @override
  void initState() {
    super.initState();
    _addField();
  }

  Map<String, String> generateMap() {
    
    Map<String, String> dataMap = {};
    if (_controllers.isNotEmpty && _dropDownValue.isNotEmpty) {
      for (int i = 0; i < _controllers.length; i++) {
        dataMap[_controllers[i].text] = _dropDownValue[i];
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Add the fields first")));
    }
    return dataMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Item Screen"),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _nameController.text = value;
                    });
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Fields"),
                  Switch(
                      value: showFields,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          if (_nameController.text.isNotEmpty) {
                            if (_controllers.isEmpty) {
                              _addField();
                            }
                            showFields = value;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Please Add the Item Name first")));
                          }
                        });
                      }),
                ],
              ),
              if (showFields)
                SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _controllers.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomWidget(
                                controller: _controllers[index],
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      _controllers[index].text = value;
                                    });
                                  }
                                },
                                onChangeDropDown: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      _dropDownValue[index] = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.amber,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      if (_controllers[index].text.isEmpty ||
                                          _dropDownValue[index].isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Provide the Data first",
                                            ),
                                          ),
                                        );
                                      } else if (index ==
                                          _controllers.length - 1) {
                                        _addField();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Add Data in the Next Field",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.amber,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      print(
                                          "The value of the Controller at the Index is ${_controllers[index].text} and the DropDown Value is ${_dropDownValue[index]}");
                                      setState(() {
                                        removeIndex(index);
                                      });
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                     
                      var map = generateMap();
                      print("Name of the Item is ${_nameController.text}");
                      print(map);
                    },
                    child: const Text("Add")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
