import 'package:data_visualization/presentation/style/theme/app_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorChip extends StatefulWidget {
  final Color color;
  final void Function(Color) onColorChanged;

  const ColorChip({super.key, required this.color, required this.onColorChanged});

  @override
  State<ColorChip> createState() => _ColorChipState();
}

class _ColorChipState extends State<ColorChip> {
  late Color color;

  @override
  void initState() {
    super.initState();
    color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: widget.color,
                onColorChanged: (newColor) {
                  setState(() => color = newColor);
                },
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  widget.onColorChanged(color);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
          border: Border.all(
            color: context.colors.foreground,
            width: 2,
          ),
        ),
      ),
    );
  }
}
