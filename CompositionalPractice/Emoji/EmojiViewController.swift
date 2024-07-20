//
//  EmojiViewController.swift
//  CompositionalPractice
//
//  Created by 홍정민 on 7/20/24.
//

import UIKit

final class EmojiViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavItem()
        configureHierarchy()
        configureDataSource()
        applyInitialSnapshot()
    }
}

extension EmojiViewController {
    enum Section: Int, CaseIterable {
        case recents
//        case outline
//        case list
    }
    
    struct Item: Hashable {
        private let id = UUID()
        let title: String?
        let emoji: Emoji?
        let hasChildren: Bool
        
        init(title: String? = nil, emoji: Emoji? = nil, hasChildren: Bool = false) {
            self.title = title
            self.emoji = emoji
            self.hasChildren = hasChildren
        }
    }
    
    private func configureNavItem(){
        navigationItem.title = "Emoji Explorer"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureHierarchy(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        collectionView.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        //각각의 섹션에 대해 다르게 지정하기 위해서 sectionProvider를 사용
        let sectionProvider =  { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
         
            switch sectionKind {
            case .recents:
                //item은 그룹에 맞게 설정하고, group을 가로형태로 어느정도 크기인지 정함
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.28), heightDimension: .fractionalWidth(0.2))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//            case .outline:
//                <#code#>
//            case .list:
//                <#code#>
            }
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    private func configureDataSource(){
        let registeration = UICollectionView.CellRegistration<UICollectionViewCell, Emoji> { cell, indexPath, emoji in
            var content = UIListContentConfiguration.cell()
            content.text = emoji.text
            content.textProperties.font = .boldSystemFont(ofSize: 38)
            content.textProperties.alignment = .center
            cell.contentConfiguration = content
            var background = UIBackgroundConfiguration.listPlainCell()
            background.cornerRadius = 8
            background.strokeColor = .systemGray
            background.strokeWidth = 1.0
            background.strokeColor = .systemGray3
            cell.backgroundConfiguration = background
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registeration, for: indexPath, item: itemIdentifier.emoji)
            return cell
        })
    }
    
    private func applyInitialSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        let recentItems = Emoji.Category.recents.emojis.map{ Item(emoji: $0)}
        var recentsSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        recentsSnapshot.append(recentItems)
        dataSource.apply(recentsSnapshot, to: .recents, animatingDifferences: false)
    }
}
