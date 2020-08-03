import 'package:covid_tracker/controllers/User.dart';
import 'package:flutter/material.dart';

class  Login extends StatefulWidget {


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>() ;
  
 
  static bool success;
  static var signedUpUserEmail;
  
  

  updateEmailAndUser(String email, bool successSet){
    setState((){
      success = successSet;
      signedUpUserEmail = email;
    });
  }

  setSuccessToFalse(bool success){
    setState((){
      success = false;
      
    });
  }
  
  var emailController, passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Covik'),
      ),

      body: Container(
        child: Column(
          children: <Widget>[
            Text('Login to Covik'),
            SizedBox(height: 15),

            //Login Form with TextFormFields
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(

                    validator: (value){

                      if(value.isEmpty){
                        return 'Email address required';

                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'email',
                      hintText: 'your email address',
                      icon: Icon(Icons.email),

                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    validator: (enteredText){
                      if (enteredText.isEmpty) {
                        //Display error message
                        return 'The email field is required';
                        
                      }

                      return null;

                      
                    },
                    decoration: InputDecoration(
                      labelText: 'password',
                      hintText: 'your account password',
                      icon: Icon(Icons.email),

                    ),
                  ),

                  RaisedButton.icon(onPressed: (){
                   

                    if ( _formKey.currentState.validate()) {

                      UserController(email: emailController.text, password: passwordController.text, updateEmailAndUser: updateEmailAndUser, setSuccessToFalse: setSuccessToFalse(success)).login();

                      
                        print(Text('Login Button pressed'));
                    }

                    
                  }, icon: Icon(Icons.send), label: Text('Login'))
                ],
              ))
          ],
        )
      ),

   
    );
  }
}