// ignore_for_file: unused_shown_name, file_names

import 'package:flutter/material.dart'
    show
        AssetImage,
        Border,
        BorderRadius,
        BoxDecoration,
        BoxFit,
        BuildContext,
        Center,
        Color,
        Column,
        Container,
        DecorationImage,
        EdgeInsets,
        ElevatedButton,
        FontStyle,
        FontWeight,
        FormState,
        GlobalKey,
        Icon,
        Icons,
        Image,
        InputBorder,
        InputDecoration,
        Key,
        MaterialPageRoute,
        Navigator,
        Padding,
        SafeArea,
        Scaffold,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        TextEditingController,
        TextField,
        TextFormField,
        TextInputType,
        TextStyle,
        Widget;
import 'package:main/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({Key? key}) : super(key: key);

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  int currentIndex = 0;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController boxcontroller = TextEditingController();
  TextEditingController feecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 249, 82),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/0.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                //welcome text
                const Text(
                  'SRI HARI CABLES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 29,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'let make it better maintanace',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: namecontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'NAME',
                        icon: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 252, 252)),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: boxcontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'BOX NO',
                        icon: Icon(Icons.bento_rounded),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: feecontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'monthly fee',
                        icon: Icon(Icons.attach_money_sharp),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (namecontroller.text.isEmpty) {
                      return;
                    } else if (boxcontroller.text.isEmpty) {
                      //
                    } else if (feecontroller.text.isEmpty) {
                      //
                    } else {
                      SharedPreferences main =
                          await SharedPreferences.getInstance();
                      var name = main.getStringList("name") ?? [];
                      var box = main.getStringList("box") ?? [];
                      var fee = main.getStringList("fee") ?? [];
                      name.add(namecontroller.text);
                      box.add(boxcontroller.text);
                      fee.add(feecontroller.text);

                      await main.setStringList("name", name);
                      await main.setStringList("box", box);
                      await main.setStringList("fee", fee);

                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Homepage(),
                        ),
                      );
                    }
                  },
                  child: const Text("submit"),
                )
                //register  button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
