//
//  ProductOverviewController.swift
//  testTask
//
//  Created by BigSynt on 15.02.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ProductOverviewController: UIViewController {
    
    let helperCV = HelperCollectionView()
    var card = UIView()
    var image = CustomImageView()
    var imageCatigories = CustomImageView()
    var name = UILabel()
    var info = UILabel()
    var shadow = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(card)
        card.addSubview(shadow)
        card.addSubview(image)
        card.addSubview(imageCatigories)
        view.addSubview(name)
        view.addSubview(info)
       
        configureCell()
    }
    
    func setData(drug: DrugEntity) {
        var imageUrl = helperCV.returnImage(urlString: drug.image)
        image.download(from: imageUrl)
        imageUrl = helperCV.returnImage(urlString: drug.categories.icon)
        imageCatigories.download(from: imageUrl)
        name.text = drug.name
        info.text = drug.wideDescription
        print(drug.categories.name)
    }
    
    func configureCell() {
        configureImage()
        configureTitle()
        configureInfo()
        shadowConfigure()
        configureCard()
        textConstraints()
    }
    
    func configureCard() {
        card.layer.cornerRadius = 10
    }
    
    func configureImage() {
        image.layer.cornerRadius = 3
        image.clipsToBounds = true
        image.backgroundColor = UIColor.clear
    }
    
    func configureTitle() {
        name.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        name.adjustsFontSizeToFitWidth = true
        name.font = UIFont.systemFont(ofSize: 16)
        name.textAlignment = .center
        name.numberOfLines = 0
    }
    
    func configureInfo() {
        info.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        info.adjustsFontSizeToFitWidth = true
        info.font = UIFont.systemFont(ofSize: 14)
        info.numberOfLines = 0
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
    
    func textConstraints() {
        let spaceHeight = view.frame.height/5
        let spaceWidth = 3*view.frame.width/10
        name.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(spaceHeight/2 + 240) //210
            maker.centerX.equalToSuperview()
            maker.leading.trailing.equalToSuperview().inset(spaceWidth/2)
        }

        info.snp.makeConstraints { maker in
            maker.top.equalTo(name.snp.bottom).inset(-5)
            maker.centerX.equalToSuperview()
            maker.leading.trailing.equalToSuperview().inset(spaceWidth/2)
            
        }
    }
}
