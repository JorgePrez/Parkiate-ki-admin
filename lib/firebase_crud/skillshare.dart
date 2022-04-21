import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'bio.dart';

String q1 = '1. FullName';

String q2 = '2. Date of Birth';

String q3 = '3. Country';

String q4 = '4. City';

final FirebaseDatabase database = FirebaseDatabase.instance;

class SkillShare extends StatefulWidget {
  final String id_parqueo_firebase;

  SkillShare({
    Key key,
    this.id_parqueo_firebase,
  }) : super(key: key);

  @override
  _SkillShareState createState() => _SkillShareState();
}

class _SkillShareState extends State<SkillShare> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text(
          'SkillShare App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.pink[20],
              image: DecorationImage(
                  image: AssetImage('assets/skillimage.png'),
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.07), BlendMode.dstATop),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add nex data',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 30,
                    color: Colors.pink,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: Scaffold(
                            appBar: AppBar(
                                backgroundColor: Colors.pink,
                                leading: IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                title: Text(
                                  'New Data',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                centerTitle: true),
                            body: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.pink[20],
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/skillimage.png'),
                                        colorFilter: new ColorFilter.mode(
                                            Colors.black.withOpacity(0.07),
                                            BlendMode.dstATop),
                                        fit: BoxFit.cover)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Flexible(
                                          flex: 0,
                                          child: Center(
                                            child: Form(
                                                key: formkey,
                                                child: Flex(
                                                  direction: Axis.vertical,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          q1,
                                                          style: _textStyle,
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      initialValue: '',
                                                      validator: (value) => value
                                                              .isEmpty
                                                          ? 'This field cant be empty'
                                                          : null,
                                                      onSaved: (newValue) =>
                                                          bio.codigo = newValue,
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          q2,
                                                          style: _textStyle,
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      initialValue: '',
                                                      validator: (value) => value
                                                              .isEmpty
                                                          ? 'This field cant be empty'
                                                          : null,
                                                      onSaved: (newValue) => bio
                                                          .estado = newValue
                                                              .toLowerCase() ==
                                                          'true',
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          q3,
                                                          style: _textStyle,
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      initialValue: '',
                                                      validator: (value) => value
                                                              .isEmpty
                                                          ? 'This field cant be empty'
                                                          : null,
                                                      onSaved: (newValue) => bio
                                                          .id_slot = newValue,
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          q4,
                                                          style: _textStyle,
                                                        ),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      initialValue: '',
                                                      validator: (value) => value
                                                              .isEmpty
                                                          ? 'This field cant be empty'
                                                          : null,
                                                      onSaved: (newValue) => bio
                                                          .reservas = newValue,
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    RaisedButton(
                                                        color: Colors.pink,
                                                        onPressed: () {
                                                          _formConfirmation();
                                                        },
                                                        child: Text(
                                                          'Submit',
                                                          style: TextStyle(
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ))
                                                  ],
                                                )),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Recently Added',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SkillShare()));
                    },
                    iconSize: 30,
                    color: Colors.pink,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Flexible(
                  child: FirebaseAnimatedList(
                      query: databaseReference,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        //   bioList.add(Bio.fromSnapshot((snapshot)));

                        /* databaseReference.onChildAdded.listen(_onEntryAdded);
                        databaseReference.onChildChanged
                            .listen(_onEntryChanged);*/

                        return Column(
                          children: [
                            ListTile(
                              leading: InkWell(
                                onLongPress: () {
                                  delete(snapshot);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.pink,
                                ),
                              ),
                              title: Text(
                                bioList[index].codigo,
                                //  snapshot.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.blue,
                                ),
                              ),
                              subtitle: Text(
                                bioList[index].estado.toString(),
                                //snapshot.toString(),

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              trailing: IconButton(
                                iconSize: 20,
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.pink,
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MaterialApp(
                                      debugShowCheckedModeBanner: false,
                                      home: Scaffold(
                                        appBar: AppBar(
                                          backgroundColor:
                                              Colors.deepOrangeAccent,
                                          leading: IconButton(
                                              icon:
                                                  Icon((Icons.arrow_back_ios)),
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
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.07),
                                                            BlendMode.dstATop),
                                                    image: AssetImage(
                                                        'assets/skillimage.png'),
                                                    fit: BoxFit.cover)),
                                            child: SingleChildScrollView(
                                              child: Form(
                                                  key: formkey,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
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
                                                        validator: (value) => value
                                                                .isEmpty
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
                                                        validator: (value) => value
                                                                .isEmpty
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
                                                        validator: (value) => value
                                                                .isEmpty
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
                                                        validator: (value) => value
                                                                .isEmpty
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
                                  }));
                                },
                              ),
                            ),
                            Divider()
                          ],
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }

  void _formConfirmation() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Submission'),
            content: Text('Do you want to submit this form'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    submit();
                  },
                  child: Text('yes')),
              /* Spacer(
                flex: 5,
              ),*/
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
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

  void delete(DataSnapshot snapshot) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Delete'),
            content: Text('Do you want to delete this form?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    databaseReference.child(snapshot.key).remove();
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
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
