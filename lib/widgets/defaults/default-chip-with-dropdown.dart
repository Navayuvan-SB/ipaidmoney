import 'package:flutter/material.dart';
import 'package:ipaidmoney/widgets/defaults/default-bottom-sheet.dart';

class ChipWithDropdownPopup<T> extends StatefulWidget {
  final T? initialSelectedValue;
  final String? placeholder;
  final List<T> options;
  final String Function(T) renderLabel;
  final Icon? icon;
  final void Function(T)? onChanged;

  const ChipWithDropdownPopup({
    super.key,
    required this.initialSelectedValue,
    required this.options,
    required this.renderLabel,
    this.icon,
    this.onChanged,
    this.placeholder,
  });

  @override
  _ChipWithDropdownPopupState<T> createState() =>
      _ChipWithDropdownPopupState<T>();
}

class _ChipWithDropdownPopupState<T> extends State<ChipWithDropdownPopup<T>> {
  late T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialSelectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Row(
        children: [
          Text(
            _selectedValue != null
                ? widget.renderLabel(_selectedValue!)
                : widget.placeholder ?? "Choose",
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(
            width: 6,
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white70,
            size: 18,
          )
        ],
      ),
      avatar: widget.icon,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white12), // Outline color
        borderRadius: BorderRadius.circular(10), // Border radius
      ),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      onPressed: () {
        _showDropdownPopup(context);
      },
    );
  }

  void _showDropdownPopup(BuildContext context) {
    openDefaultBottomSheet(
      context: context,
      child: Container(
        color: Theme.of(context).dialogBackgroundColor,
        padding: const EdgeInsets.only(
          bottom: 8,
          top: 8,
          left: 12,
          right: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.options.map((option) {
            return ListTile(
              title: Text(widget.renderLabel(option)),
              onTap: () {
                setState(() {
                  _selectedValue = option as T;
                });
                Navigator.pop(context);
                if (widget.onChanged != null && _selectedValue != null) {
                  widget.onChanged!(_selectedValue!);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
