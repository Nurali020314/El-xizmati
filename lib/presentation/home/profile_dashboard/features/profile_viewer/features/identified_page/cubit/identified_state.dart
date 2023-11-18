part of 'identified_cubit.dart';

@freezed
class IdentifiedBuildable with _$IdentifiedBuildable {
  const factory IdentifiedBuildable(
      {@Default("") String biometricSerial,
      @Default("") String biometricNumber,
      @Default("") String brithDate,
      @Default("") String phoneNumber,
      @Default("") String fullName,
      @Default("") String userName,
      @Default("") String email,
      @Default("") String region,
      @Default("") String district,
      @Default("") String neighborhood,
      @Default("") String homeNumber,
      @Default("") String apartmentNumber}) = _IdentifiedBuildable;
}

@freezed
class IdentifiedListenable with _$IdentifiedListenable {
  const factory IdentifiedListenable(IdentifiedEffect effect, {String? message}) = _IdentifiedListenable;
}

enum IdentifiedEffect { success }