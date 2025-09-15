import 'package:hive/hive.dart';
import 'package:taskati/core/models/task_model.dart';

// 1) init hive
// 2) create helper class and open your box and take instance of it
// 3) create function to put data and get data
// 4) use this class and its methods to save and get data
//! Note : Not Needed to Call init() Again After First Time !!

//* Store an object in hive ??
// 1) create a model class (TaskModel)
// 2) annotation class with @HiveType and its fields with @HiveField`
// 3) add build_runner and Hive_generator in pubspec.yaml (dev_dependencies)
// 4) run "flutter pub run build_runner build"
// 5) register type adapter in main.dart

class LocalHelper {
  static late Box userBox;
  static late Box<TaskModel> taskBox;

  static String kName = 'name';
  static String kImage = 'image';
  static String kIsUploaded = 'isUploaded';
  static String kIsDark = 'isDark';

  static init() async {
    Hive.registerAdapter<TaskModel>(TaskModelAdapter());
    userBox = await Hive.openBox('userBox');
    taskBox = await Hive.openBox<TaskModel>('taskBox');
  }

  static putData(String key, dynamic value) {
    userBox.put(key, value);
  }

  static getData(String key) {
    return userBox.get(key);
  }

  static putTask(String key, TaskModel value) {
    taskBox.put(key, value);
  }

  static TaskModel? getTask(String key) {
    return taskBox.get(key);
  }

  static putUserData(String name, String image) {
    putData(kName, name);
    putData(kImage, image);
    putData(kIsUploaded, true);
  }

  static changeTheme(){
    bool cachedTheme = userBox.get(kIsDark) ?? false;
    userBox.put(kIsDark, !cachedTheme);
  }
}
