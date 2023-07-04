import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/const.dart';
import '../../widgets/navigationBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  // final TextEditingController controllerUsername = TextEditingController();
  // final TextEditingController controllerPassword = TextEditingController();
  bool isLogin =
      false; //giriş yapınca true olacak, dbye gönderilecek, öbür sayfalarda dbden çekilecek
  bool hidePassword = true;
  String? usernamefd = "FatmaTurgut";
  String? password = "1234";
  String? inputUsername = "";
  final firestore = FirebaseFirestore.instance;
  var personelRef;
  var stream;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
            ),
            Image.asset(
              "assets/logo/logo.png",
              width: 200,
            ),
            Padding(
              padding: EdgeInsets.only(left: 45, right: 45, bottom: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text("Personel Uygulaması",
                      style: GoogleFonts.michroma(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                          color: Color.fromARGB(255, 68, 71, 216))),
                  Divider(
                    height: MediaQuery.of(context).size.height * 0.01,
                    color: kPrimaryLightColor,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  buildUsername(),
                  const SizedBox(height: defaultPadding),
                  buildPassword(),

                  /*  TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ),*/
                  /* Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                obscureText: true,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Your password",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Icon(
                      Icons.lock,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ),*/

                  const SizedBox(height: defaultPadding),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: textColorMid, fontSize: 15),
                            children: [
                              TextSpan(
                                  text: "Şifrenizi mi unuttunuz?",
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: textColorMid,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {})
                            ]),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  buildLogin(),
                ],
              ),
            ),

            // AlreadyHaveAnAccountCheck(
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return SignUpScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildUsername() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: kPrimaryColor,
        onSaved: (email) {},
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Icon(
              Icons.person,
              color: Colors.grey[300],
            ),
          ),
          // labelText: 'Kullanıcı adı',
          // labelStyle: TextStyle(color: Color.fromARGB(255, 68, 71, 216)),
          hintText: 'Kullanıcı adı',
        ),
        validator: (value) {
          if (value == " ") {
            return "Kullanıcı adı boş bırakılamaz.";
          } else {
            inputUsername = value;
            return null;
          }
        },
      );
  Widget buildPassword() => TextFormField(
        textInputAction: TextInputAction.done,
        obscureText: hidePassword,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              color: Colors.white,
              onPressed: () {
                print("tıklandı");
              },
              icon:
                  Icon(hidePassword ? Icons.visibility_off : Icons.visibility)),
          // labelText: 'Şifre',
          // labelStyle: TextStyle(color: Color.fromARGB(255, 68, 71, 216)),
          hintText: "Şifre",
          prefixIcon: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Icon(
              Icons.lock,
              color: Colors.grey[300],
            ),
          ),
        ),
        validator: (value) {
          if (value != password) {
            return "Hatalı şifre.";
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.visiblePassword,
      );

  Widget buildLogin() => Builder(
        builder: (context) => ElevatedButton(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              isValid
                  ? {
                      personelRef = firestore.collection('metaOzcePersonel'),
                      stream = personelRef.snapshots(),
                      stream.forEach((QuerySnapshot element) {
                        if (element == null)
                          print("bos");
                        else {
                          for (int count = 0;
                              count < element.docs.length;
                              count++) {
                            String test =
                                "${element.docs[count].get('ad')}${element.docs[count].get('soyad').toString()}";
                            if (test == inputUsername.toString()) {
                              print(
                                  "dogru1   ${element.docs[count].get('ad')}${element.docs[count].get('soyad')}");

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationBarMy(
                                      username_u: inputUsername),
                                ),
                              );
                            } else {
                              /*TODO KULLANICI BULUNAMADI Fluttertoast.showToast(
                                  toastLength: Toast.LENGTH_LONG,
                                  msg: "Kullanıcı bulunamadı.",
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red);*/
                              print(
                                  "yanlis${element.docs[count].get('ad')}${element.docs[count].get('soyad')}");
                            }
                          }
                        }
                      }),
                    }
                  : {
                      Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_LONG,
                          msg: "Hatalı giriş.",
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red)
                    };
            },
            child: Text("Giriş Yap")),
      );
}
