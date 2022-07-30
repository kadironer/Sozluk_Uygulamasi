import 'package:flutter/material.dart';
import 'package:proje_sozluk_uygulamasi/detailsPage.dart';
import 'package:proje_sozluk_uygulamasi/kelimelerdao.dart';

import 'kelimeler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home:  HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key,}) : super(key: key);





  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool aramaYapiliyormu = false;
  String aramaKelimesi="";

  Future<List<Kelimeler>> tumKelimelerGoster() async{
    var kelimelerListesi= await Kelimelerdao().tumKelimeler();

    return kelimelerListesi;
  }

  Future<List<Kelimeler>> aramaYap(String aramaKelimesi) async{
    var kelimelerListesi= await Kelimelerdao().kelimeAra(aramaKelimesi);
    return kelimelerListesi;
  }
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyormu ? TextField(
          decoration: InputDecoration(
            hintText: "Aramak istediğiniz kelime",
          ),
          onChanged:(aramaSonucu){
            print("Aramama Sonucu: $aramaSonucu");
            setState((){
              aramaKelimesi=aramaSonucu;
            });
          },
        )
            : Text("Sözlük Uygulaması"),
        actions: [
          aramaYapiliyormu ?
           IconButton(
             icon: Icon(Icons.cancel),
             onPressed:(){
               setState((){
                 aramaYapiliyormu=false;
                 aramaKelimesi="";
               });
             },
           )
          :IconButton(
            icon: Icon(Icons.search),
            onPressed:(){
              setState((){
                aramaYapiliyormu=true;

              });
            },
          )
        ],
      ),
      body:FutureBuilder<List<Kelimeler>>(
        future: aramaYapiliyormu? aramaYap(aramaKelimesi) :tumKelimelerGoster(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var kelimelerListesi=snapshot.data;
            return ListView.builder(
              itemCount: kelimelerListesi!.length,
              itemBuilder: (context,index){
                var kelime=kelimelerListesi[index];
                return GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(kelime: kelime,)));
                  },
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(kelime.ingilizce,style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(kelime.turkce)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return Center();
          }
        },

      ),
    );
  }
}
