import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'farmDB');
    var database = await openDatabase(path, version: 1, onCreate: _onCreateDB);
    return database;
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE cattle(id INTEGER PRIMARY KEY AUTOINCREMENT,
     cattleBreed TEXT,
     cattleName TEXT,
     cattleTagNo TEXT,
     cattleGender TEXT,
     cattleStage TEXT,
     cattleWeight TEXT,
     cattleDOB TEXT,
     cattleDOE TEXT,
     cattleObtainMethod TEXT,
     cattleMotherTagNo TEXT,
     cattleFatherTagNo TEXT,
     cattleNotes TEXT)
    
    ''');

    await db.execute('''
    CREATE TABLE cattleBreed(id INTEGER PRIMARY KEY AUTOINCREMENT,
     cattleBreed TEXT)
    
    ''');

    await db.execute('''
    CREATE TABLE milk(id INTEGER PRIMARY KEY AUTOINCREMENT,
     milkDate TEXT,
     milkType TEXT,
     milkTotalUsed TEXT,
     milkTotalProduced TEXT,
     cowMilked TEXT,
     noOfCattleMilked TEXT)
    
    ''');

    await db.execute('''
    CREATE TABLE event(id INTEGER PRIMARY KEY AUTOINCREMENT,
     eventDate TEXT,
     eventType TEXT,
     nameOfMedicine TEXT,
     eventNotes TEXT)
    
    ''');

    await db.execute('''
    CREATE TABLE eventIndividual(id INTEGER PRIMARY KEY AUTOINCREMENT,
     eventDate TEXT,
     eventType TEXT,
     nameOfMedicine TEXT,
     eventNotes TEXT,
     cattleId TEXT,
     cattleTagNo TEXT)
    
    ''');

    await db.execute('''
    CREATE TABLE income(id INTEGER PRIMARY KEY AUTOINCREMENT,
     incomeDate TEXT,
     incomeType TEXT,
     milkQty TEXT,
     incomeNotes TEXT,
     amountEarned TEXT,
     receiptNo TEXT)
    
    ''');


  }
}
