import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/day_view.dart';

import '../component.dart';

class AreaBackgroundComponent extends Component {
  AreaBackgroundComponent({
    @required this.areaName,
    @required this.color,
  })  : assert(areaName != null),
        assert(color != null);

  final AreaNameOLD areaName;
  final Color color;

  @override
  List<Positioned> buildItems(BuildContext context) {
    PositioningAssistant positioningAssistant =
        _getPositioningAssistant(context);

    AreaOLD area = positioningAssistant.getAreaOf(areaName);

    return <Positioned>[
      new Positioned(
        left: area.left,
        top: area.top,
        right: area.right,
        bottom: area.bottom,
        child: new Container(
          color: color,
        ),
      ),
    ];
  }

  PositioningAssistant _getPositioningAssistant(BuildContext context) {
    return PositioningAssistantProvider.of(context);
  }
}
