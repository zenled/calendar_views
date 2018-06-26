part of time_indicators_component;

class CustomTimeIndicatorsComponent implements DayViewComponent {
  const CustomTimeIndicatorsComponent({
    @required this.timeIndicatorsToMake,
    @required this.itemBuilder,
  })  : assert(timeIndicatorsToMake != null),
        assert(itemBuilder != null);

  /// List of TimeIndicators ([TimeIndicatorProperties]) to build when calling [buildItems].
  final List<TimeIndicatorProperties> timeIndicatorsToMake;

  /// Function that builds a TimeIndicator.
  final TimeIndicatorBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> items = <Positioned>[];

    _ItemCreator itemCreator = new _ItemCreator(
      context: context,
      restrictions: DayViewRestrictions.of(context),
      positions: DayViewPositions.of(context),
      itemBuilder: itemBuilder,
    );

    for (TimeIndicatorProperties itemProperties in timeIndicatorsToMake) {
      if (!itemCreator._isItemVisible(itemProperties.minuteOfDay)) {
        continue;
      }

      items.add(
        itemCreator.buildItem(itemProperties),
      );
    }

    return items;
  }
}
