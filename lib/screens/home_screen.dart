import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se380_project_todo_app/screens/login_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  {
  List todos = List();
  CalendarController _controller;

  String input = '';

  createTodos() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('My Todos').doc(input);
    Map<String, String> todos = {'todoTitle': input};
    documentReference.set(todos).whenComplete(() {
      print('$input created');
    });
  }

  deleteTodos() {}
  @override
  void initState(){
    //TODO:implement state
    super.initState();
    _controller=CalendarController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My todos'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
              })
        ],
      ),
        body: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TableCalendar(
                initialCalendarFormat: CalendarFormat.week,
                  calendarStyle: CalendarStyle(
                    todayColor: Colors.orange,
                    selectedColor: Theme.of(context).primaryColor,
                    todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white
                    )
                  ),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    formatButtonTextStyle:TextStyle(
                      color: Colors.white
                    ),
                    formatButtonShowsNext: false,
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarController: _controller),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('My Todos').snapshots(),
                  builder: (context, snapshots) {
                    if (snapshots.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshots.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot =
                            snapshots.data.docs[index];
                            return Dismissible(
                                key: Key(index.toString()),
                                onDismissed: (_) async {
                                  await FirebaseFirestore.instance
                                      .collection("My Todos")
                                      .doc(documentSnapshot['todoTitle'])
                                      .delete();
                                },
                                child: Card(
                                  elevation: 4,
                                  margin: EdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ListTile(
                                    title: Text(documentSnapshot['todoTitle']),
                                    trailing: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection("My Todos")
                                              .doc(documentSnapshot['todoTitle'])
                                              .delete();
                                        }),
                                  ),
                                ));
                          });
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ],
        ),


      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text('Add TodoList'),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          createTodos();
                          Navigator.of(context).pop();
                        },
                        child: Text('Add'))
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

    );
  }
}
