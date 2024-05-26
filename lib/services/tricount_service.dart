import 'package:rxdart/subjects.dart';
import 'package:tricount/models/tricount.dart';
import 'package:tricount/repository/tricount_repository.dart';

class TricountService {

  TricountRepository repository = TricountRepository();

  TricountService();

  final _controller = BehaviorSubject<List<Tricount>>.seeded(const []);

  Future<void> fetch() async {
    final tricounts = await repository.fetch();
    _controller.add(tricounts);
  }

  Stream<List<Tricount>> get() => _controller.asBroadcastStream();

  Future<void> save(Tricount tricount) async {
    final tricounts = [..._controller.value];

    final idx = tricounts.indexWhere((t) => false);

    final newTricount = await repository.save(tricount);

    if (idx >= 0) {
      tricounts[idx] = newTricount;
    } else {
      tricounts.insert(0, tricount);
    }

    _controller.add(tricounts);
  }

  void filter(String text) {
    final tricounts = [..._controller.value];

    final List<Tricount> filteredTricounts;

    if (text != "") {
      filteredTricounts = tricounts.where((t) => t.title.startsWith(text)).toList();
    } else {
      filteredTricounts = tricounts;
    }

    _controller.add(filteredTricounts);
  }

  Future<void> delete(int id) async {
    final tricounts = [..._controller.value];
    final idx = tricounts.indexWhere((t) => t.id == id);
    if (idx == -1) {
      throw Exception("tricount id not found");
    } else {
      tricounts.removeAt(idx);
      _controller.add(tricounts);
    }
  }

  Future<void> close() {
    return _controller.close();
  }

}