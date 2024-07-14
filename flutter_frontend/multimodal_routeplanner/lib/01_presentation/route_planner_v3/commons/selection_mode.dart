enum SelectionMode { bicycle, car, publicTransport }

SelectionMode? parseStringToSelectionMode(String? selectionMode) {
  switch (selectionMode) {
    case 'bicycle':
      return SelectionMode.bicycle;
    case 'car':
      return SelectionMode.car;
    case 'publicTransport':
      return SelectionMode.publicTransport;
    default:
      return null;
  }
}
