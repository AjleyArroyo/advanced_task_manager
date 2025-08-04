import 'package:advanced_task_manager/countries/domain/entities/countries_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'country_model.freezed.dart';
part 'country_model.g.dart';

@freezed
sealed class CountryModel with _$CountryModel implements Country {
  const factory CountryModel({
    required String code,
    required String name,
    required String emoji,
  }) = _CountryModel;

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);
}
