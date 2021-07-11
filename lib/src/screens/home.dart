import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:new_app/src/screens/add_address.dart';
import 'package:new_app/src/widgets/SideDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';


class Home extends StatefulWidget {
  const Home({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late User _user;

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Patta'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAdd()),
          ).then((value) {
            print('calling set state');
            setState(() {});
          });
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Column(
                        children: [
                          ListTile(
                            tileColor: Colors.white12,
                            title: Text(
                              "${data['title']}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Container(
                              child: ExpandableText("${data['address']}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white70),
                                  expandText: '',
                                  expandOnTextTap: true,
                                  collapseOnTextTap: true),
                            ),
                            trailing: Container(
                              width: 60,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.directions,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () async {
                                      return ref.doc().delete().then((value) {
                                        print('User Deleted');
                                        setState(() {});
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  /*Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        "$index) ${data['title']}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Icon(
                                              Icons.directions,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Delete();
                                              setState(() {});
                                              Navigator.of(context).pop(
                                                  Fluttertoast.showToast(
                                                      msg: 'Delete',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      fontSize: 16.0));
                                            },
                                            child: Icon(
                                              Icons.delete,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ExpandableText("${data['address']}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white70),
                                    expandText: '',
                                    expandOnTextTap: true,
                                    collapseOnTextTap: true),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );*/
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }
          }),
    );
  }
}
