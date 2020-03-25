//
//  EventCell.swift
//  CompositionalLayout-POC
//
//  Created by Ravi Bastola on 3/25/20.
//  Copyright © 2020 Ravi Bastola. All rights reserved.
//

import UIKit

protocol Reusable {
    static var reuseID: String { get set }
}

class EventCell: UICollectionViewCell, Reusable {
    
    static var reuseID: String = "ReuseMe"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
