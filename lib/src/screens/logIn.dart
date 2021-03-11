import 'package:dd/src/screens/home.dart';
import 'package:dd/src/screens/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  String _email,  _password;
  final auth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Login ',
            style: TextStyle(fontSize: 22,color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
         backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter Email',
                icon: Icon(Icons.email),
              ),
              onChanged: (value){
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter Password',
                icon: Icon(Icons.lock),
              ),
              onChanged: (value){
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: ()async{
                  //auth.signInWithEmailAndPassword(email: _email, password: _password);
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email:_email,
                      password: _password,
                    );
                    if(userCredential.user.uid !=null )
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreen()));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                      var snackbar = SnackBar(content: Text("No user found for that email."), backgroundColor: Colors.red );
                      _scaffoldKey.currentState.showSnackBar(snackbar);
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                      var wrongpass = SnackBar(content: Text("Wrong password provided for that user."), backgroundColor: Colors.red );
                      _scaffoldKey.currentState.showSnackBar(wrongpass);
                    }
                  }
                }, child: Text('SignIn'),),
                ElevatedButton(onPressed: (){
                  //auth.createUserWithEmailAndPassword(email: _email, password: _password);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> signInScreen()));

                }, child: Text('SignUp')),
              ],
            ),
          ),
        ],
      ),
      
    );
  }
}