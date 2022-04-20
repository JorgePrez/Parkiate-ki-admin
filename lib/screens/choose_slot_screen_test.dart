import 'package:flutter/material.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/data/slot.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class ChooseSlotScreenTest extends StatefulWidget {


   ChooseSlotScreenTest({Key key,  
   
   /*this.p1, this.p2, this.p3, this.p4, this.p5
   */}) : super(key: key);


  @override
  _ChooseSlotScreenTestState createState() => _ChooseSlotScreenTestState();
}


class _ChooseSlotScreenTestState extends State<ChooseSlotScreenTest> {


  List list = [];
  int index = 0;

  bool estado = false;


  DatabaseReference _dhtRef = FirebaseDatabase.instance.reference().child('/Parking_Status/-Mq73KmXyn-fx7tlnIQn/-N-yzFejDQpGWS6KccmN');



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   // getSlotList();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //  backgroundColor: Colors.white,
        body: StreamBuilder(
          
          stream: _dhtRef.onValue,
          
        
          builder: (context,snapshot){


   if(snapshot.hasData &&
    !snapshot.hasError && 
    snapshot.data.value!=null){



      print("snapshot data ${snapshot.data.snapshot.value.toString()} ");

          }

          else{


          }

         return Container();

          }),

  
        
      
        
        
   
    );
  }

  void getSlotList() {
    int data = SlotList.list().length;
    for(int i = 0; i < data; i++){
      Slot slot = SlotList.list()[i];
      list.add(slot.isAvailable);

      print('list: '+list.toString());
    }
  }

  // ignore: missing_return
  Widget floorWidget(BuildContext context, int index){


      return firstFloor();
  }

  Widget firstFloor(){
    return Column(
      children: [
  
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: GridView.count(
            crossAxisCount: 3,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget> [

               Padding(
                padding: const EdgeInsets.all(20.0),
                child: FlatButton(
                  //color: isSelected ? Colors.blue : Colors.red,
                  splashColor: Colors.blue.withOpacity(0.5),
                  child: Container(
                    height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                      //  color: slot.isAvailable ? list[index] ? Colors.white :
                        color: estado ? list[index] ? CustomColor.greenLightColor :
                        CustomColor.greenLightColor:
                        CustomColor.accentColor,
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                    ),
                    child: Center(
                      child: Text(
                        'P1',
                        style: TextStyle(
                            fontSize: Dimensions.extraLargeTextSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (estado) {
                    //  print('already booked');
                      Fluttertoast.showToast(msg: 'Espacio Libre',//Strings.slotIsNotAvailable,
                          backgroundColor: Colors.green, textColor: Colors.white);
                    } else {
                      /*setState(() {
                        //list[index] = !list[index];
                      });*/
                       Fluttertoast.showToast(msg: 'Espacio Ocupado',//Strings.slotIsNotAvailable,
                          backgroundColor: Colors.red, textColor: Colors.white);
                    //  print('you can book this slot: ' + list.toString());
                    }
                  },
                ),
              ),







            ]
            
          
            
          ),
        ),
      ],
    );
  }
  Widget secondFloor(){
    return Column(
      children: [
        Text(
          'Segundo parqueo',//Strings.secondFloor,
          style: TextStyle(
              fontSize: Dimensions.extraLargeTextSize,
              color: CustomColor.primaryColor
          ),
        ),
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: GridView.count(
            crossAxisCount: 3,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(SlotList
                .list()
                .length, (index) {
              Slot slot = SlotList.list()[index];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: FlatButton(
                  //color: isSelected ? Colors.blue : Colors.red,
                  splashColor: Colors.blue.withOpacity(0.5),
                  child: Container(
                    height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                        color: slot.isAvailable ? list[index] ? Colors.white :
                        CustomColor.primaryColor:
                        CustomColor.accentColor,
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                    ),
                    child: Center(
                      child: Text(
                        '${slot.name}',
                        style: TextStyle(
                            fontSize: Dimensions.extraLargeTextSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (!slot.isAvailable) {
                      print('already booked');
                      Fluttertoast.showToast(msg:  'Espacio no disponible',//Strings.slotIsNotAvailable,
                          backgroundColor: Colors.red, textColor: Colors.white);
                    } else {
                      setState(() {
                        list[index] = !list[index];
                      });
                      print('you can book this slot: ' + list.toString());
                    }
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
  Widget thirdFloor(){
    return Column(
      children: [
        Text(
           'tercer piso',// Strings.thirdFloor,
          style: TextStyle(
            fontSize: Dimensions.extraLargeTextSize,
            color: CustomColor.primaryColor
          ),
        ),
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: GridView.count(
            crossAxisCount: 3,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(SlotList
                .list()
                .length, (index) {
              Slot slot = SlotList.list()[index];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: FlatButton(
                  //color: isSelected ? Colors.blue : Colors.red,
                  splashColor: Colors.blue.withOpacity(0.5),
                  child: Container(
                    height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                        color: slot.isAvailable ? list[index] ? Colors.white :
                        CustomColor.primaryColor:
                        CustomColor.accentColor,
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                    ),
                    child: Center(
                      child: Text(
                        '${slot.name}',
                        style: TextStyle(
                            fontSize: Dimensions.extraLargeTextSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (!slot.isAvailable) {
                      print('already booked');
                      Fluttertoast.showToast(msg:  'Parqueo no disponible',//Strings.slotIsNotAvailable,
                          backgroundColor: Colors.red, textColor: Colors.white);
                    } else {
                      setState(() {
                        list[index] = !list[index];
                      });
                      print('you can book this slot: ' + list.toString());
                    }
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}