import 'package:data_visualization/domain/model/breed/breed.dart';
import 'package:data_visualization/domain/model/common/range.dart';
import 'package:data_visualization/presentation/common/widgets/filter/bloc/breed_filter_bloc.dart';
import 'package:data_visualization/presentation/style/kit/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedFilterWidget extends StatefulWidget {
  const BreedFilterWidget({super.key});

  @override
  State<BreedFilterWidget> createState() => _BreedFilterWidgetState();
}

class _BreedFilterWidgetState extends State<BreedFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedFilterBloc, BreedFilterState>(
      builder: (context, state) {
        if (state.breeds.isEmpty || state.breedFilter == null) {
          return const SizedBox();
        }
        return SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              children: [
                rangeSlider('Рост', state.breeds.heightRange, state.breedFilter!.height, (value) {
                  context.read<BreedFilterBloc>().add(FilterChanged(state.breedFilter!.copyWith(
                        height: Range(value.start.toInt(), value.end.toInt()),
                      )));
                }),
                Gap.md,
                rangeSlider('Вес', state.breeds.weightRange, state.breedFilter!.weight, (value) {
                  context.read<BreedFilterBloc>().add(FilterChanged(state.breedFilter!.copyWith(
                        weight: Range(value.start.toInt(), value.end.toInt()),
                      )));
                }),
                Gap.md,
                rangeSlider('Время жизни', state.breeds.lifeSpanRange, state.breedFilter!.lifeSpan, (value) {
                  context.read<BreedFilterBloc>().add(FilterChanged(state.breedFilter!.copyWith(
                        lifeSpan: Range(value.start.toInt(), value.end.toInt()),
                      )));
                }),
                Gap.md,
                rangeSlider('Цена', state.breeds.priceRange, state.breedFilter!.price, (value) {
                  context.read<BreedFilterBloc>().add(FilterChanged(state.breedFilter!.copyWith(
                        price: Range(value.start.toInt(), value.end.toInt()),
                      )));
                }),
                Gap.md,
                rangeSlider('Рейтинг', state.breeds.ratingRange, state.breedFilter!.rating, (value) {
                  context.read<BreedFilterBloc>().add(FilterChanged(state.breedFilter!.copyWith(
                        rating: Range(value.start.toInt(), value.end.toInt()),
                      )));
                }),
                Gap.md,
                select(
                  'Размер',
                  state.breedFilter!.mainType,
                  (value) {
                    context.read<BreedFilterBloc>().add(FilterChanged(state.breedFilter!.copyWith(
                          mainType: BreedRangeType.values.firstWhere((element) => element == value),
                        )));
                  },
                ),
                Gap.md,
                select('Ось X', state.breedFilter!.xAxisType, (value) {
                  context.read<BreedFilterBloc>().add(FilterChanged(state.breedFilter!.copyWith(
                        xAxisType: BreedRangeType.values.firstWhere((element) => element == value),
                      )));
                }),
                Gap.md,
                select('Ось Y', state.breedFilter!.yAxisType, (value) {
                  context.read<BreedFilterBloc>().add(FilterChanged(state.breedFilter!.copyWith(
                        yAxisType: BreedRangeType.values.firstWhere((element) => element == value),
                      )));
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget select(String title, BreedRangeType value, void Function(BreedRangeType?) onChanged) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        Gap.sm,
        DropdownButtonFormField<BreedRangeType>(
          value: value,
          onChanged: onChanged,
          items: BreedRangeType.values.map((option) {
            return DropdownMenuItem<BreedRangeType>(
              value: option,
              child: Text(option.name),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget rangeSlider<T extends num>(
    String title,
    Range<T> range,
    Range<T>? rangeValue,
    void Function(RangeValues) onChanged,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        Gap.sm,
        Row(
          children: [
            SizedBox(
              width: 40,
              child: Text(
                rangeValue?.min.toString() ?? range.min.toString(),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: RangeSlider(
                values: RangeValues(
                  rangeValue?.min.toDouble() ?? range.min.toDouble(),
                  rangeValue?.max.toDouble() ?? range.max.toDouble(),
                ),
                min: range.min.toDouble(),
                max: range.max.toDouble(),
                onChanged: (value) {
                  onChanged(value);
                },
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(
                rangeValue?.max.toString() ?? range.max.toString(),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
