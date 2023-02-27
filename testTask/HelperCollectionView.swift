//
//  HelperCollectionView.swift
//  testTask
//
//  Created by BigSynt on 02.02.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import Foundation
import UIKit


class HelperCollectionView {
    
    func estimatedHeightOfLabel(text: String, font: UIFont, frame: CGRect) -> CGRect {
        let size = CGSize(width: frame.width, height: frame.height) //view.frame.width/2.4 - 20
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        let rectangleSize = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil) //+ 5
        return rectangleSize
    }
    
    func texEditing(drugs: [DrugEntity]) -> [DrugEntity] {
        var drugs = drugs
        for i in 0..<drugs.count {
            drugs[i].name = drugs[i].name.replacingOccurrences(of: "*", with: "")
            
            drugs[i].description = drugs[i].description.replacingOccurrences(of: "\r", with: "")
            drugs[i].description = drugs[i].description.replacingOccurrences(of: "\n", with: "")
            
            drugs[i].wideDescription = drugs[i].description.replacingOccurrences(of: "\r", with: "")
            drugs[i].wideDescription = drugs[i].description.replacingOccurrences(of: "\n", with: "")
            
            if drugs[i].description.last != "." {
                drugs[i].description.append(".")
                drugs[i].wideDescription.append(".")
            }
        }
        return drugs
    }
    
    func shorteningText(drugs: [DrugEntity], view: UIView, font: UIFont) -> [DrugEntity] {
        var drugs = drugs

        for i in 0..<drugs.count {
            drugs[i].description.append(" &") //= drugs[i].description + " "
            var initialLine = ""
            var word = ""
            var finalLine = ""
            var numberOfLines = 0
            
            while drugs[i].description != "&" {
                word = String(drugs[i].description.split(separator: " ", maxSplits: 1)[0])
                drugs[i].description = String(drugs[i].description.split(separator: " ", maxSplits: 1)[1])
                
                if estimatedHeightOfLabel(text: initialLine + " " + word, font: font, frame: view.frame).width <= view.frame.width/2.4 - 20 {
                    initialLine = initialLine + " " + word
                    if initialLine.first == " " { initialLine = initialLine.replacingOccurrences(of: " ", with: "") }
                } else {
                    numberOfLines = numberOfLines + 1
                    if numberOfLines != 3 {
                        initialLine = initialLine + "\n"
                        finalLine = finalLine + initialLine
                        initialLine = word
                    } else {
                        initialLine = initialLine + "&\n"
                        finalLine = finalLine + initialLine
                        initialLine = word
                    }
                }
                word = ""
            }
            finalLine = finalLine + initialLine
            drugs[i].description = finalLine
        }
        return drugs
    }
    
    func returnImage(urlString: String/*item: DrugEntity*/) -> URL {
        let errorUrl = URL(string: "http://shans.d2.i-partner.ru")!
        //let txtAppend = (item.image).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let txtAppend = (urlString).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = "http://shans.d2.i-partner.ru\(txtAppend!)"
        guard let openUrl = URL(string: urlString) else { return errorUrl }
        return openUrl
    }
    
    func setDataToCell(cell: CollectionViewCell, item: DrugEntity) -> CollectionViewCell {
        let item = item
        cell.title.text = item.name
        cell.info.text = item.description
        
        if item.description.contains("&") {
            cell.info.text = String(item.description.split(separator: "&")[0])
            if cell.info.text?.last == "," {
                cell.info.text = cell.info.text?.replacingOccurrences(of: ",", with: "")
                cell.info.text?.append("..")
            } else if cell.info.text?.last == "." {
                cell.info.text?.append(".")
            } else {
                cell.info.text?.append("..")
            }
        }
        
        let imageUrl = returnImage(urlString: item.image)
        
        cell.image.download(from: imageUrl as URL)
        cell.layer.cornerRadius = 5
        
        cell.backgroundColor = .white
        return cell
    }
}
