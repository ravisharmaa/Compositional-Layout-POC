//
//  ViewController.swift
//  CompositionalLayout-POC
//
//  Created by Ravi Bastola on 3/22/20.
//  Copyright © 2020 Ravi Bastola. All rights reserved.
//

import UIKit

enum SectionLayoutKind: Int, CaseIterable {
    case dateCell, eventCell
    
    var columnCount: Int {
        switch self {
        case .dateCell:
            return 30
        case .eventCell:
            return 5
        }
    }
}

class ViewController: UICollectionViewController {
    
    //MARK:- Properties
    
    var dataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, Int>!
    
    var snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, Int>()
    
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // defining the item size
            var itemSize: NSCollectionLayoutSize?
            
            // defining the content insets
            var contentInsets: NSDirectionalEdgeInsets?
            
            // define the header size
            
            var headerSize: NSCollectionLayoutSize?
            
            
            guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
            
            let columnCount = sectionLayoutKind.columnCount
            
            
            if sectionLayoutKind == .dateCell {
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
                contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 50, trailing: 10)
            } else {
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(90))
                contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 0, trailing: 10)
                
            }
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize!)
            
            
            item.contentInsets = contentInsets!
            
            let groupHeight = columnCount == 30 ? NSCollectionLayoutDimension.absolute(55) : NSCollectionLayoutDimension.absolute(100)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: groupHeight)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columnCount == 30 ? 7 : 1)
            
            if sectionLayoutKind == .dateCell {
                headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))
            } else {
                headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(0.1))
            }
            
            
            
            let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize!, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.boundarySupplementaryItems = [headerView]
            
            section.interGroupSpacing = 10
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
            
            return section
        }
        
        super.init(collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemGray3
        
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseID)
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.reuseID)
        collectionView.register(SupplementaryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
        configureDataSource()
    }
    
    // The comp layout removes the implementatation of datasource methods
    
}

extension ViewController {
    
    func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, Int>(collectionView: collectionView, cellProvider: { (
            collectionView, indexPath, identifier) -> UICollectionViewCell? in
            
            let section = SectionLayoutKind(rawValue: indexPath.section)!
            
            switch section {
            case .dateCell:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.reuseID, for: indexPath) as? DateCell else { fatalError() }
                cell.dateLabel.text = "\(identifier)"
                
                return cell
                
            case .eventCell:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.reuseID, for: indexPath) as? EventCell else { fatalError() }
                
                return cell
            }
            
        })
        
        dataSource.supplementaryViewProvider = {(
            collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath)
            
            return headerView
        }
        
        SectionLayoutKind.allCases.forEach { (sectionLayout) in
            snapshot.appendSections([sectionLayout])
            
            switch sectionLayout {
            case .dateCell:
                snapshot.appendItems(Array(0..<30))
            case .eventCell:
                snapshot.appendItems(Array(30..<35))
            }
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

