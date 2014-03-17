ALEInlineDatePickerViewController
=================================

View Controller to display a date picker inline in a tableview iOS7 style

  This view controller simplifies the presentation of a date picker inline in a tableview.
  The dates inserted by the user can be accessed with the corresponding date picker's indexPath.
  Must sublclass to use.

  Subclasses MUST do at least 2 things:
  - provide an array of indexPaths from which the date picker can be displayed (datePickerPossibleIndexPaths)
  - call super in the tableview delegate & datasource before their implementation