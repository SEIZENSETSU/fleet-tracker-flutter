import 'package:fleet_tracker/Constants/strings.dart';
import 'package:fleet_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';

enum WarehouseDelayState {
  normal,
  pause,
  halfHour,
  anHour,
  impossible,
}

class WarehouseDelayStateType {
  WarehouseDelayState? type;
  WarehouseDelayStateType(String rowType) {
    switch (rowType) {
      case 'normal':
        type = WarehouseDelayState.normal;
        break;
      case 'pause':
        type = WarehouseDelayState.pause;
        break;
      case 'halfHour':
        type = WarehouseDelayState.halfHour;
        break;
      case 'anHour':
        type = WarehouseDelayState.anHour;
        break;
      case 'impossible':
        type = WarehouseDelayState.impossible;
        break;
      default:
        type = null;
    }
  }

  String? title() {
    switch (type) {
      case WarehouseDelayState.normal:
        return Strings.STATE_NORMAL_TITLE;
      case WarehouseDelayState.pause:
        return Strings.STATE_PAUSE_TITLE;
      case WarehouseDelayState.halfHour:
        return Strings.STATE_HALF_HOUR_TITLE;
      case WarehouseDelayState.anHour:
        return Strings.STATE_AN_HOUR_TITLE;
      case WarehouseDelayState.impossible:
        return Strings.STATE_IMPOSSIBLE_TITLE;
      default:
        return null;
    }
  }

  Color? color() {
    switch (type) {
      case WarehouseDelayState.normal:
        return ColorName.stateNormal;
      case WarehouseDelayState.pause:
        return ColorName.statePause;
      case WarehouseDelayState.halfHour:
        return ColorName.stateHalfAnHour;
      case WarehouseDelayState.anHour:
        return ColorName.stateAnHour;
      case WarehouseDelayState.impossible:
        return ColorName.stateImpossible;
      default:
        return null;
    }
  }
}
