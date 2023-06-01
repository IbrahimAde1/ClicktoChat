import 'package:click_chat/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

GlobalKey<FormState> globalKey = GlobalKey();
String? phone;
String? countryCode;
bool theme = false;
bool lang = false;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: IconButton(
                  onPressed: () {
                    if (lang == true) {
                      lang = false;
                    } else {
                      lang = true;
                    }
                    setState(() {});
                  },
                  icon: Text(
                    lang == false ? 'ع' : 'en',
                    style: const TextStyle(fontSize: 20),
                  )),
            ),
            const SizedBox(width: 30),
            Text(
              lang == true ? "دوس عشان تتشات" : 'Click To Chat ',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: () {
                  if (ClickChat.themeNotifier.value == ThemeMode.light) {
                    ClickChat.themeNotifier.value = ThemeMode.dark;
                    theme = true;
                  } else {
                    ClickChat.themeNotifier.value = ThemeMode.light;
                    theme = false;
                  }
                  setState(() {});
                },
                icon: Icon(theme == true ? Icons.dark_mode : Icons.light_mode)),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        hintStyle: const TextStyle(fontSize: 18),
                        prefix: CountryCodePicker(
                            dialogTextStyle: TextStyle(color: Colors.white),
                            closeIcon:
                                const Icon(Icons.close, color: Colors.white),
                            searchDecoration: const InputDecoration(
                                prefixIconColor: Colors.white),
                            barrierColor: Colors.transparent,
                            dialogBackgroundColor:
                                const Color.fromARGB(255, 32, 31, 31),
                            flagWidth: 20,
                            textStyle: const TextStyle(fontSize: 18),
                            initialSelection: 'EG',
                            favorite: const ['+20', 'EG'],
                            onChanged: (val) {
                              countryCode = val.toString();
                            }),
                        hintText: lang == true ? '١٠٢٣٤٥٦٧٨٩' : '1023456789',
                        labelText:
                            lang == true ? 'دخل الرقم ياباشا' : 'Click To Chat',
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(20, 20)))),
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      if (globalKey.currentState!.validate()) {
                        phone = value;
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return lang == true ? "دخل رقم" : "Enter number ";
                      } else if (value.length != 10) {
                        return lang == true
                            ? "دخل رقم عدل يا بني ادم"
                            : "valid number";
                      }
                      return null;
                    },
                    onChanged: (value) => phone = value,
                    onFieldSubmitted: (value) {
                      if (globalKey.currentState!.validate()) {
                        phone = value;
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (globalKey.currentState!.validate()) {
                      final Uri url = Uri(
                          scheme: 'https',
                          path: 'wa.me/${countryCode ?? '+20'}$phone');
                      if (await canLaunchUrl(url)) {
                        launchUrl(url, mode: LaunchMode.externalApplication);
                      }
                    }
                  },
                  child: Text(
                      lang == true ? "روح للواتس اب" : 'Go to Chat WhatsApp'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (globalKey.currentState!.validate()) {
                      final Uri url = Uri(
                          scheme: 'https',
                          path: 't.me/${countryCode ?? '+20'}$phone');
                      if (await canLaunchUrl(url)) {
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    }
                  },
                  child: Text(
                      lang == true ? "روح للتلجرام" : 'Go to Chat Telgram'),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: Text(lang == true
                //       ? "©٢٠٢٣ مصمم بواسطة ابراهيم عادل"
                //       : '©2023 Ibrahim Adel All Right Reserved'),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 