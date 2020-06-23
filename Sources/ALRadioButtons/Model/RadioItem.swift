//
//  RadioItem.swift
//  Wallet
//
//  Created by Alexandr Guzenko on 21.06.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import Foundation

public struct ALRadioItem {
    var title: String
    var subtitle: String? = nil
    
    public init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
}
