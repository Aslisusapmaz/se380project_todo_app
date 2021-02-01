import 'package:flutter/material.dart';
import 'login_screen.dart';
class SignupScreen extends StatefulWidget {
  static const routeName='/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey=GlobalKey();
  TextEditingController _passwordController= new TextEditingController();
  void _done()
  {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children:<Widget> [
                Text('Login'),
                Icon(Icons.person)

              ],
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);

            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.redAccent,
                      Colors.blue,
                    ]
                )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 400,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value.isEmpty || !value.contains('@'))
                            {
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {

                          },

                        ),
                        TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Password'),
                            controller: _passwordController ,
                            obscureText:true,
                            validator:(value)
                            {
                              if(value.isEmpty || value.length<=5)
                              {
                                return 'invalid password';
                              }
                              return null;

                            },
                            onSaved:(value)
                            {

                            }
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Confirm Password'),
                            obscureText:true,
                            validator:(value)
                            {
                              if(value.isEmpty || value !=_passwordController.text)
                              {
                                return 'invalid password';
                              }
                              return null;

                            },
                            onSaved:(value)
                            {

                            }
                        ),
                        SizedBox(height: 30,),
                        RaisedButton(
                          child:Text('Done'),
                          onPressed: (){
                            _done();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.black,
                          textColor: Colors.white,
                        )
                      ],

                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
