import 'package:racao_av/model/anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper {
  //utilizando padrao singleton de class para banco de dados
  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();
  Database? _db;
  final nomeTabela = 'anotacao';

  factory AnotacaoHelper() {
    return _anotacaoHelper;
  }
  AnotacaoHelper._internal();
  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDB();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    String sql = "CREATE TABLE $nomeTabela ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "numeroAv INTEGER,"
        "numeroLote INTEGER,"
        "tipoRacao VARCHAR,"
        "data DATETIME,"
        "quantidade INTEGER,"
        "nomeMotorista VARCHAR)";
    await db.execute(sql);
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados =
        join(caminhoBancoDados, "banco_minhas_anotacoes.db");
    var db =
        await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> salvarAnotacao(Anotacao anotacao) async {
    var bancoDados = await db;

    int id = await bancoDados.insert(nomeTabela, anotacao.toMap());
    return id;
  }

  recuperarAnotacoes() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY data DESC";
    List anotacoes = await bancoDados.rawQuery(sql);
    return anotacoes;
  }

  recuperaNotasAviarios(int numeroAviario) async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabela WHERE numeroAv = $numeroAviario";
    List anotacoes = await bancoDados.rawQuery(sql);
    return anotacoes;
  }

}
