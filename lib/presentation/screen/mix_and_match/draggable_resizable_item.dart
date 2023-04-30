import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DraggableResizableItem extends StatefulWidget {
  const DraggableResizableItem({super.key, required this.item});

  final Item item;

  @override
  State createState() => _DraggableResizableItemState();
}

class _DraggableResizableItemState extends State<DraggableResizableItem> {
  static const double _minSize = 150;
  static const double _maxSize = 300;

  double _width = 200;
  double _height = 300;
  bool _isScaling = false;
  Offset _itemPosition = Offset.zero;

  void _updateSize(double scale) {
    setState(() {
      final newScale = 1.0 + (scale - 1.0) / _maxSize;
      _width *= newScale;
      _height *= newScale;
      // puts num within the ranges
      _width = _width.clamp(_minSize, _maxSize);
      _height = _height.clamp(_minSize, _maxSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.item.imageData != null;
    return Positioned(
      top: _itemPosition.dy,
      left: _itemPosition.dx,
      child: _gestureDetector(hasImage),
    );
  }

  GestureDetector _gestureDetector(bool hasImage) {
    return GestureDetector(
      onScaleStart: (details) => _isScaling = true,
      onScaleUpdate: _handleScaleUpdate,
      onScaleEnd: (details) => _isScaling = false,
      child: _itemImage(hasImage),
    );
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _itemPosition += details.focalPointDelta;
      if (_isScaling && details.scale != 1.0) {
        _updateSize(details.scale);
      }
    });
  }

  Widget _itemImage(bool hasImage) {
    return SizedBox(
      width: _width,
      height: _height,
      child: hasImage
          ? Image.memory(widget.item.imageData!, fit: BoxFit.contain)
          : Container(color: getItemBackgroundColor(context)),
    );
  }
}
