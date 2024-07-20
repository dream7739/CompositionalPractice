//
//  ViewController.swift
//  CompositionalPractice
//
//  Created by 홍정민 on 7/18/24.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {

    private lazy var settingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        //configuration의 headerMode로 header를 설정 가능한듯함
        //case none(없음), supplementary(별도로), firstItemInSection(item의 첫번째 >> 좋긴한데, 데이터랑 뭔가 정합이 맞아야될것같음??)
        configuration.headerMode = .supplementary
        configuration.backgroundColor = .systemBackground
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "설정"
        
        view.addSubview(settingCollectionView)
        
        settingCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        configureDataSource()
        updateSnapShot()
    }
}

extension SettingViewController {
    struct Item: Hashable, Identifiable {
        let id = UUID()
        let title: String
    }
    
    enum Section: String, CaseIterable {
        case all = "전체 설정"
        case personal = "개인 설정"
        case etc = "기타"
        
        var item: [Item] {
            switch self {
            case .all:
                return [
                    Item(title: "공지사항"),
                    Item(title: "실험실"),
                    Item(title: "버전정보")
                ]
            case .personal:
                return [
                    Item(title: "개인/보안"),
                    Item(title: "알림"),
                    Item(title: "채팅"),
                    Item(title: "멀티프로필")
                ]
            case .etc:
                return [
                    Item(title: "고객센터/도움말")
                ]
            }
        }
    }
    

    private func configureDataSource(){
        var headerRegisteration: UICollectionView.SupplementaryRegistration<TitleSupplementaryView>!
        var registeration: UICollectionView.CellRegistration<UICollectionViewCell, Item>!
        
        headerRegisteration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: UICollectionView.elementKindSectionHeader, handler: { supplementaryView, elementKind, indexPath in
            supplementaryView.titleLabel.text = Section.allCases[indexPath.section].rawValue
        })
        
        registeration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.textProperties.font = .systemFont(ofSize: 13)
            cell.contentConfiguration = content
            
        })
        
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: settingCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registeration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        dataSource.supplementaryViewProvider =  {(view, string, indexPath) in
            return self.settingCollectionView.dequeueConfiguredReusableSupplementary(using: headerRegisteration, for: indexPath)
        }
        
    }
    
    private func updateSnapShot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(Section.all.item, toSection: .all)
        snapshot.appendItems(Section.personal.item, toSection: .personal)
        snapshot.appendItems(Section.etc.item, toSection: .etc)
        dataSource.apply(snapshot)
    }
}

