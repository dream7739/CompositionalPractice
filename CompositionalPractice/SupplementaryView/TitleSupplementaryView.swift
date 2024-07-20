//
//  SettingTitleSupplementaryView.swift
//  CompositionalPractice
//
//  Created by 홍정민 on 7/18/24.
//

import UIKit
import SnapKit

final class TitleSupplementaryView: UICollectionReusableView {
    let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        
        snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(18)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

