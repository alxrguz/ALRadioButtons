//
//  ALHeaderView.swift
//  iOS App
//
//  Created by Alexandr Guzenko on 30.07.2021.
//  Copyright © 2021 alxrguz. All rights reserved.
//

import UIKit

final class ALHeaderView: UIView {
    // MARK: - UI Elements
    public lazy var titleLabel = UILabel()
    public lazy var subtitleLabel = UILabel()
    
    // MARK: - Life cycle
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout Setup
private extension ALHeaderView {
    func setupColors() {
        titleLabel.textColor = .label
        subtitleLabel.textColor = .secondaryLabel
    }
    
    func setupView() {
        setupColors()
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
    }
    
    func setupConstraints() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}

