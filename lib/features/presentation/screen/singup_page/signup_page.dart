import 'package:expenso_app/core/ui/costom_widget/aap_rounded_btn.dart';
import 'package:expenso_app/core/ui/costom_widget/ui.helper.dart';
import 'package:expenso_app/features/auth/bloc/user_bloc.dart';
import 'package:expenso_app/features/auth/bloc/user_event.dart';
import 'package:expenso_app/features/auth/bloc/user_state.dart';
import 'package:expenso_app/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget{

  bool isPasswordVisible=false;
  bool confirmIsPasswordVisible=false;
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var mobController=TextEditingController();
  var emailController =TextEditingController();
  var confirmPasswordController=TextEditingController();

  bool isCreatingAccount=false;

  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter,colors: [
            Colors.orange.shade900,
            Colors.orange.shade800,
            Colors.orange.shade400
          ])
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text('              Sing In',style:  TextStyle(color: Colors.white,fontSize: 35),),
                Text('Create a New Account Here..',style: TextStyle(color: Colors.white,fontSize: 20),)
              ],
            ),),
            SizedBox(
              height: 11,
            ),
            Expanded(child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
              ),
              child: Padding(padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key:  formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      TextFormField(
                        validator: (value){
                          if (value ==null || value.isEmpty){
                            return 'Please Enter your name';
                          }else{
                            return null;
                          }
                        },
                        controller: nameController,
                        decoration: myFileDecoration(hint: 'Enter Your Name', label: 'Name'),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      TextFormField(
                        validator: (value) {
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value ?? "");

                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          } else if (!emailValid) {
                            return "Please enter a valid email";
                          } else {
                            return null;
                          }
                        },
                        controller:  emailController,
                        decoration: myFileDecoration(hint: 'Enter your Email..', label: 'Email',),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      TextFormField(
                        validator: (value){
                          if (value ==null || value.isEmpty){
                            return 'Please enter your Number here..';
                          }
                          if(value.length!=10){
                            return 'Please enter a valid number.';
                          }
                          else{
                            return null;
                          }
                        },
                        controller: mobController,
                        keyboardType: TextInputType.number,
                        decoration: myFileDecoration(hint: 'Enter Your Phone No..', label: 'Number'),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      StatefulBuilder(
                        builder: (context,ss) {
                          return TextFormField(
                            validator: (value) {
                              final bool passValid = RegExp(
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                              ).hasMatch(value ?? "");

                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              } else if (!passValid) {
                                return "Please enter a valid password";
                              } else {
                                return null;
                              }
                            },
                            controller: passwordController,
                            obscureText: !isPasswordVisible,
                            decoration: myFileDecoration(hint: 'Password', label: 'Enter you password..',
                                isPassword: true,
                                isPasswordVisible: isPasswordVisible,
                                onPasswordVisibilityTap: (){
                                  isPasswordVisible=!isPasswordVisible;
                                  ss(() {

                                  });
                                }),
                          );
                        }
                      ),
                      //Text('Minimum 8 chars, include letters & numbers'),
                      SizedBox(
                        height: 11,
                      ),
                      StatefulBuilder(
                          builder: (context,ss) {
                            return TextFormField(
                              validator: (value){
                                if (value==null || value.isEmpty){
                                  return 'Please Re-type Your Password';
                                }else if(passwordController.text != value){
                                  return 'Password Can\'t match';
                                }else{
                                  return null;
                                }
                              },
                              controller: confirmPasswordController,
                              obscureText: !confirmIsPasswordVisible,
                              decoration: myFileDecoration(hint: 'Please Re-type Password', label: 'Re-type Password',
                                  isPassword: true,
                                  isPasswordVisible:confirmIsPasswordVisible,
                                  onPasswordVisibilityTap: (){
                                    confirmIsPasswordVisible=!confirmIsPasswordVisible;
                                    ss(() {

                                    });
                                  }),
                            );
                          }
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      BlocConsumer<UserBloc,UserState>(
                        listener: (context,state) {
                          if(state is UserLoadingState){
                            isCreatingAccount=true;
                          }

                          if(state is UserFailureState){
                            isCreatingAccount=false;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg),backgroundColor: Colors.red,));
                          }

                          if(state is UserSuccessSate){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your Account Creating is Successfully'),backgroundColor: Colors.green,));
                              Navigator.pop(context);
                          }

                        },
                        builder: (context,state){
                          return AppRoundedButton(onTap: (){
                          if(formKey.currentState!.validate()){
                              context.read<UserBloc>().add(RegisterUserEvent(mUser: UserModel(
                                  name: nameController.text,
                                  email:emailController.text,
                                  mobNo: mobController.text,
                                  pass: passwordController.text))
                              );
                          }
                          }, title:isCreatingAccount ? 'Creating Account...' : 'SingIn');
                        },
                      ),
                      SizedBox(
                        height:25,
                      ),
                      Center(
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child:RichText(text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account?   ',style: TextStyle(
                                  color: Colors.black
                              ),
                              ),
                              TextSpan(
                                text: 'Login Now..',style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold
                              )
                              )
                            ]
                          ),) ,
                        ),
                      )
                    ],
                  ),
                ),
              ),),
            ))
          ],
        ),
      ),
    );
  }
}