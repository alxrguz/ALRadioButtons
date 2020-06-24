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


/// `UIControl` element that combines `ALRadioButton` in a group.
public final class ALRadioGroup: UIControl {
    // MARK: - UI Elements
    private lazy var itemsStackView = UIStackView()
    
    // MARK: - Open Proporties
    
    /**
        Index of selected item
     
        Default is -1
     
        - Note: If you do not set this value, then no item from the group will be selected
     */
    public var selectedIndex: Int = -1 {
        didSet {
            item(at: oldValue)?.isSelected = false
            item(at: selectedIndex)?.isSelected = true
        }
    }
    
    /**
        Title color if `ALRadioButton` is selected
    */
    public var selectedTitleColor: UIColor = .systemBlue {
        didSet {
            items.forEach { $0.selectedTitleColor = selectedTitleColor }
        }
    }
    
    /**
        Title color if `ALRadioButton` is unselected
    */
    public var unselectedTitleColor: UIColor = .black {
        didSet {
            items.forEach { $0.unselectedTitleColor = unselectedTitleColor }
        }
    }
    
    /**
        Indicator (round ring with dot at center) color if `ALRadioButton` is selected
    */
    public var selectedIndicatorColor: UIColor = .systemBlue {
        didSet {
            items.forEach { $0.selectedIndicatorColor = selectedIndicatorColor }
        }
    }
    
    /**
        Indicator (round ring with dot at center) color if `ALRadioButton` is unselected
    */
    public var unselectedIndicatorColor: UIColor = .lightGray {
        didSet {
            items.forEach { $0.unselectedIndicatorColor = unselectedIndicatorColor }
        }
    }
    
    /**
        `ALRadioButton` subtitle color
    */
    public var subtitleColor: UIColor = .lightGray {
        didSet {
            items.forEach { $0.subtitleLabel.textColor = subtitleColor }
        }
    }
    
    /**
        `ALRadioButton` background color
     
        - Note: Actual for `ALRadioButtonStyle.grouped` style
    */
    public var buttonBackgroundColor: UIColor = .clear {
        didSet {
            items.forEach { $0.itemView.backgroundColor = buttonBackgroundColor }
        }
    }
    
    /**
        Separator color

        - Note: Actual for `ALRadioButtonStyle.standard` style
    */
    public var separatorColor: UIColor = .lightGray {
        didSet {
            let lastItem = items.last
            items.forEach {
                $0.separatorColor = $0 == lastItem ? .clear : separatorColor
            }
        }
    }
    
    /**
        `ALRadioButton` title font
    */
    public var titleFont: UIFont = .systemFont(ofSize: 16, weight: .medium) {
        didSet {
            items.forEach { $0.titleLabel.font = titleFont }
        }
    }
    
    /**
        `ALRadioButton` subtitle font
    */
    public var subtitleFont: UIFont = .systemFont(ofSize: 13, weight: .regular) {
        didSet {
            items.forEach { $0.subtitleLabel.font = subtitleFont }
        }
    }
    
    /**
        `ALRadioButton` corner radius
     
        - Note: Actual for `ALRadioButtonStyle.grouped` style
    */
    public var cornerRadius: CGFloat = 14 {
        didSet {
            items.forEach { $0.itemView.layer.cornerRadius = cornerRadius }
        }
    }
    
    /**
        `ALRadioButton` height
     
        - Note: View height at which indicator and title are located, subtitle is not included here
    */
    public var buttonHeight: CGFloat = 50 {
        didSet {
            items.forEach {  $0.buttonHeight = buttonHeight }
        }
    }
    
    /**
        `ALRadioButton` subtitle offset from title bottom anchor
    */
    public var subtitleTopOffset: CGFloat = 8 {
        didSet {
            items.forEach { $0.subtitleTopOffset = subtitleTopOffset }
        }
    }
    
    /**
        `ALRadioButton` separator offset from title or subtitle (if added) bottom anchor
        
        - Note: Actual for `ALRadioButtonStyle.standard` style
    */
    public var separatorTopOffset: CGFloat = 8 {
        didSet {
            items.forEach { $0.separatorTopOffset = separatorTopOffset }
        }
    }
    
    /**
        Outer ring width of indicator
    */
    public var indicatorRingWidth: CGFloat = 2 {
        didSet {
            items.forEach { $0.radioIndicator.ringWidth = indicatorRingWidth }
        }
    }
    
    /**
       Indicator outer ring size
    */
    public var indicatorRingSize: CGFloat = 22 {
        didSet {
            items.forEach { $0.radioIndicator.size = indicatorRingSize }
        }
    }
    
    /**
       Indentation of the circle from the outer ring
    */
    public var indicatorCircleInset: CGFloat = 5 {
        didSet {
            items.forEach { $0.radioIndicator.selectedViewInset = indicatorCircleInset }
        }
    }
    
    /**
        `ALRadioButton` spacing
    */
    public var spacing: CGFloat = 15 {
        didSet {
            itemsStackView.spacing = spacing
        }
    }
    
    /**
        The axis on which the `ALRadioButton` are located
     */
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
    
    /**
        Haptic response when user clicks a button
    */
    public var hapticResponse: Bool = true
    
    // MARK: - Private Proporties
    private var items: [ALRadioButton] {
        return itemsStackView.arrangedSubviews.compactMap { $0 as? ALRadioButton }
    }
    
    private let haptic = UISelectionFeedbackGenerator()
    
    // MARK: - Life cycle
    
    /// `ALRadioGroup` init
    /// - Parameters:
    ///   - items: Array of `ALRadioItem`, one `ALRadioItem` is equivalent to one `ALRadioButton`
    ///   - style: `ALRadioButton` style
    public init(items: [ALRadioItem], style: ALRadioButtonStyle = .standard) {
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
    func setupView(items: [ALRadioItem], style: ALRadioButtonStyle) {
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
    
    func basicAppearance(style: ALRadioButtonStyle) {
        switch style {
        case .grouped: groupedAppearance()
        case .standard: standardAppearance()
        }
        
    }
    
    func groupedAppearance() {
        selectedIndicatorColor = .systemBlue
        selectedTitleColor = .systemBlue
        
        if #available(iOS 13.0, *) {
            buttonBackgroundColor = .secondarySystemGroupedBackground
            subtitleColor = .secondaryLabel
            unselectedIndicatorColor = .quaternaryLabel
            unselectedTitleColor = .label
        } else {
            buttonBackgroundColor = .white
            subtitleColor = .lightGray
            unselectedIndicatorColor = .lightGray
            unselectedTitleColor = .black
        }
        
        titleFont = .systemFont(ofSize: 16, weight: .medium)
        subtitleFont = .systemFont(ofSize: 13, weight: .regular)
        subtitleTopOffset = 8
        cornerRadius = 14
        buttonHeight = 50
        
        indicatorRingSize = 22
        indicatorRingWidth = 2
        indicatorCircleInset = 5
    }
    
    func standardAppearance() {
        selectedIndicatorColor = .systemBlue
        selectedTitleColor = .systemBlue
        buttonBackgroundColor = .clear
        
        if #available(iOS 13.0, *) {
            subtitleColor = .secondaryLabel
            unselectedIndicatorColor = .quaternaryLabel
            separatorColor = .quaternaryLabel
            unselectedTitleColor = .label
        } else {
            subtitleColor = .lightGray
            unselectedIndicatorColor = .lightGray
            unselectedTitleColor = .black
            separatorColor = .lightGray
        }
        
        titleFont = .systemFont(ofSize: 16, weight: .medium)
        subtitleFont = .systemFont(ofSize: 13, weight: .regular)
        subtitleTopOffset = 0
        cornerRadius = 0
        buttonHeight = 30
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
