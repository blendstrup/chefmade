import 'package:equatable/equatable.dart';

abstract class StatusState extends Equatable {
  const StatusState(this.status);

  final Map<String, bool> status;
}

class StatusInitial extends StatusState {
  const StatusInitial(Map<String, bool> initialStatus) : super(initialStatus);

  @override
  List<Object?> get props => [status];
}

class StatusSelected extends StatusState {
  const StatusSelected(Map<String, bool> selected) : super(selected);

  @override
  List<Object> get props => [status];
}
