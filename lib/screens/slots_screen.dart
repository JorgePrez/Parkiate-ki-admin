import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:parkline/models/bio.dart';

import 'package:flutter/material.dart';
import 'package:parkline/models/servicioadminimagen.dart';
import 'package:parkline/screens/parking_code_screen_qr2.dart';

import 'package:parkline/utils/dimensions.dart';
import 'package:parkline/utils/custom_style.dart';
import 'package:parkline/utils/colors.dart';
import 'package:parkline/models/servicioadmin.dart';

String q1 = '1. FullName';

String q2 = '2. Date of Birth';

String q3 = '3. Country';

String q4 = '4. City';

final FirebaseDatabase database = FirebaseDatabase.instance;

class EstadoParqueo extends StatefulWidget {
  final String id_parqueo_firebase;

  EstadoParqueo({
    Key key,
    this.id_parqueo_firebase,
  }) : super(key: key);

  @override
  _EstadoParqueoState createState() => _EstadoParqueoState();
}

class _EstadoParqueoState extends State<EstadoParqueo> {
  final TextStyle _textStyle =
      TextStyle(color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold);

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Bio bio;

  //Ya que fue creada la instancia arriba ahora necesito la referencia

  DatabaseReference databaseReference;

  List<Bio> bioList;

  @override
  void initState() {
    super.initState();

    String referencia = "Parking_Status/" + widget.id_parqueo_firebase;

    bioList = List();
    bio = Bio('', false, '', '');
    databaseReference = database.reference().child(referencia);

    //other     databaseReference = database.reference().child('Football_Team_Bio ');

    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  void _onEntryAdded(Event event) async {
    setState(() {
      bioList.add(Bio.fromSnapshot((event.snapshot)));
    });
  }

  void _onEntryChanged(Event event) async {
    var oldEntry = bioList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      bioList[bioList.indexOf(oldEntry)] = Bio.fromSnapshot((event.snapshot));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize,
                      top: Dimensions.marginSize),
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
                SizedBox(
                  height: Dimensions.heightSize, //*2
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: Text(
                    'Desliza la pantalla para ver los demás espacios',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.extraLargeTextSize),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Flexible(
                    child: FirebaseAnimatedList(
                        query: databaseReference,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          //   bioList.add(Bio.fromSnapshot((snapshot)));

                          /* databaseReference.onChildAdded.listen(_onEntryAdded);
                          databaseReference.onChildChanged
                              .listen(_onEntryChanged);*/

                          bool condicion;

                          String espacio = "espacio disponible para reservas";

                          String espacio2 = "espacio normal";

                          if (bioList[index].reservas == 'S') {
                            condicion = true;
                          } else {
                            condicion = false;
                          }

                          String estadoString;

                          if (bioList[index].estado) {
                            estadoString = ' (Libre)';
                          } else {
                            estadoString = ' (Ocupado)';
                          }

                          return Column(
                            children: [
                              ListTile(
                                leading: InkWell(
                                    child: /* CircleAvatar(
                                    backgroundColor: Colors.pink,
                                    backgroundImage:
                                        AssetImage('assets/auto3.png'),
                                  ),*/
                                        CircleAvatar(
                                            radius: (52),
                                            backgroundColor:
                                                bioList[index].estado
                                                    ? Colors.green
                                                    : Colors.red,
                                            //Colors.green,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child:
                                                  Image.asset("assets/p.png"),
                                            ))),
                                title: Center(
                                  child: Text(
                                    bioList[index].codigo + estadoString,
                                    //  snapshot.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: bioList[index].estado
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                                subtitle: Container(
                                    height: 30,
                                    width: 120, //,70, //60
                                    decoration: BoxDecoration(
                                        color: condicion
                                            ? Color(0xFFFFDD7A)
                                            : Color(0xFF8EFF9D),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.radius * 1))), //0.5
                                    child: Center(
                                        child: Text(
                                      condicion ? espacio : espacio2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.smallTextSize,
                                      ),
                                    ))),

                                /*Text(
                                  bioList[index].estado.toString(),
                                  //snapshot.toString(),

                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),*/
                                /*    trailing: IconButton(
                                  iconSize: 20,
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: CustomColor.primaryColor,
                                  ),
                                  onPressed: () {
                                    /*
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MaterialApp(
                                        debugShowCheckedModeBanner: false,
                                        home: Scaffold(
                                          appBar: AppBar(
                                            backgroundColor:
                                                Colors.deepOrangeAccent,
                                            leading: IconButton(
                                                icon: Icon(
                                                    (Icons.arrow_back_ios)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                }),
                                            centerTitle: true,
                                            title: Text(
                                              bioList[index].codigo +
                                                  ' - ' +
                                                  bioList[index]
                                                      .estado
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          body: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: SingleChildScrollView(
                                                child: Form(
                                                    key: formkey,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              q1,
                                                              style: _textStyle,
                                                            )
                                                          ],
                                                        ),
                                                        TextFormField(
                                                          initialValue:
                                                              bioList[index]
                                                                  .codigo,
                                                          onSaved: (newValue) =>
                                                              bio.codigo =
                                                                  newValue,
                                                          validator: (value) =>
                                                              value.isEmpty
                                                                  ? 'This form can\t be empty'
                                                                  : null,
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              q2,
                                                              style: _textStyle,
                                                            )
                                                          ],
                                                        ),
                                                        TextFormField(
                                                          initialValue:
                                                              bioList[index]
                                                                  .id_slot,
                                                          onSaved: (newValue) => bio
                                                              .estado = newValue
                                                                  .toLowerCase() ==
                                                              'true',
                                                          validator: (value) =>
                                                              value.isEmpty
                                                                  ? 'This form can\t be empty'
                                                                  : null,
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              q3,
                                                              style: _textStyle,
                                                            )
                                                          ],
                                                        ),
                                                        TextFormField(
                                                          initialValue:
                                                              bioList[index]
                                                                  .id_slot,
                                                          onSaved: (newValue) =>
                                                              bio.id_slot =
                                                                  newValue,
                                                          validator: (value) =>
                                                              value.isEmpty
                                                                  ? 'This form can\t be empty'
                                                                  : null,
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              q4,
                                                              style: _textStyle,
                                                            )
                                                          ],
                                                        ),
                                                        TextFormField(
                                                          initialValue:
                                                              bioList[index]
                                                                  .reservas,
                                                          onSaved: (newValue) =>
                                                              bio.reservas =
                                                                  newValue,
                                                          validator: (value) =>
                                                              value.isEmpty
                                                                  ? 'This form can\t be empty'
                                                                  : null,
                                                        ),
                                                        SizedBox(
                                                          height: 50,
                                                        ),
                                                        RaisedButton(
                                                            color: Colors
                                                                .deepOrangeAccent,
                                                            onPressed: () {
                                                              confirmUpdate(
                                                                  snapshot); // update form
                                                            },
                                                            child: Text(
                                                              'Update Form',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            ))
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }));*/
                                  },
                                ),*/
                              ),
                              Divider(
                                color: Colors.blue,
                              )
                            ],
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    final FormState form = formkey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      databaseReference.push().set(bio.toJoson());

      submitSuccesful();
    }
  }

  void submitSuccesful() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Successfully Submitted'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('Dismiss'))
            ],
          );
        });
  }

  void confirmUpdate(DataSnapshot snapshot) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Update'),
            content: Text('Do you want to update this form?'),
            actions: [
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                  handleUpdate(snapshot);
                },
              ),
              Text(
                'wewanttoblankthe',
                style: TextStyle(color: Colors.white),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
  }

  void handleUpdate(DataSnapshot snapshot) {
    final FormState form = formkey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      databaseReference.push().set(bio.toJoson());
      updateSuccessfull(snapshot);
    }
  }

  void updateSuccessfull(DataSnapshot snapshot) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Successfully Update'),
            actions: [
              FlatButton(
                  onPressed: () {
                    databaseReference.child(snapshot.key).remove();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('Dismiss'))
            ],
          );
        });
  }
}
