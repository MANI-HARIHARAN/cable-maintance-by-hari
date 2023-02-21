// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:main/Registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
        var count = 1;
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

  deleteData(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> nameList = prefs.getStringList("name") ?? [];
    List<String> boxList = prefs.getStringList("box") ?? [];
    List<String> feeList = prefs.getStringList("fee") ?? [];

    nameList.removeAt(index);
    boxList.removeAt(index);
    feeList.removeAt(index);

    await prefs.setStringList("name", nameList);
    await prefs.setStringList("box", boxList);
    await prefs.setStringList("fee", feeList);

    setState(() {
      Name = nameList;
      Box = boxList;
      Fee = feeList;
      count = nameList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "customer Data",
          // style: TextStyle(color: Color.fromARGB(255, 253, 253, 253)),
        ),
        backgroundColor: const Color.fromARGB(139, 247, 88, 88),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(192, 38, 150, 206),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            TextButton(
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Registerpage(),
                  ),
                );
              }),
              child: const Text(
                "Add customer",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            TextButton(
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Editpage(),
                  ),
                );
              }),
              child: const Text(
                "Edit customer",
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            // TextButton(
            //   onPressed: (() {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const Registerpage(),
            //       ),
            //     );
            //   }),
            //   child: const Text("setting"),
            // )
          ],
        ),
      ),
      // backgroundColor: Color.fromARGB(122, 251, 248, 248),
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
            return Column(
              children: [
                ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(Box?[index] ?? "Box"),
                  subtitle: Text(Name?[index] ?? "NAME"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(Fee?[index] ?? "AMOUNT"),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Delete'),
                            content: const Text('confirm to delete'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Back'),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleteData(index);
                                  Navigator.pop(context);
                                },
                                child: const Text('delete'),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                  color: Color.fromARGB(255, 0, 0, 0),
                  height: 25,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
