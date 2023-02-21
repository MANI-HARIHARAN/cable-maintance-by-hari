import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
// import 'package:main/editcustomer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  List? Name;
  List? Box;
  List? Fee;
  int? count;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    SharedPreferences main = await SharedPreferences.getInstance();
    var name = main.getStringList("name") ?? ["NAME"];
    var box = main.getStringList("box") ?? ["BOX NO"];
    var fee = main.getStringList("fee") ?? ["AMOUNT"];
    if (name.isEmpty) {
      setState(() {
        var count = 0;
      });
    } else {
      setState(() {
        Name = name;
        Box = box;
        Fee = fee;
        count = name.length;
      });
    }
  }

  Future<void> editValue(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit customer"),
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onDoubleTap: () {
              String? updatedName;
              String? updatedBox;
              String? updatedFee;

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Expanded(
                    child: AlertDialog(
                      title: const Text('UPDATE'),
                      content: Column(
                        children: [
                          TextField(
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            onChanged: (value) {
                              updatedName = value;
                            },
                          ),
                          TextField(
                            decoration: const InputDecoration(labelText: 'Box'),
                            onChanged: (value) {
                              updatedBox = value;
                            },
                          ),
                          TextField(
                            decoration: const InputDecoration(labelText: 'Fee'),
                            onChanged: (value) {
                              updatedFee = value;
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Back'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Edit(),
                                ));
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: ListTile(
              title: Text(Name![index]),
              subtitle: Text(Box![index]),
              trailing: Text(Fee![index]),
            ),
          );
        },
      ),
    );
  }
}
