import 'package:bakeryheaven/widgets/simplifiedText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyBakery());

class MyBakery extends StatelessWidget {
  const MyBakery({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: "Some title",
    //   theme: null,
    //   home: const BasePage(),
    // );
    return ChangeNotifierProvider(
      create: (context) => MyAppVaraibles(),
      child: MaterialApp(
        title: "Don't bother",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const BasePage(),
      ),
    );
  }
}

class MyAppVaraibles extends ChangeNotifier {
  var name = "Money maker";
  List<Map<String, dynamic>> data = [
    {"cake name": "Black forest", "cake details": '''A chocolate and cream cake with a rich cherry filling. While it is most likely based on a Black Forest dessert tradition, the cake's specific origin in Germany is contested. Typically, Black Forest consists of several layers of chocolate sponge cake sandwiched with whipped cream and cherries. It is decorated with additional whipped cream, maraschino cherries, and chocolate shavings. Traditionally Kirschwasser, a clear alcoholic spirit made from sour cherries, is added to the cake. Other spirits are sometimes used, such as rum, which is common in Austrian recipes. German law mandates that any dessert labelled Schwarzwälder Kirschtorte must have Kirschwasser''', "cake image": "BlackForest.jpg"},
    {"cake name": "Caramel cake", "cake details": '''A Filipino chiffon or sponge cake (mamón) baked with a layer of leche flan (crème caramel) on top and drizzled with caramel syrup. It is sometimes known as "custard cake", which confuses it with yema cake. Modern versions of flan cake can be cooked with a variety of added ingredients. An example is the use of ube cake as the base. A similar Filipino dessert that uses a steamed cupcake (puto mamón) as the base is known as puto flan. Flan cake is very similar to the Puerto Rican dish flancocho, except the latter includes cream cheese.''', "cake image": "Caramel.jpg"},
  ];
  Map<String, dynamic> selectedCake = {};
  int page = 0;
  void setname(newName) {
    name = newName;
    notifyListeners();
  }

  void changePage(newpage) {
    page = newpage;
    notifyListeners();
  }
}

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    // int pageIndex = 0;
    // Map<String, dynamic> cakeToShow = context.watch<MyAppVaraibles>().selectedCake;
    Widget page = const Welcome();
    switch (context.watch<MyAppVaraibles>().page) {
      case 0:
        {
          page = const Welcome();
        }
      case 1:
        {
          page = const CakelistPage();
        }
      case 2:
        {
          page = CakeDetailsPage(
            cakeDetails: context.watch<MyAppVaraibles>().selectedCake,
          );
        }
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[700],
        ),
        body: page);
  }
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    var theUsersName = context.watch<MyAppVaraibles>();
    final myController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          const CTextBox(
            inputText: "Welcome to bakery heaven where flour meets profession",
            textStyle: "title",
          ),
          const CTextBox(
            inputText: "Sharing divine sweetness...",
            textStyle: "sub-title",
          ),
          const CTextBox(
            inputText: "Get started here:",
            textStyle: "body",
          ),
          TextField(
            controller: myController,
            decoration: const InputDecoration(labelText: "Enter your name", alignLabelWithHint: true),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const CakelistPage()));
              theUsersName.changePage(1);
              theUsersName.setname(myController.text);
            },
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'proceed',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class CakelistPage extends StatelessWidget {
  const CakelistPage({super.key});

  @override
  Widget build(BuildContext context) {
    var globalApp = context.watch<MyAppVaraibles>();
    var cakes = context.watch<MyAppVaraibles>().data;
    return Scaffold(
      body: ListView(children: [
        CTextBox(inputText: "Hi ${globalApp.name}, what do you fancy today?", textStyle: "sub-title",),
        // Text(globalApp.name),
        for (var cake in cakes)
          Column(
            children: [
              CTextBox(
                inputText: cake["cake name"],
                textStyle: "sub-title",
              ),
              // Text(cake["cake details"]),
              Stack(
                children: [
                  Image(image: AssetImage('assets/${cake["cake image"]}')),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        iconAlignment: IconAlignment.end,
                        onPressed: () {
                          globalApp.changePage(2);
                          globalApp.selectedCake = cake;
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => CakeDetailsPage(
                          //                 cakeDetails: cake,
                          //               )));
                        },
                        child: const Text('Go to cake details'),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(30))
            ],
          ),
      ]),
    );
  }
}

class CakeDetailsPage extends StatelessWidget {
  const CakeDetailsPage({super.key, required this.cakeDetails});
  final Map<String, dynamic> cakeDetails;

  @override
  Widget build(BuildContext context) {
    var globalApp = context.watch<MyAppVaraibles>();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CTextBox(inputText: cakeDetails['cake name'], textStyle: "title",),
            Image(image: AssetImage('assets/${cakeDetails["cake image"]}'),),
            Text(cakeDetails['cake details']),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Cakelist()));
                // Navigator.pop(context);
                globalApp.changePage(1);
              },
              child: const Text('Go to cake list'),
            )
          ],
        ),
      ),
    );
  }
}
