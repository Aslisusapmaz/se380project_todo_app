import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferences localStorage;

  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isSaving = false;

  Future init() async {
    localStorage = await SharedPreferences.getInstance();
    try {
      String name = localStorage.getString("name");
      String surname = localStorage.getString("surname");
      nameController.text = name;
      surnameController.text = surname;
      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueAccent, Colors.pinkAccent],
                )),
                child: Container(
                    width: double.infinity,
                    height: 320.0,
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'User Profile',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ))),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Name *',
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                          child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: surnameController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: 'Surname *',
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 300,
                child: RaisedButton(
                    onPressed: () async {
                      setState(() {
                        isSaving = true;
                      });
                      await localStorage.setString(
                          'name', nameController.text.toString());
                      await localStorage.setString(
                          'surname', surnameController.text.toString());
                      setState(() {
                        isSaving = false;
                      });
                      scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("Saved successfully!"),
                      ));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    elevation: 0.0,
                    padding: EdgeInsets.all(0.0),
                    child: isSaving
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.pinkAccent, Colors.redAccent],
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                          )),
              )
            ],
          ),
        ));
  }
}
