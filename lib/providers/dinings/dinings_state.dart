import 'package:equatable/equatable.dart';

import '../../data/models/dining_model.dart';

abstract class DiningsState extends Equatable {
  const DiningsState();
}

class DiningsInitial extends DiningsState {
  const DiningsInitial();

  @override
  List<Object> get props => [];
}

class DiningsLoading extends DiningsState {
  const DiningsLoading();

  @override
  List<Object> get props => [];
}

class DiningsLoaded extends DiningsState {
  final Map<String, List<Dining>> dinings;
  const DiningsLoaded(this.dinings);

  @override
  List<Object> get props => [dinings];
}

class DiningsError extends DiningsState {
  final String message;
  const DiningsError(this.message);

  @override
  List<Object> get props => [message];
}
