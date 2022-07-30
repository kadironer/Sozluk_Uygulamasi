import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class VeritabaniYardimcisi{

  static const String veritabaniAdi="kelimeler.db";

  static Future<Database> veritabaniErisim() async{
    String veritabaniYolu= join(await getDatabasesPath(),veritabaniAdi);

    if(await databaseExists(veritabaniYolu)){
      print("Kopyalamaya gerek yok");
    }else{
      ByteData data=await rootBundle.load("veritabani/$veritabaniAdi");

      List<int> bytes=data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);

      await File(veritabaniYolu).writeAsBytes(bytes,flush: true);
      print("Veri tabanı kopyalandı");

    }

    return openDatabase(veritabaniYolu);
  }

}