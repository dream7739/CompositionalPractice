//
//  TravelTalkViewController.swift
//  CompositionalPractice
//
//  Created by 홍정민 on 7/18/24.
//

import UIKit
import SnapKit

final class TravelTalkViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<String, ChatRoom>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "TRAVEL TALK"
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.backgroundColor = .red
        
        configureDataSource()
        updateSnapShot()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
}

extension TravelTalkViewController {
    
    private func configureDataSource(){
        var registeration: UICollectionView.CellRegistration<UICollectionViewListCell, ChatRoom>!
        
        registeration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.subtitleCell()
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.description
            content.image = UIImage(named: itemIdentifier.profile)
            content.imageProperties.cornerRadius = 15
            content.imageProperties.maximumSize = CGSize(width: 30, height: 30)
            
            content.textProperties.font = .systemFont(ofSize: 13, weight: .medium)
            content.secondaryTextProperties.font = .systemFont(ofSize: 12, weight: .regular)
            
            cell.contentConfiguration = content
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registeration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
    }
    
    private func updateSnapShot(){
        var snapshot = NSDiffableDataSourceSnapshot<String, ChatRoom>()
        snapshot.appendSections(["chatRoomList"])
        snapshot.appendItems(ChatRoomResult.chatRoomList)
        dataSource.apply(snapshot)
    }
}
