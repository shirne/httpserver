import 'model.dart';

abstract class Module<M extends Model, T> {
  M find(T value);
  List<M> select();

  bool update(M model);
  bool insert(M model);

  bool delete(T value);
}
