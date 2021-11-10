// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CarDataDao? _carDataDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CarData` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `months` TEXT NOT NULL, `totalMiles` TEXT NOT NULL, `dueAtSigning` TEXT NOT NULL, `monthlyPayment` TEXT NOT NULL, `carModel` TEXT NOT NULL, `totalPrice` TEXT NOT NULL, `totalPricePerMonthStr` TEXT NOT NULL, `pricePerMileStr` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CarDataDao get carDataDao {
    return _carDataDaoInstance ??= _$CarDataDao(database, changeListener);
  }
}

class _$CarDataDao extends CarDataDao {
  _$CarDataDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _carDataInsertionAdapter = InsertionAdapter(
            database,
            'CarData',
            (CarData item) => <String, Object?>{
                  'id': item.id,
                  'months': item.months,
                  'totalMiles': item.totalMiles,
                  'dueAtSigning': item.dueAtSigning,
                  'monthlyPayment': item.monthlyPayment,
                  'carModel': item.carModel,
                  'totalPrice': item.totalPrice,
                  'totalPricePerMonthStr': item.totalPricePerMonthStr,
                  'pricePerMileStr': item.pricePerMileStr
                },
            changeListener),
        _carDataUpdateAdapter = UpdateAdapter(
            database,
            'CarData',
            ['id'],
            (CarData item) => <String, Object?>{
                  'id': item.id,
                  'months': item.months,
                  'totalMiles': item.totalMiles,
                  'dueAtSigning': item.dueAtSigning,
                  'monthlyPayment': item.monthlyPayment,
                  'carModel': item.carModel,
                  'totalPrice': item.totalPrice,
                  'totalPricePerMonthStr': item.totalPricePerMonthStr,
                  'pricePerMileStr': item.pricePerMileStr
                },
            changeListener),
        _carDataDeletionAdapter = DeletionAdapter(
            database,
            'CarData',
            ['id'],
            (CarData item) => <String, Object?>{
                  'id': item.id,
                  'months': item.months,
                  'totalMiles': item.totalMiles,
                  'dueAtSigning': item.dueAtSigning,
                  'monthlyPayment': item.monthlyPayment,
                  'carModel': item.carModel,
                  'totalPrice': item.totalPrice,
                  'totalPricePerMonthStr': item.totalPricePerMonthStr,
                  'pricePerMileStr': item.pricePerMileStr
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CarData> _carDataInsertionAdapter;

  final UpdateAdapter<CarData> _carDataUpdateAdapter;

  final DeletionAdapter<CarData> _carDataDeletionAdapter;

  @override
  Stream<List<CarData>> getAllCarData() {
    return _queryAdapter.queryListStream('SELECT * FROM CarData',
        mapper: (Map<String, Object?> row) => CarData(
            id: row['id'] as int?,
            months: row['months'] as String,
            totalMiles: row['totalMiles'] as String,
            dueAtSigning: row['dueAtSigning'] as String,
            monthlyPayment: row['monthlyPayment'] as String,
            carModel: row['carModel'] as String,
            totalPrice: row['totalPrice'] as String,
            totalPricePerMonthStr: row['totalPricePerMonthStr'] as String,
            pricePerMileStr: row['pricePerMileStr'] as String),
        queryableName: 'CarData',
        isView: false);
  }

  @override
  Stream<CarData?> getAllCarDataById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM CarData WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CarData(
            id: row['id'] as int?,
            months: row['months'] as String,
            totalMiles: row['totalMiles'] as String,
            dueAtSigning: row['dueAtSigning'] as String,
            monthlyPayment: row['monthlyPayment'] as String,
            carModel: row['carModel'] as String,
            totalPrice: row['totalPrice'] as String,
            totalPricePerMonthStr: row['totalPricePerMonthStr'] as String,
            pricePerMileStr: row['pricePerMileStr'] as String),
        arguments: [id],
        queryableName: 'CarData',
        isView: false);
  }

  @override
  Future<void> deleteAllCarData() async {
    await _queryAdapter.queryNoReturn('DELETE FROM CarData');
  }

  @override
  Future<void> insertCarData(CarData carData) async {
    await _carDataInsertionAdapter.insert(carData, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCarData(CarData carData) async {
    await _carDataUpdateAdapter.update(carData, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCarData(CarData carData) async {
    await _carDataDeletionAdapter.delete(carData);
  }
}
