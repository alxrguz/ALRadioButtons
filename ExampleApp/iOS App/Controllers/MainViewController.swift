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
    private lazy var scrollView = ALScrollView()
    
    private lazy var group1HeaderView = ALHeaderView()
    private lazy var radioGroup1 = ALRadioGroup(
        items: [.init(title: "Variant 1"),
                .init(title: "Variant 2")],
        style: .grouped
    )
    
    private lazy var group2HeaderView = ALHeaderView()
    private lazy var radioGroup2 = ALRadioGroup(
        items: [.init(title: "Variant 1"),
                .init(title: "Variant 2")],
        style: .grouped
    )
    
    private lazy var group3HeaderView = ALHeaderView()
    private lazy var radioGroup3 = ALRadioGroup(
        items: [.init(title: "Variant 1"),
                .init(title: "Variant 2")],
        style: .standard
    )
    
    private lazy var group4HeaderView = ALHeaderView()
    private lazy var radioGroup4 = ALRadioGroup(
        items: [.init(title: "Variant 1"),
                .init(title: "Variant 2")],
        style: .standard
    )
    
    private lazy var group5HeaderView = ALHeaderView()
    private lazy var radioGroup5 = ALRadioGroup(
        items: [.init(title: "Variant 1", subtitle: "Detailed description of the option"),
                .init(title: "Variant 2", subtitle: "Detailed description of the option")],
        style: .grouped
    )
    
    private lazy var group6HeaderView = ALHeaderView()
    private lazy var radioGroup6 = ALRadioGroup(
        items: [.init(title: "Variant 1", subtitle: "Detailed description of the option"),
                .init(title: "Variant 2", subtitle: "Detailed description of the option")],
        style: .standard
    )
    
    private lazy var group7HeaderView = ALHeaderView()
    private lazy var radioGroup7 = ALRadioGroup(
        items: [.init(title: "Variant 1", subtitle: "Description to the variant", detail: "Detail"),
                .init(title: "Variant 2", subtitle: "Description to the variant", detail: "Detail")],
        style: .grouped
    )
    
    private lazy var group8HeaderView = ALHeaderView()
    private lazy var radioGroup8 = ALRadioGroup(
        items: [.init(title: "Variant 1", subtitle: "Description to the variant", detail: "Detail"),
                .init(title: "Variant 2", subtitle: "Description to the variant", detail: "Detail")],
        style: .standard
    )
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
}

// MARK: - Setup Layout

private extension MainViewController {
    func setupColors() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    func setupView() {
        setupColors()
        
        scrollView.alwaysBounceVertical = true
        
        group1HeaderView.titleLabel.text = "Simple"
        group1HeaderView.subtitleLabel.text = "Grouped, Vertical"
        
        group2HeaderView.subtitleLabel.text = "Grouped, Horizontal"
        radioGroup2.axis = .horizontal
        
        group3HeaderView.subtitleLabel.text = "Standart, Vertical"
        
        group4HeaderView.subtitleLabel.text = "Standart, Horizontal"
        radioGroup4.axis = .horizontal
        radioGroup4.separatorColor = .clear
        
        group5HeaderView.titleLabel.text = "With subtitle"
        group5HeaderView.subtitleLabel.text = "Grouped, Vertical"
        
        group6HeaderView.subtitleLabel.text = "Standart, Vertical"
        
        group7HeaderView.titleLabel.text = "With Subtitle & Detail"
        group7HeaderView.subtitleLabel.text = "Grouped, Vertical"
        
        group8HeaderView.subtitleLabel.text = "Standart, Vertical"
        
    }
    
    func setupConstraints() {
        view.addSubview(scrollView)
        
        scrollView.contentView.addSubview(group1HeaderView)
        scrollView.contentView.addSubview(radioGroup1)
        
        scrollView.contentView.addSubview(group2HeaderView)
        scrollView.contentView.addSubview(radioGroup2)
        
        scrollView.contentView.addSubview(group3HeaderView)
        scrollView.contentView.addSubview(radioGroup3)
        
        scrollView.contentView.addSubview(group4HeaderView)
        scrollView.contentView.addSubview(radioGroup4)
        
        scrollView.contentView.addSubview(group5HeaderView)
        scrollView.contentView.addSubview(radioGroup5)

        scrollView.contentView.addSubview(group6HeaderView)
        scrollView.contentView.addSubview(radioGroup6)

        scrollView.contentView.addSubview(group7HeaderView)
        scrollView.contentView.addSubview(radioGroup7)
        
        scrollView.contentView.addSubview(group8HeaderView)
        scrollView.contentView.addSubview(radioGroup8)

        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let safeArea = scrollView.contentView.safeAreaLayoutGuide
        let sectionOffset = 50
        let subSectionOffset = 25
        let sideOffset = 16
        
        group1HeaderView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }
    
        radioGroup1.snp.makeConstraints {
            $0.top.equalTo(group1HeaderView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }
        
        group2HeaderView.snp.makeConstraints {
            $0.top.equalTo(radioGroup1.snp.bottom).offset(subSectionOffset)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }
        
        radioGroup2.snp.makeConstraints {
            $0.top.equalTo(group2HeaderView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }
        
        group3HeaderView.snp.makeConstraints {
            $0.top.equalTo(radioGroup2.snp.bottom).offset(subSectionOffset)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }
        
        radioGroup3.snp.makeConstraints {
            $0.top.equalTo(group3HeaderView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }
        
        group4HeaderView.snp.makeConstraints {
            $0.top.equalTo(radioGroup3.snp.bottom).offset(subSectionOffset)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }
        
        radioGroup4.snp.makeConstraints {
            $0.top.equalTo(group4HeaderView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }
        
        group5HeaderView.snp.makeConstraints {
            $0.top.equalTo(radioGroup4.snp.bottom).offset(sectionOffset)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }

        radioGroup5.snp.makeConstraints {
            $0.top.equalTo(group5HeaderView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }

        group6HeaderView.snp.makeConstraints {
            $0.top.equalTo(radioGroup5.snp.bottom).offset(subSectionOffset)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }

        radioGroup6.snp.makeConstraints {
            $0.top.equalTo(group6HeaderView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }

        group7HeaderView.snp.makeConstraints {
            $0.top.equalTo(radioGroup6.snp.bottom).offset(sectionOffset)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }

        radioGroup7.snp.makeConstraints {
            $0.top.equalTo(group7HeaderView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }
        
        group8HeaderView.snp.makeConstraints {
            $0.top.equalTo(radioGroup7.snp.bottom).offset(subSectionOffset)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
        }

        radioGroup8.snp.makeConstraints {
            $0.top.equalTo(group8HeaderView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(safeArea).inset(sideOffset)
            $0.bottom.equalToSuperview()
        }
    }
}
