import 'package:flutter/foundation.dart';
import '../test.dart';

/// Contains the output widget of sample
/// appropriate key and output widget mapped
Map<String, Function> getSampleWidget() {
  return <String, Function>{
    //Maps: Shape Layer Samples
    'range_color_mapping': (Key key) => MapRangeColorMappingPage(key),
  };
}
