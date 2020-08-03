import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  String email;
  String password;
  Function updateEmailAndUser;
  Function setSuccessToFalse;

  

  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;

    UserController({this.password, this.email, this.setSuccessToFalse, this.updateEmailAndUser});

  void login() {
    //login user
    //pass user email and password params to firebase login method
    //Check if successfull and set success to true
    //Tell user to register if not registered
    //return FirebaseUser user object



  }

  void register() async {
    //Register user
    // 1. create firebase auth object instance to get method
    
    final FirebaseUser user =  (await _firebaseauth //this is an async task
        .createUserWithEmailAndPassword(email: email, password: password)
    ).user;

    
    if (user == null) {

      updateEmailAndUser(user.email, true);
            
          } else {
      setSuccessToFalse(false);
          }
        }
      
        
}
