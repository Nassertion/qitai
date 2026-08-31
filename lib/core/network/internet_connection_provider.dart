import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'internet_connection_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<InternetStatus> internetStatus(Ref ref) {
  final connection = InternetConnection();

  return Stream.multi((controller) async {
    controller.add(await connection.internetStatus);

    final subscription = connection.onStatusChange.listen(
      controller.add,
    );

    ref.onDispose(() {
      subscription.cancel();
    });
  });
}