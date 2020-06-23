//
//  ALRadioButton.swift
//  Wallet
//
//  Created by Alexandr Guzenko on 21.06.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit

public final class ALRadioButton: UIView {
    // MARK: - UI Elements
    
    /// Radio Item title
    public lazy var titleLabel = UILabel()
    
    /// Radio Item subtitle
    public lazy var subtitleLabel = UILabel()
    
    /// Round indicator
    public lazy var radioIndicator = ALRadioIndicator()
    
    /// View which is located `titleLabel` and `radioButton`
    public lazy var itemView = UIView()
    
    /// Horizontal stack for `titleLabel` and `radioButton`
    private lazy var titleStackView = UIStackView()
    
    /// Separator like `tableView` for `standard` style
    private lazy var separatorView = UIView()
    
    // MARK: - Open Proporties
    public var isSelected: Bool = false {
        didSet {
            radioIndicator.isSelected = isSelected
            setupColors()
        }
    }
    
    public var selectedTitleColor: UIColor = .systemBlue {
        didSet {
            setupColors()
        }
    }
    
    public var unselectedTitleColor: UIColor = .black {
        didSet {
            setupColors()
        }
    }
    
    public var selectedIndicatorColor: UIColor = .systemBlue {
        didSet {
            radioIndicator.selectedColor = selectedIndicatorColor
        }
    }
    
    public var unselectedIndicatorColor: UIColor = .systemBlue {
        didSet {
            radioIndicator.unselectedColor = unselectedIndicatorColor
        }
    }
    
    public var separatorColor: UIColor = .lightGray {
        didSet {
            separatorView.backgroundColor = separatorColor
        }
    }
    
    public var itemHeight: CGFloat = 50 {
        didSet {
            itemHeightConstraint?.constant = itemHeight
        }
    }
    
    public var subtitleTopOffset: CGFloat = 8 {
        didSet {
            subtitleOffsetConstraint?.constant = subtitleTopOffset
        }
    }
    
    public var separatorTopOffset: CGFloat = 8 {
        didSet {
            separatorOffsetConstraint?.constant = -separatorTopOffset
        }
    }
    
    // MARK: - Private Proporties
    private var itemHeightConstraint: NSLayoutConstraint?
    private var subtitleOffsetConstraint: NSLayoutConstraint?
    private var separatorOffsetConstraint: NSLayoutConstraint?
    private var style: ALRadioGroupStyle
    
    // MARK: - Life cycle
    init(item: ALRadioItem, style: ALRadioGroupStyle) {
        self.style = style
        super.init(frame: .zero)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout Setup
private extension ALRadioButton {
    func setupColors() {
        titleLabel.textColor = .black
        if isSelected {
            titleLabel.textColor = selectedTitleColor
        } else {
            titleLabel.textColor = unselectedTitleColor
        }
        
        separatorView.backgroundColor = separatorColor
    }
    
    func setupView() {
        setupColors()
        
        layer.masksToBounds = true
        clipsToBounds = true
        
        titleStackView.axis = .horizontal
        titleStackView.alignment = .fill
        titleStackView.spacing = 12
        titleStackView.addArrangedSubview(radioIndicator)
        titleStackView.addArrangedSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        subtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.numberOfLines = 0
    }
    
    func setupConstraints() {
        switch style {
        case .standard: standardStyle()
        case .grouped: groupedStyle()
        }
    }
    
    func standardStyle() {
        addSubview(itemView)
        itemView.addSubview(titleStackView)
        
        itemHeightConstraint = itemView.heightAnchor.constraint(equalToConstant: itemHeight)
        itemView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemHeightConstraint!,
            itemView.topAnchor.constraint(equalTo: self.topAnchor),
            itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleStackView.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor),
        ])
        
        if subtitleLabel.text != nil {
            addSubview(subtitleLabel)
            subtitleOffsetConstraint = subtitleLabel.topAnchor.constraint(equalTo: itemView.bottomAnchor, constant: subtitleTopOffset)
            separatorOffsetConstraint = subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -separatorTopOffset)
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                subtitleOffsetConstraint!,
                subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                separatorOffsetConstraint!
            ])
        } else {
            separatorOffsetConstraint = itemView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -separatorTopOffset)
            separatorOffsetConstraint?.isActive = true
        }
        
        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func groupedStyle() {
        addSubview(itemView)
        itemView.addSubview(titleStackView)
        
        itemHeightConstraint = itemView.heightAnchor.constraint(equalToConstant: itemHeight)
        itemView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemHeightConstraint!,
            itemView.topAnchor.constraint(equalTo: self.topAnchor),
            itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            itemView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor)
        ])
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleStackView.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 15),
            titleStackView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -15),
        ])
        
        if subtitleLabel.text != nil {
            addSubview(subtitleLabel)
            
            subtitleOffsetConstraint = subtitleLabel.topAnchor.constraint(equalTo: itemView.bottomAnchor, constant: subtitleTopOffset)
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                subtitleOffsetConstraint!,
                subtitleLabel.leadingAnchor.constraint(equalTo: radioIndicator.leadingAnchor),
                subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
    }
}
