import 'package:dd/src/screens/logIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class signInScreen extends StatefulWidget {
  @override
  _signInScreenState createState() => _signInScreenState();
}

class _signInScreenState extends State<signInScreen> {
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
            'SignIn ',
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
                hintText: 'Enter Username',
                icon: Icon(Icons.person),
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
                //RaisedButton(onPressed: (){
                 // auth.signInWithEmailAndPassword(email: _email, password: _password);
                 // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> homeScreen()));
                //}, child: Text('SignIn'),),
                ElevatedButton(onPressed: ()async{
                  //auth.createUserWithEmailAndPassword(email: _email, password: _password);
                        try {
                              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: _email,
                                password: _password,
                              );
                              if(userCredential.user.uid !=null)
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> loginScreen()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                                var weakpass = SnackBar(content: Text("The password provided is too weak."), backgroundColor: Colors.red );
                                _scaffoldKey.currentState.showSnackBar(weakpass);
                              } else if (e.code == 'email-already-in-use') {
                                print('The account already exists for that email.');
                                var emailexist = SnackBar(content: Text("The account already exists for that email."), backgroundColor: Colors.red );
                                _scaffoldKey.currentState.showSnackBar(emailexist);
                              }
                            } catch (e) {
                              print(e);
                            }
                 

                }, child: Text('SignUp')),
              ],
            ),
          ),
        ],
      ),
      
    );
  }
}