import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quiz_eng/config/get.dart';
import 'package:quiz_eng/model/auth_model.dart';
import 'package:quiz_eng/model/question_model.dart';
import 'package:quiz_eng/service/auth_service.dart';
import 'package:quiz_eng/service/question_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setup();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage());
  }
}

class HomePage extends StatelessWidget {
   HomePage({super.key});
   TextEditingController username = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(
              flex: 12,
            ),
            Text(
              "L O G I N",
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 145, 69, 118),
                  fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 10,
            ),
            Flexible(
              flex: 8,
              child: Container(
                width: 308,
                height: 58,
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  
                ),
                 
                child:TextFormField(
                        controller: username,
                        onChanged: (value) {
                          core
                              .get<SharedPreferences>()
                              .setString('username', value);
                        },
                        validator: (value) {
                          if (value!.length < 4 ?? true) {
                            return "you cant login with username less than 3";
                          } else {}
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "username",
                          labelStyle: const TextStyle(
                              color: Color(0xFF914576), fontSize: 12),
                          prefixIconColor: const Color(0xFF914576),
                          prefixIcon: const Icon(Icons.person),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: Color(0xFF914576),
                              width: 2.0,
                            ),
                          ),
                        )),
              ),
            ),
            Spacer(),
            Flexible(
              flex: 8,
              child: InkWell(
               onTap: ()  {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateQuestion(),
                  ));
          },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  width: 308,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(255, 145, 69, 118),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CreateQuestion extends StatelessWidget {
  CreateQuestion({super.key});

  TextEditingController question = TextEditingController();
  TextEditingController answer = TextEditingController();
  TextEditingController answer1 = TextEditingController();
  TextEditingController answer2 = TextEditingController();
  TextEditingController answer3 = TextEditingController();
  TextEditingController indexOfCorrect = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: question,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: answer,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: answer1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: answer2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: answer3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              child: TextField(
                controller: indexOfCorrect,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
          onTap: () async {
            bool status = await QuestionServiceImp().createNewQues(QuestionModel(
                question: question.text,
                answers: [
                  answer.text,
                  answer1.text,
                  answer2.text,
                  answer3.text
                ],
                indexOfCorrect: num.parse(indexOfCorrect.text)));

            if (status) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Success"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Error"),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ));
            }
          },
          child: InkWell(
            onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Questions(),
                    ),
                  );
                },
            
            child: Icon(Icons.send))),
    );
  }
}

Future<List<QuestionModel>> getData() async {
  Dio req = Dio();
  List<QuestionModel> todos = [];
  try {
    Response res =
        await req.get("https://6650d71420f4f4c442764720.mockapi.io/questions");
    for (var i = 0; i < res.data.length; i++) {
      QuestionModel todo = QuestionModel.fromMap(res.data[i]);
      todos.add(todo);
    }
    return todos;
  } catch (e) {
    print(e);
    return todos;
  }
}

class Questions extends StatelessWidget {
  const Questions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                      title: Text(snapshot.data![index].question),
                    ));
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      )
    );
  }
}

