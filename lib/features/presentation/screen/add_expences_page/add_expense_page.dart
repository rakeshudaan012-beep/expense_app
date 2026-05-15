import 'package:expenso_app/core/constant/app_constants.dart';
import 'package:expenso_app/core/ui/costom_widget/ui.helper.dart';
import 'package:expenso_app/features/presentation/bloc/expanse_bloc.dart';
import 'package:expenso_app/features/presentation/bloc/expanse_event.dart';
import 'package:expenso_app/features/presentation/bloc/expense_state.dart';
import 'package:expenso_app/features/presentation/model/expenso_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});


  @override
  State<AddExpensePage> createState() => AddExpensePageState();
}

class AddExpensePageState extends State<AddExpensePage> {
  TextEditingController titleController =TextEditingController();

  TextEditingController descController=TextEditingController();

  TextEditingController amController =TextEditingController();

  String selectedType='Debit';
  List<String> dropManu=['Debit','Credit'];
  GlobalKey<FormState> addPage=GlobalKey<FormState>();
  int selectedCatIndex=-1;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateTime? selectedDateTime;
  DateFormat df=DateFormat();
  DateFormat tf=DateFormat.jms();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Add Expense'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        foregroundColor:Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding:EdgeInsets.only(right: 10),
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon:Text('Cancel',style: TextStyle(color:Colors.white,fontSize: 20),)),
          )
        ],
      ),body: Form(
      key: addPage,
        child: Padding(
          padding:EdgeInsets.only(left: 11,top: 50,right: 11),
          child: Column(
            children: [
              TextFormField(
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'Add Your Expense';
                  }else{
                    return null;
                  }
                },
                  controller: titleController,
                decoration: myFileDecoration(hint: 'Enter your title ', label: 'Title'),
              ),
              SizedBox(
                height: 11,
              ),
              TextFormField(
                validator:(value){
                  if(value==null || value.isEmpty){
                    return 'Enter Your Expense Description';
                  }else{
                    return null;
                  }
                },
                controller: descController,
                decoration: myFileDecoration(hint: 'Enter your desc', label: 'Desc'),
              ),
              SizedBox(
                height: 11,
              ),
              TextFormField(
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'Please Enter Your Expanse Amount';
                  }else
                    return null;
                },
                keyboardType: TextInputType.number,
                controller: amController,
                decoration: myFileDecoration(hint: 'Enter your Amount', label: 'Amount'),
              ),
              SizedBox(
                height: 11,
              ),

              /*DropdownButton(
              value:selectedType,items: [
                DropdownMenuItem(value: 'Debit',child: Text('Debit')),
                DropdownMenuItem(value: 'Credit',child: Text('Credit'))
              ], onChanged: (value){
                selectedType=value!;
                  setState(() {

                  });
              }),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity,56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(11),bottomLeft: Radius.circular(11))
                        )
                      ),
                    onPressed: (){
                        showModalBottomSheet(context: context, builder: (context){
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20,left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Category',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Icon(Icons.cancel,size: 30,color: Colors.black,))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
                                    (crossAxisCount:4,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10
                                   ), itemCount: AppConstant.allCat.length
                                      ,itemBuilder: (_,index){
                                          return InkWell(
                                            onTap: (){
                                              selectedCatIndex=index;
                                              setState(() {

                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding:EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image.asset(AppConstant.allCat[index].imPath,width: 50,height: 50,)
                                                ],
                                              ),
                                            ),
                                          );
                                      }
                                ),
                              )
                            ],
                          );
                        });


                    }, child: selectedCatIndex<0 ? Align(alignment: Alignment.centerLeft,child: Text('Select Category',style: TextStyle(color: Colors.black,),)):Row(
                      children: [
                          Image.asset(AppConstant.allCat[selectedCatIndex].imPath,width: 50,height: 40,),
                        Text('    -     ${(AppConstant.allCat[selectedCatIndex].title)}',style: TextStyle(fontSize: 20),)
                      ],
                    )),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ///Drop Down Menu....///
                  DropdownMenu(
                    //initialSelection: selectedType,
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(11),bottomRight: Radius.circular(11))
                      )
                    ),
                    onSelected: (value){
                      selectedType=value!;
                      setState(() {

                      });
                    },
                  label: Text('Type'),dropdownMenuEntries: dropManu.map((eachType){
                    return DropdownMenuEntry(value: eachType, label: eachType);
                  }).toList()),
                ],
              ),
              SizedBox(
                height: 11,
              ),
             ///Set Date....///
              StatefulBuilder(
                builder: (context,ss) {
                  return OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity,56),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(11),bottomLeft: Radius.circular(11))
                          )
                      ),
                      onPressed: () async{
                          selectedDate  = await showDatePicker(context: context,
                              firstDate: DateTime.now().subtract(Duration(days:365)),
                              lastDate:DateTime.now());

                          selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
                          );

                          DateTime userDate=selectedDate??DateTime.now();
                          TimeOfDay userTime= selectedTime?? TimeOfDay.now();
                          DateTime selectedDateTime=DateTime(userDate.year, userDate.month,userDate.day,userTime.hour,userTime.minute);
                          ss((){
                          });
                      },child:Text("${df.format(selectedDateTime ?? DateTime.now())}")
                  );
                }
              ),
              SizedBox(
                height: 11,
              ),

              ///Set Time ....///
              /*StatefulBuilder(
                  builder: (context,ss) {
                    return OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity,56),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(11),bottomLeft: Radius.circular(11))
                            )
                        ),
                        onPressed: () async{
                          selectedTime? = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute))) as DateTime?;
                          ss((){

                          });
                        }, child:Text((selectedTime?? TimeOfDay.now()).format(context)),
                    );
                  }
              ),*/

              SizedBox(
                height: 11,
              ),
              BlocListener<ExpenseBloc,ExpenseState>(
                  listener: (context,state) {
                  if(state is ExpenseErrorState){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg),backgroundColor: Colors.red));

                  }
                    if(state is ExpenseLoadedState){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Added'),backgroundColor: Colors.green,));
                    Navigator.pop(context);
                  }
                },child: ElevatedButton(style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                        backgroundColor: Colors.purpleAccent.shade400,
                        foregroundColor: Colors.white
                  ),
                        onPressed: (){
                          if(addPage.currentState!.validate()){
                            context.read<ExpenseBloc>().add(AddExpenseEvent(newExp:ExpenseModel(
                                title: titleController.text,
                                desc: descController.text,
                                amt: double.parse(amController.text),
                                bal: 0.0,
                                catId: AppConstant.allCat[selectedCatIndex].id!,
                                createdAt: (selectedDateTime??DateTime.now()).millisecondsSinceEpoch,
                                expType: selectedType=='Debit'? 1:2)
                            )
                            );
                          }
                        }, child:Text('Add Expense') )

              ),
            ],
          ),
        ),
      ),
    );
  }
}
