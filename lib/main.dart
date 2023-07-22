import 'package:firebase/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
    final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
        body: Column(
          children: [
            TextField(
              controller: _textController1,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: (){
                      _textController1.clear();
                    },
                    icon: Icon(Icons.clear),
                  )
              ),
            ),
//====================================================

            TextField(
              controller: _textController2,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),


                  suffixIcon: IconButton(
                    onPressed: (){
                      _textController2.clear();
                    },
                    icon: Icon(Icons.clear),
                  )
              ),
            ),


            //
            ElevatedButton(onPressed: ()async{
            try{UserCredential userCredential =await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _textController1.text, password: _textController2.text);
             // print(userCredential);
            }
            on FirebaseAuthException catch(e){
              if(e.code=="weak-password"){
                print("weak passord");
              }
              else if(e.code=="email-already-in-use"){
                print("already exist");
              }
            }
            catch(e){
               print("e");
            }
            },
            child: Text("createUserWithEmailAndPassword"),
            ),

            // sign in
             ElevatedButton(onPressed: ()async{
            try{UserCredential userCredential =await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _textController1.text, password: _textController2.text);
             // print(userCredential);
             print("exist");
             print(userCredential.user?.emailVerified);
            MaterialPageRoute(
              builder: (context) => HommPage(),);
             if(userCredential.user?.emailVerified==false){
              User? user =FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();


             }
            }
            on FirebaseAuthException catch(e){
              if(e.code=="user-not-found"){
                print("user-not-found");
              }
              else if(e.code=="wrong-password"){
                print("wrong-passord");
              } 
            }
     
            catch(e){
               print("e");
            } 
             
            },
           
            child: const Text("signInWithEmailAndPassword"),
            ),

//===========================
          ],
        ),
        
        ),
    );
  }
}
