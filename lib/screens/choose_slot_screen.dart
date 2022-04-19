import 'package:flutter/material.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/data/slot.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChooseSlotScreen extends StatefulWidget {

 final bool p1;
 final  bool p2;
 final  bool p3;
 final  bool p4;
 final bool p5;

   ChooseSlotScreen({Key key,  this.p1, this.p2, this.p3, this.p4, this.p5}) : super(key: key);


  @override
  _ChooseSlotScreenState createState() => _ChooseSlotScreenState();
}


class _ChooseSlotScreenState extends State<ChooseSlotScreen> {


  List list = [];
  int index = 0;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSlotList();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.marginSize, right: Dimensions.marginSize, top:
                      Dimensions
                          .marginSize),
                      child: GestureDetector(
                        child: Icon(
                          Icons.arrow_back,
                          color: CustomColor.primaryColor,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize * 2,),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: Dimensions.marginSize, right: Dimensions.marginSize),
                      child: Text(
                      'Estado Actual del parqueo', // Strings.chooseYourSlot,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.extraLargeTextSize *1.3//* 1.5
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize * 2,),

                    //SI TUVIERA MAS DE UN PISO PODRIA SERVIR.......
                   /* Padding(   //
                      padding: const EdgeInsets.only(
                          left: Dimensions.marginSize, right: Dimensions.marginSize),
                      child: Container(
                        height: 20.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Radio(
                              value: SingingCharacter.firstFloor,
                              toggleable: true,
                              autofocus: true,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                  index = 0;
                                });
                              },
                            ),
                            Text(
                              'Primer piso', //Strings.firstFloor,
                              style: CustomStyle.textStyle,
                            ),
                            SizedBox(width: Dimensions.widthSize,),
                            Radio(
                              value: SingingCharacter.secondFloor,
                              toggleable: true,
                              autofocus: true,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                  index = 1;
                                });
                              },
                            ),
                            Text(
                               'Segundo parcial' ,// Strings.secondFloor,
                              style: CustomStyle.textStyle,
                            ),
                            SizedBox(width: Dimensions.widthSize,),
                            Radio(
                              value: SingingCharacter.thirdFloor,
                              toggleable: true,
                              autofocus: true,
                              groupValue: _character,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  _character = value;
                                  index = 2;
                                });
                              },
                            ),
                            Text(
                             'tercer piso',// Strings.thirdFloor,
                              style: CustomStyle.textStyle,
                            ),
                            SizedBox(width: Dimensions.widthSize,),
                          ],
                        ),
                      ),
                    ),*/
                   // SizedBox(height: Dimensions.heightSize * 2,),
                    floorWidget(context, index)
                  ],
                ),
              ),
              Positioned(
                bottom: Dimensions.heightSize,
                left: Dimensions.marginSize,
                right: Dimensions.marginSize,
                child: GestureDetector(
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: CustomColor.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                    ),
                    child: Center(
                      child: Text(
                        'Actualizar',  //'${Strings.proceedWithSlot.toUpperCase()}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.largeTextSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    /*
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        ParkingDirectionScreen()));

                        */
                  },
                ),
              )
            ],
          ),
        ),
      ),
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
   /* switch (index){
      case 0:
        return firstFloor();
      case 1:
        return secondFloor();
      case 2:
        return thirdFloor();
    }*/

      return firstFloor();
  }

  Widget firstFloor(){
    return Column(
      children: [
        /*Text(
        'Primer piso',//   Strings.firstFloor,
          style: TextStyle(
              fontSize: Dimensions.extraLargeTextSize,
              color: CustomColor.primaryColor
          ),
        ),*/
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
                        color: widget.p1 ? list[index] ? CustomColor.greenLightColor :
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
                    if (widget.p1) {
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
                        color: widget.p2 ? list[index] ? CustomColor.greenLightColor :
                        CustomColor.greenLightColor:
                        CustomColor.accentColor,
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                    ),
                    child: Center(
                      child: Text(
                        'P2',
                        style: TextStyle(
                            fontSize: Dimensions.extraLargeTextSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (widget.p2) {
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
                        color: widget.p3 ? list[index] ? CustomColor.greenLightColor :
                        CustomColor.greenLightColor:
                        CustomColor.accentColor,
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                    ),
                    child: Center(
                      child: Text(
                        'P3',
                        style: TextStyle(
                            fontSize: Dimensions.extraLargeTextSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (widget.p3) {
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
                        color: widget.p4 ? list[index] ? CustomColor.greenLightColor :
                        CustomColor.greenLightColor:
                        CustomColor.accentColor,
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                    ),
                    child: Center(
                      child: Text(
                        'P4',
                        style: TextStyle(
                            fontSize: Dimensions.extraLargeTextSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (widget.p4) {
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
                        color: widget.p5 ? list[index] ? CustomColor.greenLightColor :
                        CustomColor.greenLightColor:
                        CustomColor.accentColor,
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                    ),
                    child: Center(
                      child: Text(
                        'P5',
                        style: TextStyle(
                            fontSize: Dimensions.extraLargeTextSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (widget.p5) {
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
            
            
            /*List.generate(SlotList
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
                      //  color: slot.isAvailable ? list[index] ? Colors.white :
                        color: slot.isAvailable ? list[index] ? CustomColor.greenLightColor :
                        CustomColor.greenLightColor:
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
                    if (slot.isAvailable) {
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
              );
            }),
            
            */
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