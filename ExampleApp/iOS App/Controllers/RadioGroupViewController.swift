//
//  SimpleExampleViewController.swift
//  iOS App
//
//  Created by Alexandr Guzenko on 25.08.2021.
//  Copyright © 2021 alxrguz. All rights reserved.
//


import UIKit
import ALRadioButtons

class RadioGroupViewController: UIViewController {
    
    // MARK: - UIElements
    
    private lazy var contentView: UIView = {
        switch buttomType {
            case .simple(let style):
                return createSimpleView(style: style)
            case .subtitle(let style):
                return createSubtitleView(style: style)
            case .all(let style):
                return createSubtitleAndDetailView(style: style)
        }
    }()
    
    // MARK: - Private properties
    
    private var buttomType: MainViewController.RadioButtonType
    
    // MARK: - Life cycle
    
    init(type: MainViewController.RadioButtonType) {
        self.buttomType = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
}

// MARK: - Setup Layout

private extension RadioGroupViewController {
    func setupColors() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    func createSimpleView(style: ALRadioButtonStyle) -> UIView {
        let contentView = UIView()
        let group1HeaderView = ALHeaderView()
        group1HeaderView.subtitleLabel.text = "Vertical"
        let radioGroup1 = ALRadioGroup(
            items: [.init(title: "Variant 1"),
                    .init(title: "Variant 2"),
                    .init(title: "Variant 3")],
            style: style
        )
        radioGroup1.axis = .vertical
        
        let group2HeaderView = ALHeaderView()
        group2HeaderView.subtitleLabel.text = "Horizontal"
        let radioGroup2 = ALRadioGroup(
            items: [.init(title: "Variant 1"),
                    .init(title: "Variant 2")],
            style: style
        )
        radioGroup2.separatorColor = .clear
        radioGroup2.axis = .horizontal
        
        contentView.addSubview(group1HeaderView)
        contentView.addSubview(radioGroup1)
        contentView.addSubview(group2HeaderView)
        contentView.addSubview(radioGroup2)
        
        group1HeaderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        radioGroup1.snp.makeConstraints {
            $0.top.equalTo(group1HeaderView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        group2HeaderView.snp.makeConstraints {
            $0.top.equalTo(radioGroup1.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        radioGroup2.snp.makeConstraints {
            $0.top.equalTo(group2HeaderView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        return contentView
    }
    
    func createSubtitleView(style: ALRadioButtonStyle) -> UIView {
        return ALRadioGroup(
            items: [.init(title: "Variant 1", subtitle: "Description to the variant"),
                    .init(title: "Variant 2", subtitle: "Description to the variant"),
                    .init(title: "Variant 3", subtitle: "Description to the variant")],
            style: style
        )
    }
    
    func createSubtitleAndDetailView(style: ALRadioButtonStyle) -> UIView {
        return ALRadioGroup(
            items: [.init(title: "Variant 1", subtitle: "Description to the variant", detail: "Detail"),
                    .init(title: "Variant 2", subtitle: "Description to the variant", detail: "Detail"),
                    .init(title: "Variant 3", subtitle: "Description to the variant", detail: "Detail")],
            style: style
        )
    }
    
    func setupView() {
        setupColors()
        
        navigationItem.title = buttomType.title
    }
    
    func setupConstraints() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
