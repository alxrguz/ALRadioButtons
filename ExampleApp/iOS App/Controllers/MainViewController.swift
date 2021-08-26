//
//  ViewController.swift
//
//  Created by Alexandr Guzenko on 17.08.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import ALRadioButtons

class MainViewController: UIViewController {

    // MARK: - UIElements
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Private Properties
    
    let data: [SectionData] = [
        .init(title: "Simple", footer: "Regular radio buttons, no additional information", content: [.simple(style: .standard), .simple(style: .grouped)]),
        .init(title: "Subtitle", footer: "This example contains a description for each radio button", content: [.subtitle(style: .standard), .subtitle(style: .grouped)]),
        .init(title: "Subtitle & Detail", footer: "In addition to the description, detailed information is displayed on the right (like UITableViewCell)", content: [.all(style: .standard), .all(style: .grouped)])
    ]
    
    // MARK: - UIViewController
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let data = self.data[indexPath.section].content[indexPath.row].styleTitle
        cell.textLabel?.text = data
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        data[section].title
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        data[section].footer
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = self.data[indexPath.section].content[indexPath.row]
        let vc = RadioGroupViewController(type: data)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Setup Layout

private extension MainViewController {
    func setupColors() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    func setupView() {
        setupColors()
        
        navigationItem.title = "ALRadioButtons"
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func setupConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Data Structures

extension MainViewController {
    struct SectionData {
        var title: String?
        var footer: String?
        var content: [RadioButtonType]
    }

    enum RadioButtonType {
        case simple(style: ALRadioButtonStyle)
        case subtitle(style: ALRadioButtonStyle)
        case all(style: ALRadioButtonStyle)
        
        var styleTitle: String {
            switch self {
                case .simple(let style), .all(let style), .subtitle(let style):
                    switch style {
                        case .grouped:
                            return "Grouped"
                        case .standard:
                            return "Standart"
                    }
            }
        }
        
        var title: String {
            switch self {
                case .simple(let style):
                    switch style {
                        case .grouped:
                            return "Simple (Grouped)"
                        case .standard:
                            return "Simple (Standart)"
                    }
                case .all(let style):
                    switch style {
                        case .grouped:
                            return "Subtitle & Detail (Grouped)"
                        case .standard:
                            return "Subtitle & Detail (Standart)"
                    }
                case .subtitle(let style):
                    switch style {
                        case .grouped:
                            return "Subtitle (Grouped)"
                        case .standard:
                            return "Subtitle (Standart)"
                    }
            }
        }
    }
}




