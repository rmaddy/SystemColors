//
//  ViewController.swift
//  SystemColors
//
//  Created by Richard W Maddy on 6/4/19.
//  Copyright © 2019 Richard W Maddy. All rights reserved.
//

import UIKit

struct Section {
    let name: String
    let colors: [Color]
}

struct Color {
    let name: String
    let color: UIColor
}

enum SelectionMode {
    case cell
    case accessory
    case table
}

class ViewController: UIViewController {
    var sections = [Section]()
    var currentCellBGColor: UIColor
    var selectionMode = SelectionMode.cell
    var plainTableView: UITableView!
    var groupedTableView: UITableView!

    func loadColors() {
        var colors = [Color]()
        if #available(iOS 13.0, *) {
            colors.append(Color(name: "labelColor", color: UIColor.label))
            colors.append(Color(name: "secondaryLabelColor", color: UIColor.secondaryLabel))
            colors.append(Color(name: "tertiaryLabelColor", color: UIColor.tertiaryLabel))
            colors.append(Color(name: "quaternaryLabelColor", color: UIColor.quaternaryLabel))
            colors.append(Color(name: "systemFillColor", color: UIColor.systemFill))
            colors.append(Color(name: "secondarySystemFillColor", color: UIColor.secondarySystemFill))
            colors.append(Color(name: "tertiarySystemFillColor", color: UIColor.tertiarySystemFill))
            colors.append(Color(name: "quaternarySystemFillColor", color: UIColor.quaternarySystemFill))
            colors.append(Color(name: "placeholderTextColor", color: UIColor.placeholderText))
            colors.append(Color(name: "systemBackgroundColor", color: UIColor.systemBackground))
            colors.append(Color(name: "secondarySystemBackgroundColor", color: UIColor.secondarySystemBackground))
            colors.append(Color(name: "tertiarySystemBackgroundColor", color: UIColor.tertiarySystemBackground))
            colors.append(Color(name: "systemGroupedBackgroundColor", color: UIColor.systemGroupedBackground))
            colors.append(Color(name: "secondarySystemGroupedBackgroundColor", color: UIColor.secondarySystemGroupedBackground))
            colors.append(Color(name: "tertiarySystemGroupedBackgroundColor", color: UIColor.tertiarySystemGroupedBackground))
            colors.append(Color(name: "separatorColor", color: UIColor.separator))
            colors.append(Color(name: "opaqueSeparatorColor", color: UIColor.opaqueSeparator))
            colors.append(Color(name: "linkColor", color: UIColor.link))
        }
        colors.append(Color(name: "darkTextColor", color: UIColor.darkText))
        colors.append(Color(name: "lightTextColor", color: UIColor.lightText))

        sections.append(Section(name: "UI Element Colors", colors: colors))

        colors = [Color]()
        colors.append(Color(name: "systemBlueColor", color: UIColor.systemBlue))
        //colors.append(Color(name: "systemBrownColor", color: UIColor.systemBrown)) // Removed from iOS 13b3 or b4?
        colors.append(Color(name: "systemGreenColor", color: UIColor.systemGreen))
        if #available(iOS 13.0, *) {
            colors.append(Color(name: "systemIndigoColor", color: UIColor.systemIndigo))
        }
        colors.append(Color(name: "systemOrangeColor", color: UIColor.systemOrange))
        colors.append(Color(name: "systemPinkColor", color: UIColor.systemPink))
        colors.append(Color(name: "systemPurpleColor", color: UIColor.systemPurple))
        colors.append(Color(name: "systemRedColor", color: UIColor.systemRed))
        colors.append(Color(name: "systemTealColor", color: UIColor.systemTeal))
        colors.append(Color(name: "systemYellowColor", color: UIColor.systemYellow))
        colors.append(Color(name: "systemGrayColor", color: UIColor.systemGray))
        if #available(iOS 13.0, *) {
            colors.append(Color(name: "systemGray2Color", color: UIColor.systemGray2))
            colors.append(Color(name: "systemGray3Color", color: UIColor.systemGray3))
            colors.append(Color(name: "systemGray4Color", color: UIColor.systemGray4))
            colors.append(Color(name: "systemGray5Color", color: UIColor.systemGray5))
            colors.append(Color(name: "systemGray6Color", color: UIColor.systemGray6))
        }

        sections.append(Section(name: "Standard System Colors", colors: colors))

        sections.append(Section(name: "Standard Fixed Colors", colors: [
            Color(name: "blackColor", color: UIColor.black),
            Color(name: "blueColor", color: UIColor.blue),
            Color(name: "brownColor", color: UIColor.brown),
            Color(name: "cyanColor", color: UIColor.cyan),
            Color(name: "darkGrayColor", color: UIColor.darkGray),
            Color(name: "grayColor", color: UIColor.gray),
            Color(name: "greenColor", color: UIColor.green),
            Color(name: "lightGrayColor", color: UIColor.lightGray),
            Color(name: "magentaColor", color: UIColor.magenta),
            Color(name: "orangeColor", color: UIColor.orange),
            Color(name: "purpleColor", color: UIColor.purple),
            Color(name: "redColor", color: UIColor.red),
            Color(name: "whiteColor", color: UIColor.white),
            Color(name: "yellowColor", color: UIColor.yellow),
        ]))
    }

    init() {
        if #available(iOS 13.0, *) {
            currentCellBGColor = .systemBackground
        } else {
            currentCellBGColor = .black
        }

        super.init(nibName: nil, bundle: nil)

        loadColors()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Change light/dark mode
    @available(iOS 13.0, *)
    @objc func traitMode(_ segement: UISegmentedControl) {
        switch segement.selectedSegmentIndex {
        case 0:
            view.window!.overrideUserInterfaceStyle = .unspecified
        case 1:
            view.window!.overrideUserInterfaceStyle = .light
        case 2:
            view.window!.overrideUserInterfaceStyle = .dark
        default:
            break
        }

        // Even though the colors update automatically, the reload is done to update the color code shown in each row
        DispatchQueue.main.async {
            self.plainTableView.reloadData()
            self.groupedTableView.reloadData()
        }
    }

    // Keep track of which feature to change when a row is selected
    @objc func changeMode(_ segement: UISegmentedControl) {
        switch segement.selectedSegmentIndex {
        case 0:
            selectionMode = .cell
        case 1:
            selectionMode = .accessory
        case 2:
            selectionMode = .table
        default:
            break
        }
    }

    // Show a new scene window
    @available(iOS 13.0, *)
    @objc func newAction() {
        UIApplication.shared.requestSceneSessionActivation(nil, userActivity: nil, options: nil, errorHandler: nil)
    }

    // Handle the selection of the table view to display
    @objc func changeType(_ segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            plainTableView.isHidden = false
            groupedTableView.isHidden = true
        case 1:
            plainTableView.isHidden = true
            groupedTableView.isHidden = false
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the two table views, one plain, one grouped
        plainTableView = UITableView(frame: view.bounds, style: .plain)
        plainTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        plainTableView.delegate = self
        plainTableView.dataSource = self

        groupedTableView = UITableView(frame: view.bounds, style: .grouped)
        groupedTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        groupedTableView.delegate = self
        groupedTableView.dataSource = self

        view.addSubview(groupedTableView)
        view.addSubview(plainTableView)
        groupedTableView.isHidden = true

        // Set some initial background colors
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
            plainTableView.backgroundColor = .systemBackground
            groupedTableView.backgroundColor = .systemGroupedBackground
        } else {
            view.backgroundColor = .white
            plainTableView.backgroundColor = .white
            groupedTableView.backgroundColor = .white
        }

        // Add the option to change between automatic, light, and dark modes.
        if #available(iOS 13.0, *) {
            let segments = UISegmentedControl(items: [ "Auto", "Light", "Dark"])
            segments.selectedSegmentIndex = 0
            segments.addTarget(self, action: #selector(traitMode), for: .valueChanged)
            let left = UIBarButtonItem(customView: segments)
            navigationItem.leftBarButtonItem = left
        }

        // Segment to indicate what feature is changed when a row is selected
        let segMode = UISegmentedControl(items: [ "Cell", "Tint", "Table" ])
        segMode.selectedSegmentIndex = 0
        segMode.addTarget(self, action: #selector(changeMode), for: .valueChanged)
        let left = UIBarButtonItem(customView: segMode)
        navigationItem.rightBarButtonItem = left

        navigationController?.setToolbarHidden(false, animated: false)

        // Toggle between showing the plain or grouped table
        let segType = UISegmentedControl(items: [ "Plain", "Group"])
        segType.selectedSegmentIndex = 0
        segType.addTarget(self, action: #selector(changeType), for: .valueChanged)

        let btnType = UIBarButtonItem(customView: segType)
        var items = [ btnType ]

        // Add a New button if the device supports multiple window scenes
        if #available(iOS 13.0, *) {
            if UIApplication.shared.supportsMultipleScenes {
                let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let new = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(newAction))
                items.append(flex)
                items.append(new)
            }
        }

        toolbarItems = items
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].colors.count
    }

    func effective(table: UITableView, bg: UIColor, fg: UIColor) -> UIColor {
        let effective = UIColor.combine(colors: [ self.view.backgroundColor!, table.backgroundColor!, bg, fg ])

        return effective
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")

        // Get the specific color for this row
        let color = sections[indexPath.section].colors[indexPath.row]

        // Get the color's name. Then append any indicators of this is one of the chosen colors
        var name = color.name
        if color.color == currentCellBGColor {
            name += " (cell)"
        }
        if color.color == view.tintColor {
            name += " (tint)"
        }
        if color.color == tableView.backgroundColor {
            name += " (table)"
        }
        cell.textLabel?.text = name

        // Generate the resulting color of drawing the content view color, cell background color, table view background color, and the view controller view color
        let effective = self.effective(table: tableView, bg: currentCellBGColor, fg: color.color)
        if effective == color.color {
            // We get here if the row's main color has no alpha. Just show that color's hex code
            cell.detailTextLabel?.text = color.color.hexCode()
        } else {
            // We get here if the row's main color has alpha. Show the color's hex code and the effective color's hex code.
            cell.detailTextLabel?.text = "\(color.color.hexCode()) - \(effective.hexCode())"
        }

        // Cycle through the different accessory types just so we can see them all.
        cell.accessoryType = [ UITableViewCell.AccessoryType.none, .disclosureIndicator, .detailDisclosureButton, .checkmark, .detailButton][indexPath.row % 5]

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Get the specific color for this row
        let color = sections[indexPath.section].colors[indexPath.row]

        // Set the cell's background color to the chosen color
        cell.backgroundColor = currentCellBGColor
        // Set the cell's content view's background color to the specific row color
        cell.contentView.backgroundColor = color.color

        // Generate the resulting color of drawing the content view color, cell background color, table view background color, and the view controller view color
        // Then based on whether that effective color is light or dark, set the cell text color so it is readable.
        let effective = self.effective(table: tableView, bg: currentCellBGColor, fg: color.color)
        let light = effective.isLightColor
        cell.textLabel?.textColor = light ? .darkText : .lightText
        cell.detailTextLabel?.textColor = light ? .darkText : .lightText
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected color
        let color = sections[indexPath.section].colors[indexPath.row]

        switch selectionMode {
        case .cell:
            // Update the background color of the cells
            currentCellBGColor = color.color
        case .accessory:
            // Update the tint color - affects the accessory views
            view.tintColor = color.color
        case .table:
            // Update the background of the table view. More visble in the grouped table
            plainTableView.backgroundColor = color.color
            groupedTableView.backgroundColor = color.color
        }

        tableView.deselectRow(at: indexPath, animated: true)

        plainTableView.reloadData()
        groupedTableView.reloadData()
    }
}
