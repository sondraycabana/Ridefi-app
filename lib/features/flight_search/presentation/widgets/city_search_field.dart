import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/flight_search_notifier.dart';

class CitySearchField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;

  const CitySearchField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
  });

  @override
  ConsumerState<CitySearchField> createState() => _CitySearchFieldState();
}

class _CitySearchFieldState extends ConsumerState<CitySearchField> {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onTextChanged() {
    final query = widget.controller.text;
    if (query.isNotEmpty) {
      ref.read(citiesSearchProvider.notifier).searchCities(query);
      _showOverlay();
    } else {
      ref.read(citiesSearchProvider.notifier).clearResults();
      _removeOverlay();
    }
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _removeOverlay();
      });
    }
  }

  void _showOverlay() {
    _removeOverlay();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: Consumer(
              builder: (context, ref, child) {
                final citiesState = ref.watch(citiesSearchProvider);
                
                if (citiesState.status == CitiesSearchStatus.loading) {
                  return Container(
                    height: 50,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                
                if (citiesState.status == CitiesSearchStatus.error) {
                  return Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Error: ${citiesState.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
                
                if (citiesState.cities.isEmpty) {
                  return Container(
                    height: 50,
                    child: const Center(child: Text('No cities found')),
                  );
                }
                
                return Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: citiesState.cities.length,
                    itemBuilder: (context, index) {
                      final city = citiesState.cities[index];
                      return ListTile(
                        title: Text(city.name),
                        subtitle: Text('${city.code} - ${city.country}'),
                        onTap: () {
                          widget.controller.text = city.name;
                          _removeOverlay();
                          _focusNode.unfocus();
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.location_on),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}