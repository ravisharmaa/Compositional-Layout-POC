//
//  SupplementaryHeaderView.swift
//  CompositionalLayout-POC
//
//  Created by Ravi Bastola on 3/25/20.
//  Copyright © 2020 Ravi Bastola. All rights reserved.
//

import UIKit


class SupplementaryHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
