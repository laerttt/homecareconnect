import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/button.dart';
import 'package:homecareconnect/components/drawer.dart';
import 'package:homecareconnect/components/text_field.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}


class _RegisterState extends State<Register> {
  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  final  surnameController = TextEditingController();
  final  firstNameController = TextEditingController();
  final usernameController= TextEditingController();
  final passwordController= TextEditingController();
  final phoneController= TextEditingController();
  final  emailController = TextEditingController();
  late var allergenController= TextEditingController();
  final List<String> allergens = [
    'pollen',
    'dust mites',
    'mold spores',
    'pet dander',
    'nuts',
    'dairy',
    'eggs',
    'insect stings',
    'penicillin',
    'shellfish',
    'fish',
    'soy',
    'wheat',
    'sesame seeds',
    'peanuts',
    'tree nuts',
    'almonds',
    'walnuts',
    'cashews',
    'eggs',
    'milk',
    'sulfites',
    'nickel',
    'sunlight (solar urticaria)',
    'cold (cold urticaria)',
    'heat (heat urticaria)',
    'exercise-induced',
    'pollen-food syndrome (oral allergy syndrome)',
    'fragrances',
    'chemicals',
    'cockroach droppings',
    'mold',
    ' poison ivy ',
    'poison oak'
    'nickel,',
        ' cobalt',
    'wool',
    'antibiotics',
    'aspirin',
    'latex ',
    'cosmetics',
    'detergents',
    'pet saliva',
    'dairy products',
    'pine pollen',
    'feathers',
    'gluten',
    'strawberries',
    'kiwi',
    'bananas',
    'avocado',
    'pineapple',
    'mango',
    'papaya',
  ];

  String? _searchingWithQuery;
  late Iterable<Widget> _lastOptions = <Widget>[];

  FilePickerResult? filesController;
  bool isDark = false;
  Iterable<String> search(String query)  {
    if (query == '') {
      return const Iterable<String>.empty();
    }
    return allergens.where((String option) {
      return option.contains(query.toLowerCase());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: myDrawer(),
        appBar: getAppBar(
          "Sign Up "
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: myTextField(

                        controller: firstNameController,
                        hintText: "Enter your first name"
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myTextField(
                        controller: surnameController,
                        hintText: "Enter your last name",

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myTextField(
                          /// TODO: Email duplicate check
                          controller: firstNameController,
                          hintText: "Enter your email "
                      ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myTextField(
                        /// TODO: Email duplicate check
                          controller: firstNameController,
                          hintText: "Enter your username "
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),

                      child:   myTextField(
                        hintText: 'Password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myTextField(

                          controller: firstNameController,
                          hintText: "Enter your mobile number "
                      ),
                    ),
                    Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 25.0),


                      child: Row(
                        children: [
                          Expanded(



                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),

                              child: Text(
                                  'Add medical files',
                            style:TextStyle(color: Colors.grey[500]) ,

                          ),
                        ),
                          ),

                         Expanded(

                           child: Container(

                            child: IconButton(
                                icon: Icon(Icons.attach_file),

                                onPressed: () async {
                                  filesController =
                                  await FilePicker.platform.pickFiles(allowMultiple: true);
                                  if ( filesController== null) {
                                    print("No file selected");
                                  } else {
                                    setState(() {});
                                    for (var element in filesController!.files) {
                                      print(element.name);
                                    }
                                  }

                                },
                              ),

                          ),
                         )
                        ],
                      ),
                    ),
                    Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                      child:  Row(
                        children: [
                          Expanded(



                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),

                              child: Text(
                                'Add known allergens',
                                style:TextStyle(color: Colors.grey[500]) ,

                              ),
                            ),
                          ),

                          Expanded(

                            child: Container(

                              child: SearchAnchor(
                                  isFullScreen: false,
                                  builder: (BuildContext context, SearchController controller) {
                                    return IconButton(
                                      icon: const Icon(Icons.medical_information_rounded),
                                      onPressed: () {
                                        controller.openView();
                                      },
                                    );
                                  }, suggestionsBuilder:
                                  (BuildContext context, SearchController controller) async {
                                _searchingWithQuery = controller.text;
                                final List<String> options =
                                (search(_searchingWithQuery!)).toList();

                                // If another search happened after this one, throw away these options.
                                // Use the previous options instead and wait for the newer request to
                                // finish.
                                if (_searchingWithQuery != controller.text) {
                                  return _lastOptions;
                                }

                                _lastOptions = List<ListTile>.generate(options.length, (int index) {
                                  final String item = options[index];
                                  return ListTile(
                                    onTap: (
                                    null
                                        ///add on tap for allergens
                                      ),
                                    title: Text(item),
                                  );
                                });

                                return _lastOptions;
                              })


                            ),
                          )
                        ],
                      ),

                    ),

                    Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                            child: myBaseButton(
                               buttonText: "Register",

                              //onPressed: func;
                              /// method for register here
                            ),

                            width: MediaQuery.of(context).size.width,

                            height: 50,
                          ),

                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        ///Add onTap reroute Si
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 90.0),
                          child: Text(
                            "Are you a clinic?",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),


                    ),


                  ],
                )),
          ),
        ));


  }
}

