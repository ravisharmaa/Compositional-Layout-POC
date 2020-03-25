//
//  DateCell.swift
//  CompositionalLayout-POC
//
//  Created by Ravi Bastola on 3/23/20.
//  Copyright © 2020 Ravi Bastola. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell, Reusable {
    
    static var reuseID: String = "DateCell"
    
    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupUI() {
        
        containerView.layer.cornerRadius = self.frame.height / 2
        
        addSubview(containerView)
        
        containerView.addSubview(dateLabel)
        
        
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dateLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        
        ])
    }
}
