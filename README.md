# SystemColors
iOS app that shows all of the provided colors from UIColor in a table view. Supports light and dark mode. Supports multiple window scenes on iPads running iOS 13.

This app runs on iOS 10 and later. It's more useful under iOS 13 and later since it shows a lot more colors, supports light and dark mode, and allows multiple windows on supported devices.

Load this project into Xcode 11 or later. Build and run against any iOS device or simulator running iOS 10 or later.

You will see a table view will lots of colors. The table view is broken into three sections:

- UI Element Colors
- Standard System Colors
- Standard Fixed Colors

Each section has the appropriate set of colors from UIColor.

Each row uses the color for the cell's contentView background color. The cell's title gives the name of the color.
The cell's subtitle gives the hexcode for the color in #RRGGBBAA format.
If the color has not fully opaque then two hex codes are shown.
The first for the color and the second representing the actual color after show the color over the content view color,
cell background color, and finally the view controller view background color.

If run under iOS 13 or later, the top-left corner contains a segmented control with three options: Auto, Light, and Dark.
Auto shows the colors in whatever mode is chosen in the Settings app. Light and Dark force that mode for the app.

In the bottom-left corner is another segmented control that lets you toggle between a plain table and a grouped table.
Both tables show the exact same colors. The only difference is how the section headers are shown.

In the top-right corner is another segmented control containing Cell, Tint, and Table.
Selecting a row in the table view will update the color associated with the selected segment.

If Cell is selected, then the selected color changes `cell.backgroundColor` for all rows in the table view.
This color can be seen at the far right end of each row where the accessory views are.

If Tint is selected, then the selected color sets `view.tintColor` which results in the color be applied to the accessory views.

If Table is selected, then the selected color sets `tableView.backgroundColor`. 
In the plain table view, this color has little affect. It can be seen before the first row and after the last row.
It also affects the resulting row colors only for rows that are not fully opaque.
In the grouped table view you can see the background color around each of the section headers.

If run under iOS 13 or later and on a device/simulator that supports multiple windows, you will a button labeled New in the bottom-right corner.
Tapping this buttons open a new window scene. A primary use of this is to show two windows side by side.
You can set one for light mode and the other for dark mode allowing you to compare the two sets of colors.
Or you can set different colors for for Cell, Tint, and Table as desired.
