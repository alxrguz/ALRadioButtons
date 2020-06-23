// The MIT License (MIT)
//
// Copyright (c) 2020 Alexandr Guzenko (alxrguz@icloud.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
    
    /**
        button state
    */
    public var isSelected: Bool = false {
        didSet {
            radioIndicator.isSelected = isSelected
            setupColors()
        }
    }
    
    /**
        `titleLabel` color when button selected
    */
    public var selectedTitleColor: UIColor = .systemBlue {
        didSet {
            setupColors()
        }
    }
    
    /**
        `titleLabel` color when button unselected
    */
    public var unselectedTitleColor: UIColor = .black {
        didSet {
            setupColors()
        }
    }
    
    /**
        `radioIndicator` color when button selected
    */
    public var selectedIndicatorColor: UIColor = .systemBlue {
        didSet {
            radioIndicator.selectedColor = selectedIndicatorColor
        }
    }
    
    /**
        `radioIndicator` color when button unselected
    */
    public var unselectedIndicatorColor: UIColor = .systemBlue {
        didSet {
            radioIndicator.unselectedColor = unselectedIndicatorColor
        }
    }
    
    /**
        Separator color

        - Note: Actual for `ALRadioButtonStyle.standard` style
    */
    public var separatorColor: UIColor = .lightGray {
        didSet {
            separatorView.backgroundColor = separatorColor
        }
    }
    
    /**
        View height at which indicator and title are located, subtitle is not included here
    */
    public var buttonHeight: CGFloat = 50 {
        didSet {
            itemHeightConstraint?.constant = buttonHeight
        }
    }
    
    /**
        `subtitleLabel` offset from title bottom anchor
    */
    public var subtitleTopOffset: CGFloat = 8 {
        didSet {
            subtitleOffsetConstraint?.constant = subtitleTopOffset
        }
    }
    
    /**
        separator offset from title or subtitle (if added) bottom anchor
        
        - Note: Actual for `ALRadioButtonStyle.standard` style
    */
    public var separatorTopOffset: CGFloat = 8 {
        didSet {
            separatorOffsetConstraint?.constant = -separatorTopOffset
        }
    }
    
    // MARK: - Private Proporties
    private var itemHeightConstraint: NSLayoutConstraint?
    private var subtitleOffsetConstraint: NSLayoutConstraint?
    private var separatorOffsetConstraint: NSLayoutConstraint?
    private var style: ALRadioButtonStyle
    
    // MARK: - Life cycle
    public init(item: ALRadioItem, style: ALRadioButtonStyle) {
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
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
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
        
        itemHeightConstraint = itemView.heightAnchor.constraint(equalToConstant: buttonHeight)
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
        
        itemHeightConstraint = itemView.heightAnchor.constraint(equalToConstant: buttonHeight)
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
