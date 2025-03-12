
abstract class HomeRepository {
  Future<bool> getListType();
  Future<int> getTotPending();
  Future<int> getTotRegister();
}