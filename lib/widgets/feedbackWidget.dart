import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedBackWidget extends StatefulWidget {
  // const MyWidget({Key? key}) : super(key: key);
  static const routeName = 'feedbackpage';

  @override
  State<FeedBackWidget> createState() => _FeedBackWidgetState();
}

class _FeedBackWidgetState extends State<FeedBackWidget> {
  final _firestore = FirebaseFirestore.instance;
  final firstController = TextEditingController();
  final secondController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  late CollectionReference hotelsRef = _firestore.collection('feedbacks');
  late double rating;
  bool success = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('META OZCE'),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: formkey,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Mobil için geri bildirim",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: secondController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.feedback,
                          color: Theme.of(context).primaryColor,
                        ),
                        labelText: "Geri bildiriminizi giriniz",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: "Geri Bildirim",
                        hintStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        //errorText: _submitted ? mailCheck(_emailController) : null,
                      ),
                      onSaved: (value) => setState(
                        () {
                          if (value != null) {
                            secondController.text = value;
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: RatingBar.builder(
                      initialRating: 3,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                          default:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                        }
                      },
                      onRatingUpdate: (rates) {
                        rating = rates;
                        setState(() {});
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();

                        setState(() {
                          success = true;
                        });
                        hotelsRef.add({
                          'mobil': secondController.text,
                          "rating": rating,
                        });
                      }
                    },
                    child: const Text("Gönder"),
                  ),
                  success
                      ? Container(
                          height: 50,
                          color: Colors.green,
                          child: const Center(
                              child: Text(
                                  "Geri bildirimiz alınmıştır teşekkür ederiz")))
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
