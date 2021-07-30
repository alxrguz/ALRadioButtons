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

public final class ALRadioIndicator: UIView {
    // MARK: - UI Elements
    private lazy var selectedView = UIView()
    
    // MARK: - Open Proporties
    public var isSelected: Bool = false {
        didSet {
            setupColors()
        }
    }
    
    public var selectedColor: UIColor = .systemBlue {
        didSet {
            setupColors()
        }
    }
    
    public var unselectedColor: UIColor = .lightGray {
        didSet {
            setupColors()
        }
    }
    
   public var ringWidth: CGFloat = 2 {
        didSet {
            layer.borderWidth = ringWidth
        }
    }
    
    public var size: CGFloat = 22 {
        didSet {
            outRingHeightConstraint?.constant = size
            outRingWidthConstraint?.constant = size
        }
    }
    
    public var selectedViewInset: CGFloat = 5 {
        didSet {
            let selectedViewSize = size - selectedViewInset * 2
            selectedViewWidthConstraint?.constant = selectedViewSize
            selectedViewHeightConstraint?.constant = selectedViewSize
        }
    }
    
    // MARK: - Private Proporties
    var outRingHeightConstraint: NSLayoutConstraint?
    var outRingWidthConstraint: NSLayoutConstraint?
    var selectedViewWidthConstraint: NSLayoutConstraint?
    var selectedViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Life cycle
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupFrame()
    }
}


// MARK: - Layout Setup
private extension ALRadioIndicator {
    func setupColors() {
        if isSelected {
            layer.borderColor = selectedColor.cgColor
            selectedView.backgroundColor = selectedColor
        } else {
            layer.borderColor = unselectedColor.cgColor
            selectedView.backgroundColor = .clear
        }
    }
    
    func setupView() {
        setupColors()
        layer.borderWidth = ringWidth
    }
    
    func setupFrame() {
        selectedView.layer.cornerRadius = selectedView.frame.height / 2
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        outRingHeightConstraint = self.heightAnchor.constraint(equalToConstant: size)
        outRingWidthConstraint = self.widthAnchor.constraint(equalToConstant: size)
        NSLayoutConstraint.activate([outRingHeightConstraint!, outRingWidthConstraint!])
        
        addSubview(selectedView)
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        let selectedViewSize = size - selectedViewInset * 2
        selectedViewWidthConstraint = selectedView.widthAnchor.constraint(equalToConstant: selectedViewSize)
        selectedViewHeightConstraint = selectedView.heightAnchor.constraint(equalToConstant: selectedViewSize)
        NSLayoutConstraint.activate([
            selectedViewWidthConstraint!,
            selectedViewHeightConstraint!,
            selectedView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            selectedView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

