import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Editpage extends StatefulWidget {
  const Editpage({Key? key}) : super(key: key);

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  List<String>? Name;
  List<String>? Box;
  List<String>? Fee;
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
        count = 0;
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
        backgroundColor: Color.fromARGB(139, 247, 88, 88),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/12.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
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
                              decoration:
                                  const InputDecoration(labelText: 'Box'),
                              onChanged: (value) {
                                updatedBox = value;
                              },
                            ),
                            TextField(
                              decoration:
                                  const InputDecoration(labelText: 'Fee'),
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
                            onPressed: () {
                              if (updatedName != null) {
                                Name![index] = updatedName!;
                              }
                              if (updatedBox != null) {
                                Box![index] = updatedBox!;
                              }
                              if (updatedFee != null) {
                                Fee![index] = updatedFee!;
                              }

                              editValue("name", Name!);
                              editValue("box", Box!);
                              editValue("fee", Fee!);

                              setState(() {});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Homepage(),
                                ),
                              );
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: ListTile(
                leading: Text((index + 1).toString()),
                title: Text(Name![index]),
                subtitle: Text(Box![index]),
                trailing: Text(Fee![index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
