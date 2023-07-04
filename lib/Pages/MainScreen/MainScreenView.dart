import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/const.dart';

class MainScreenView extends StatefulWidget {
  String? username;
  MainScreenView({required this.username});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

List<String> myFilterStatus = ["Bekleyen", "Tamamlandı", "İptal Edildi"];

class _MainScreenViewState extends State<MainScreenView> {
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  String status = "Bekleyen";
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    CollectionReference personelRef = _firestore.collection('metaOzcePersonel');
    CollectionReference gorevKategorileriRef =
        personelRef.doc(widget.username).collection('gorevKategorileri');

    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (String filterStatus in myFilterStatus)
                              Expanded(
                                  child: GestureDetector(
                                onTap: () async {
                                  print(widget.username);
                                  // print("a");
                                  // var resp = await personelRef
                                  //     .doc('AliYenilmez')
                                  //     .collection('gorevKategoriler')
                                  //     .doc('havuz')
                                  //     .get();
                                  // var veri = resp.data();
                                  // print(veri);
                                  setState(() {
                                    if (filterStatus == "Bekleyen") {
                                      status = "Bekleyen";
                                      _alignment = Alignment.topLeft;
                                    } else if (filterStatus == "Tamamlandı") {
                                      status = "Tamamlandı";
                                      _alignment = Alignment.topCenter;
                                    } else if (filterStatus == "İptal Edildi") {
                                      status = "İptal Edildi";
                                      _alignment = Alignment.topRight;
                                    }
                                  });
                                },
                                child: Center(
                                    child: Text(
                                  filterStatus,
                                )),
                              ))
                          ],
                        ),
                      ),
                      AnimatedAlign(
                        alignment: _alignment,
                        duration: Duration(milliseconds: 200),
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            status,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: gorevKategorileriRef.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                    if (asyncSnapshot.hasError) {
                      return Center(
                        child: Text("Hata!"),
                      );
                    } else {
                      if (!asyncSnapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        List<DocumentSnapshot> listOfDocumentSnap =
                            asyncSnapshot.data.docs;
                        List<dynamic> filteredSchedules =
                            listOfDocumentSnap.where((var schedule) {
                          return schedule['status'] == status;
                        }).toList();
                        return Expanded(
                          child: SizedBox(
                            child: ListView.builder(
                                itemCount: filteredSchedules.length,
                                itemBuilder: ((context, index) {
                                  var _filteredSchedule =
                                      filteredSchedules[index];
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${_filteredSchedule['kategori'].toString().toUpperCase()}', //   "",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '${_filteredSchedule.get('gorev')}', //   "",
                                                    style: TextStyle(),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  /*  Container(
                                                    decoration: BoxDecoration(
                                                        color: kPrimaryColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.82,
                                                    padding: EdgeInsets.all(20),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.calendar_today,
                                                          color: Colors.white,
                                                          size: 15,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '${listOfDocumentSnap[index].get('tarih')}', //_schedule['date'],
                                                          style: TextStyle(
                                                              color: Colors.white),
                                                        ),
                                                      ],
                                                    ))*/
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Visibility(
                                                visible: status == "Bekleyen"
                                                    ? true
                                                    : false,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    _filteredSchedule.get(
                                                                'status') ==
                                                            "Bekleyen"
                                                        ? _filteredSchedule
                                                            .reference
                                                            .update({
                                                            'status':
                                                                'İptal Edildi'
                                                          }) //todo

                                                        : null;
                                                  },
                                                  child: Text('İptal Edildi',
                                                      style: TextStyle(
                                                          color:
                                                              kPrimaryColor)),
                                                ),
                                              )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: Visibility(
                                                visible: status == "Bekleyen"
                                                    ? true
                                                    : false,
                                                child: OutlinedButton(
                                                  style: OutlinedButton.styleFrom(
                                                      backgroundColor:
                                                          kPrimaryLightColor),
                                                  onPressed: () {
                                                    _filteredSchedule.get(
                                                                'status') ==
                                                            "Bekleyen"
                                                        ? {
                                                            _filteredSchedule
                                                                .reference
                                                                .update({
                                                                  "status":
                                                                      "Tamamlandı"
                                                                })
                                                                .then((value) =>
                                                                    print(
                                                                        'Doküman güncellendi'))
                                                                .catchError(
                                                                    (error) =>
                                                                        print(
                                                                            'Hata: $error')),
                                                            print("a")
                                                          }
                                                        : null;
                                                  },
                                                  child: Text('Tamamlandı',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
