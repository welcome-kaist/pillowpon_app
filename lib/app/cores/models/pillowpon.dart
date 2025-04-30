import '../enums/connected_state.dart';

class Pillowpon {
  String id;
  String name;
  ConnectedState connectedState;

  Pillowpon({
    required this.id,
    required this.name,
    required this.connectedState,
  });
}
