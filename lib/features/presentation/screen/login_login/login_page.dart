import 'package:expenso_app/app_routes.dart';
import 'package:expenso_app/core/ui/costom_widget/aap_rounded_btn.dart';
import 'package:expenso_app/core/ui/costom_widget/ui.helper.dart';
import 'package:expenso_app/features/auth/bloc/user_bloc.dart';
import 'package:expenso_app/features/auth/bloc/user_event.dart';
import 'package:expenso_app/features/auth/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  var emailController =TextEditingController();
  var passwordController=TextEditingController();
  bool isPasswordVisible=false;
  bool isLoading =false;
  bool isLogin=true;

  GlobalKey<FormState> mkey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange.shade900,
            Colors.orange.shade800,
            Colors.orange.shade400
          ],)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            SizedBox(height: 80,),
            Padding(padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Login',style: TextStyle(color: Colors.white,fontSize: 40)),
                  Text('Welcome Back',style: TextStyle(color: Colors.white,fontSize: 25))
                ],
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Expanded(
                child:Container(
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
              ),
              child: Padding(padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: mkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      TextFormField(
                        controller:  emailController,
                        decoration: myFileDecoration(hint: 'Enter your Email..', label: 'Email',),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password ";
                        } else {
                          return null;
                        }
                      },
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: myFileDecoration(hint: 'Enter you password..', label: 'Password',
                          isPassword: true,
                          isPasswordVisible: isPasswordVisible,
                          onPasswordVisibilityTap: (){
                            isPasswordVisible=!isPasswordVisible;
                            setState(() {

                            });
                          }),
                    ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<UserBloc,UserState>(
                        listenWhen: (a,b){
                            return isLogin;
                        },
                        buildWhen: (a,b){
                          return isLogin;
                        },
                        listener:(context,state){
                          if(state is UserLoadingState) {
                            isLoading = true;
                          }
                          if (state is UserFailureState){
                            isLoading=false;

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg),backgroundColor: Colors.red,));
                          }

                          if (state is UserSuccessSate){
                            isLoading=false;

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Log-in is successfully'),backgroundColor: Colors.green,));
                            Navigator.pushReplacementNamed(context, AppRoute.dashboard);
                          }
                        },
                        builder: (context,state) {
                          return AppRoundedButton(onTap: (){
                            if(mkey.currentState!.validate()){
                              isLogin=true;
                              context.read<UserBloc>()
                                  .add(LoginUserEvent(
                                  email: emailController.text,
                                  pass:passwordController.text
                              ));
                               // Navigator.pushReplacementNamed(context, AppRoute.dashboard);
                            }
                          }, title:'Login',myChild: isLoading ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Text('Loading',style:  TextStyle(
                                color:Colors.white
                              ),)
                            ],
                          ) : null ,);
                        }
                      ),

                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: (){
                          isLogin=false;
                          Navigator.pushNamed(context, AppRoute.signup);
                        },
                        child: RichText(text:TextSpan(
                          children:[
                            TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                                text: "Create now..",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                            )
                          ]
                        )),
                      ),
                    ],
                    ),
                ),
              ),
              ),
              )
            )
          ],
        ),
      ),
    );
  }
}
