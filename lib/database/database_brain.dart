String notesSql = 'CREATE TABLE notes('
    'id INTEGER PRIMARY KEY AUTOINCREMENT, '
    'title TEXT, '
    'content TEXT, '
    'color TEXT'
    ')';

String tasksSql =
    'CREATE TABLE tasks('
    'id INTEGER PRIMARY KEY AUTOINCREMENT, '
    'description TEXT, '
    'dueDate TEXT, '
    'completed TEXT'
    ')';

String appointmentsSql =
    'CREATE TABLE appointments('
    'id INTEGER PRIMARY KEY AUTOINCREMENT,'
    'title TEXT,'
    'description TEXT,'
    'apptDate TEXT,'
    'apptTime TEXT'
    ')';