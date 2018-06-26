part of support_lines_component;

class CustomSupportLinesComponent extends DayViewComponent {
  const CustomSupportLinesComponent({
    @required this.supportLinesToBuild,
    @required this.itemBuilder,
  })  : assert(supportLinesToBuild != null),
        assert(itemBuilder != null);

  /// List of SupportLines ([SupportLineProperties]) to build when calling [buildItems].
  final List<SupportLineProperties> supportLinesToBuild;

  /// Function that builds a SupportLine.
  final SupportLineBuilder itemBuilder;

  @override
  List<Positioned> buildItems(BuildContext context) {
    List<Positioned> items = <Positioned>[];

    _ItemCreator itemCreator = new _ItemCreator(
      context: context,
      restrictions: DayViewRestrictions.of(context),
      positions: DayViewPositions.of(context),
      itemBuilder: itemBuilder,
    );

    for (SupportLineProperties itemProperties in supportLinesToBuild) {
      if (!itemCreator.canItemBeBuilt(itemProperties.minuteOfDay)) {
        continue;
      }
      items.add(
        itemCreator.buildItem(itemProperties),
      );
    }

    return items;
  }
}
