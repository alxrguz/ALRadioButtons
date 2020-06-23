//
//  ALRadioGroup.swift
//  Wallet
//
//  Created by Alexandr Guzenko on 21.06.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit

public final class ALRadioGroup: UIControl {
    // MARK: - UI Elements
    private lazy var itemsStackView = UIStackView()
    
    // MARK: - Open Proporties
    public var selectedIndex: Int = -1 {
        didSet {
            item(at: oldValue)?.isSelected = false
            item(at: selectedIndex)?.isSelected = true
        }
    }
    
    public var selectedTitleColor: UIColor = .systemBlue {
        didSet {
            items.forEach { $0.selectedTitleColor = selectedTitleColor }
        }
    }
    
    public var unselectedTitleColor: UIColor = .black {
        didSet {
            items.forEach { $0.unselectedTitleColor = unselectedTitleColor }
        }
    }
    
    public var selectedIndicatorColor: UIColor = .systemBlue {
        didSet {
            items.forEach { $0.selectedIndicatorColor = selectedIndicatorColor }
        }
    }
    
    public var unselectedIndicatorColor: UIColor = .lightGray {
        didSet {
            items.forEach { $0.unselectedIndicatorColor = unselectedIndicatorColor }
        }
    }
    
    public var subtitleColor: UIColor = .lightGray {
        didSet {
            items.forEach { $0.subtitleLabel.textColor = subtitleColor }
        }
    }
    
    public var itemBackgroundColor: UIColor = .clear {
        didSet {
            items.forEach { $0.itemView.backgroundColor = itemBackgroundColor }
        }
    }
    
    public var titleFont: UIFont = .systemFont(ofSize: 16, weight: .medium) {
        didSet {
            items.forEach { $0.titleLabel.font = titleFont }
        }
    }
    
    public var subtitleFont: UIFont = .systemFont(ofSize: 13, weight: .regular) {
        didSet {
            items.forEach { $0.subtitleLabel.font = subtitleFont }
        }
    }
    
    public var cornerRadius: CGFloat = 14 {
        didSet {
            items.forEach { $0.itemView.layer.cornerRadius = cornerRadius }
        }
    }
    
    public var itemHeight: CGFloat = 50 {
        didSet {
            items.forEach {  $0.itemHeight = itemHeight }
        }
    }
    
    public var subtitleTopOffset: CGFloat = 8 {
        didSet {
            items.forEach { $0.subtitleTopOffset = subtitleTopOffset }
        }
    }
    
    public var separatorTopOffset: CGFloat = 8 {
        didSet {
            items.forEach { $0.separatorTopOffset = separatorTopOffset }
        }
    }
    
    public var indicatorRingWidth: CGFloat = 2 {
        didSet {
            items.forEach { $0.radioIndicator.ringWidth = indicatorRingWidth }
        }
    }
    
    public var indicatorRingSize: CGFloat = 22 {
        didSet {
            items.forEach { $0.radioIndicator.size = indicatorRingSize }
        }
    }
    
    public var indicatorCircleInset: CGFloat = 5 {
        didSet {
            items.forEach { $0.radioIndicator.selectedViewInset = indicatorCircleInset }
        }
    }
    
    public var spacing: CGFloat = 15 {
        didSet {
            itemsStackView.spacing = spacing
        }
    }
    
    public var axis: NSLayoutConstraint.Axis = .vertical {
        didSet {
            itemsStackView.axis = axis
            
            switch axis {
            case .horizontal:
                itemsStackView.distribution = .fillEqually
            case .vertical:
                 itemsStackView.distribution = .fill
            @unknown default:
                break
            }
        }
    }
    
    public var hapticResponse: Bool = true
    
    // MARK: - Private Proporties
    private var items: [ALRadioButton] {
        return itemsStackView.arrangedSubviews.compactMap { $0 as? ALRadioButton }
    }
    
    private let haptic = UISelectionFeedbackGenerator()
    
    // MARK: - Life cycle
    public init(items: [ALRadioItem], style: ALRadioGroupStyle = .standard) {
        super.init(frame: .zero)
        setupView(items: items, style: style)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Handlers
private extension ALRadioGroup {
    @objc func radioItemTapped(_ sender: UITapGestureRecognizer) {
        guard let radioItem = (sender.view as? ALRadioButton),
            let index = items.firstIndex(of: radioItem),
            selectedIndex != index else { return }
        
        if hapticResponse { haptic.selectionChanged() }
        selectedIndex = index
        sendActions(for: .valueChanged)
    }
}

// MARK: - Private Methods
private extension ALRadioGroup {
    private func item(at index: Int) -> ALRadioButton? {
        guard index >= 0 && index < itemsStackView.arrangedSubviews.count else { return nil }
        return itemsStackView.arrangedSubviews[index] as? ALRadioButton
    }
}

// MARK: - Layout Setup
private extension ALRadioGroup {
    func setupView(items: [ALRadioItem], style: ALRadioGroupStyle) {
        axis = .vertical
        itemsStackView.spacing = spacing
        
        items.forEach {
            let radioItem = ALRadioButton(item: $0, style: style)
            let tap = UITapGestureRecognizer(target: self, action: #selector(radioItemTapped(_:)))
            self.addGestureRecognizer(tap)
            radioItem.addGestureRecognizer(tap)
            itemsStackView.addArrangedSubview(radioItem)
        }
        
        basicAppearance(style: style)
    }
    
    func basicAppearance(style: ALRadioGroupStyle) {
        switch style {
        case .grouped: groupedAppearance()
        case .standard: standardAppearance()
        }
        
    }
    
    func groupedAppearance() {
        selectedIndicatorColor = .systemBlue
        selectedTitleColor = .systemBlue
        
        if #available(iOS 13.0, *) {
            itemBackgroundColor = .secondarySystemGroupedBackground
            subtitleColor = .secondaryLabel
            unselectedIndicatorColor = .quaternaryLabel
            unselectedTitleColor = .label
        } else {
            itemBackgroundColor = .white
            subtitleColor = .lightGray
            unselectedIndicatorColor = .lightGray
            unselectedTitleColor = .black
        }
        
        titleFont = .systemFont(ofSize: 16, weight: .medium)
        subtitleFont = .systemFont(ofSize: 13, weight: .regular)
        subtitleTopOffset = 8
        cornerRadius = 14
        itemHeight = 50
        
        indicatorRingSize = 22
        indicatorRingWidth = 2
        indicatorCircleInset = 5
    }
    
    func standardAppearance() {
        selectedIndicatorColor = .systemBlue
        selectedTitleColor = .systemBlue
        itemBackgroundColor = .clear
        
        if #available(iOS 13.0, *) {
            subtitleColor = .secondaryLabel
            unselectedIndicatorColor = .quaternaryLabel
            unselectedTitleColor = .label
        } else {
            subtitleColor = .lightGray
            unselectedIndicatorColor = .lightGray
            unselectedTitleColor = .black
        }
        
        titleFont = .systemFont(ofSize: 16, weight: .medium)
        subtitleFont = .systemFont(ofSize: 13, weight: .regular)
        subtitleTopOffset = 0
        cornerRadius = 0
        itemHeight = 30
        separatorTopOffset = 8
        
        indicatorRingSize = 22
        indicatorRingWidth = 2
        indicatorCircleInset = 5
    }
    
    func setupConstraints() {
        addSubview(itemsStackView)
        
        itemsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            itemsStackView.topAnchor.constraint(equalTo: self.topAnchor),
            itemsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            itemsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
