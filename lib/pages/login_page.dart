import 'package:farmapp/utils/progressHUD.dart';
import 'package:flutter/material.dart';


//import '../api_service.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
   GlobalKey<FormState> globalKey2 = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;
  late String username;
  late String password;
 // APIService apiService;

  
  @override
  void initState() {
    //apiService = new APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      isAsyncCall: isApiCallProcess,
      opacity: 0.3, key: globalKey2 ,
      
      
    );
  }

  Widget _uiSetup(BuildContext context){

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        offset: Offset(0, 10),
                        blurRadius: 20
                      )
                    ]
                  ),
                  child: Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        SizedBox(height: 25,),
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline2,
                          ),

                          SizedBox(height: 20,),

                          new TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => username = input!,
                            validator: (input) => !input!.contains('@') ?
                            "Email Id shuld be valid" : null,

                            decoration: new InputDecoration(
                              hintText: "Email Address",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                                )

                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  
                                ),
                                
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            ),
                          ),

                          SizedBox(height: 20,),

                           new TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (input) => password = input!,
                            validator: (input) => input!.length < 3 ?
                            "Password should be more 3 character" : null,

                            obscureText: hidePassword,

                            decoration: new InputDecoration(
                              hintText: "Password",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                                )

                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                  
                                ),
                                
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).colorScheme.secondary,
                              ), 
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hidePassword ? Icons.visibility_off : Icons.visibility
                                ), 
                              onPressed: (){
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                              )
                            ),
                          ),

                          SizedBox(height: 30,),

                          FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                            onPressed: () async{
                              if(validateAndSave()){

                                setState(() {
                                  isApiCallProcess = true;
                                });
                                // await apiService.loginCustomer(username, password).then(
                                //   (ret){
                                //     if(ret != null ){
                                      
                                //         setState(() {
                                //   isApiCallProcess = false;
                                // });
                                //      FormHelper.showMessage(
                                //        context, 
                                //        "WooCommerce App",
                                //         "Login successful",
                                //         "OK",
                                //          (){Navigator.of(context).pop();
                                //          }

                                //          );
                                //     } else{
                                      
                                //      FormHelper.showMessage(
                                //        context, 
                                //        "WooCommerce App",
                                //         "Invalid login",
                                //         "OK",
                                //          (){Navigator.of(context).pop();
                                //          }

                                //          );
                                //     }
                                //   }
                                //   );

                              }
                            }, 
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                            shape: StadiumBorder(),
                            ),
                            SizedBox(height: 15,)

                      ],
                    )
                    ),
                )
              ],
            )
          ],
        ),
      ),
    );

  }

      bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}