//
//  CollectionViewCell.swift
//  testTask
//
//  Created by BigSynt on 22.01.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import UIKit
import SnapKit

//private enum State {
//    case expanded
//    case collapsed
//
//    var change: State {
//        switch self {
//        case .expanded: return .collapsed
//        case .collapsed: return .expanded
//        }
//    }
//} 

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "customCell"

    var image = CustomImageView()
    var title = UILabel()
    var info = UILabel()
    var shadow = UIView()
    
    //var backToColViewButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(shadow)
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(info)
        //contentView.addSubview(backToColViewButton)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        configureImage()
        configureTitle()
        configureInfo()
        shadowConfigure()
        shadowConstraints()
        imageConstraints()
        labelConstraints()
        backButtonConstraints()
    }
    
    func configureImage() {
        image.layer.cornerRadius = 3
        image.clipsToBounds = true
    }
    
    func configureTitle() {
        title.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont.systemFont(ofSize: 13)
    }
    
    func configureInfo() {
        info.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        info.adjustsFontSizeToFitWidth = true
        info.font = UIFont.systemFont(ofSize: 11)
    }
    
    func shadowConfigure() {
        shadow.layer.cornerRadius = 5
        shadow.alpha = 1
        shadow.backgroundColor = #colorLiteral(red: 0.6836525798, green: 1, blue: 0.9262554049, alpha: 0.7475987555)
        shadow.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadow.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shadow.layer.shadowRadius = 5
        shadow.layer.shadowOpacity = 0.7
    }
    func backButtonConstraints() {
        //backToColViewButton.translatesAutoresizingMaskIntoConstraints = false
        //backToColViewButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    
    func shadowConstraints() {
        shadow.translatesAutoresizingMaskIntoConstraints = false
        shadow.snp.makeConstraints { maker in
            maker.width.equalTo(100)
            maker.height.equalTo(140)
            maker.top.equalToSuperview().inset(10)
            maker.centerX.equalToSuperview()
        }
    }
    
    func imageConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.snp.makeConstraints { maker in
            maker.width.equalTo(80)
            maker.height.equalTo(130)
            maker.top.equalToSuperview().inset(15)
            maker.centerX.equalToSuperview()
        }
        image.backgroundColor = UIColor.clear
    }
    
    func labelConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.numberOfLines = 0
        title.snp.makeConstraints { maker in
            maker.top.equalTo(image.snp.bottom).inset(-15)
            maker.leading.trailing.equalToSuperview().inset(10)
        }
        
        info.translatesAutoresizingMaskIntoConstraints = false
        info.numberOfLines = 0
        info.snp.makeConstraints { maker in
            maker.top.equalTo(title.snp.bottom).inset(-10)
            maker.leading.equalToSuperview().inset(10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

