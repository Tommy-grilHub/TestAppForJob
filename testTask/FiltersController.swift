//
//  FilterCollectionViewCell.swift
//  testTask
//
//  Created by BigSynt on 08.03.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import UIKit

class FiltersController: UIViewController {
    
    let filtesCCell = FiltersTableView()
    let filtersView = UIView()
    let viewForLabel = UIView()
    let viewSwipe = UIView()
    
    let filterLabel = UILabel()
    let selecteAllButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(filtesCCell.tableView)
        filtesViewConfigure()
        view.addSubview(viewSwipe)
        viewSwipeConfigure()
    }
    
    func viewSwipeConfigure() {
        viewSwipe.translatesAutoresizingMaskIntoConstraints = false
        viewSwipe.layer.cornerRadius = 3
        viewSwipe.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.8284124729)
        viewSwipe.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(12)
            maker.width.equalTo(50)
            maker.height.equalTo(7)
        }
    }
    
    func filtesViewConfigure() {
        filtesCCell.translatesAutoresizingMaskIntoConstraints = false
        filtesCCell.tableView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(60)
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        
        view.addSubview(filterLabel)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.font = UIFont.systemFont(ofSize: 20)
        filterLabel.text = "Фильтры"
        filterLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        filterLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(38)
            maker.leading.equalToSuperview().inset(15)
        }
        
        view.addSubview(selecteAllButton)
        selecteAllButton.setTitle("Выбрать все", for: .normal)
        selecteAllButton.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        selecteAllButton.backgroundColor = .clear
        selecteAllButton.layer.cornerRadius = 5
        selecteAllButton.frame.size = CGSize(width: filtesCCell.frame.width - 2*80 - 2*30, height: 30)
        selecteAllButton.snp.makeConstraints { maker in
            maker.centerY.equalTo(filterLabel)
            maker.trailing.equalToSuperview().inset(15)
        }
        selecteAllButton.addTarget(self, action: #selector(cleckOnSelectAll), for: .touchUpInside)
        
    }
    
    @objc func cleckOnSelectAll(_ sender: UIButton) {
        for index in 0..<filtesCCell.catigories.count {
            let cell = filtesCCell.tableView.cellForRow(at: IndexPath(item: index, section: 0)) as! FiltersTableView
            if selecteAllButton.titleLabel?.text == "Выбрать все" {
                if cell.switchButton.imageView?.image == UIImage(systemName: "circle", withConfiguration: filtesCCell.config) {
                    filtesCCell.cleckOnSwitchButton(cell.switchButton)
                }
            } else {
                if cell.switchButton.imageView?.image == UIImage(systemName: "checkmark.circle.fill", withConfiguration: filtesCCell.config) {
                    filtesCCell.cleckOnSwitchButton(cell.switchButton)
                }
            }
        }
        
        if selecteAllButton.titleLabel?.text == "Убрать все" {
            selecteAllButton.setTitle("Выбрать все", for: .normal)
        } else {
            selecteAllButton.setTitle("Убрать все", for: .normal)
        }
    }
}

class FiltersTableView: UITableViewCell {
    
    var tableView = UITableView()
    let helperCV = HelperCollectionView()
    var catigories: [CategoriesHashble] = [CategoriesHashble]()
    var selectedCatigories = [String]()
    var imageCatigories = CustomImageView()
    var name = UILabel()
    var switchButton = UIButton()
    let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .medium)
    lazy var imageForSwitchButton = UIImage(systemName: "circle", withConfiguration: config)
    
    var mainScreen: MainScreenProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FiltersTableView.self, forCellReuseIdentifier: "FilterCell")
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func viewDidLoad() {
        tableView.reloadData()
    }
    
    func setData(drugs: [DrugEntity]) {
        for i in 0..<drugs.count {
            if catigories.contains(drugs[i].categories){
            } else {
                catigories.append(drugs[i].categories)
            }
        }
    }
    
    func configureCell() {
        addSubview(name)
        addSubview(imageCatigories)
        addSubview(switchButton)
        configureIcon()
        configureName()
        configureSwitchButton()
        iconConstraints()
        textConstraints()
        switchButtonConstraints()
    }
    
    func configureIcon() {
        imageCatigories.layer.cornerRadius = 3
        imageCatigories.clipsToBounds = true
    }
    
    func configureName() {
        name.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        name.adjustsFontSizeToFitWidth = true
        name.font = UIFont.systemFont(ofSize: 15)
        name.numberOfLines = 1
    }
    
    func configureSwitchButton() {
        switchButton.setImage(imageForSwitchButton, for: .normal)
        switchButton.tintColor = .gray
    }
    
    @objc func cleckOnSwitchButton(_ sender: UIButton) {
        let cell = sender.superview as! FiltersTableView
        
        if sender.imageView?.image == UIImage(systemName: "circle", withConfiguration: config) {
            imageForSwitchButton = UIImage(systemName: "checkmark.circle.fill", withConfiguration: config)
            sender.setImage(imageForSwitchButton, for: .normal)
            UIView.animate(withDuration: 0.5, animations: {
                sender.tintColor = #colorLiteral(red: 0.7374350429, green: 0.2682942748, blue: 0.2212107182, alpha: 1)
            })
            
            selectedCatigories.append(cell.name.text!)
        } else {
            imageForSwitchButton = UIImage(systemName: "circle", withConfiguration: config)
            sender.setImage(imageForSwitchButton, for: .normal)
            UIView.animate(withDuration: 0.5, animations: {
                sender.tintColor = .gray
            })
            
            var newCatigories: [String] = [String]()
            for catigoriesString in selectedCatigories {
                if cell.name.text! != catigoriesString {
                    newCatigories.append(catigoriesString)
                }
            }
            selectedCatigories = newCatigories
        }
        self.mainScreen?.getCatigories(catigories: selectedCatigories)
    }
    
    func switchButtonConstraints() {
        switchButton.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(15)
            maker.centerY.equalToSuperview()
        }
    }
    
    func iconConstraints() {
        imageCatigories.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(12)
            maker.centerY.equalToSuperview()
            maker.width.height.equalTo(35)
        }
    }
    
    func textConstraints() {
        name.snp.makeConstraints { maker in
            maker.leading.equalTo(imageCatigories.snp.trailing).inset(-10)
            maker.centerY.equalToSuperview()
        }
        
    }
}

extension FiltersTableView: UITableViewDelegate,  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewDidLoad()
        tableView.cellForRow(at: indexPath)?.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catigories.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FiltersTableView
        cell.backgroundColor = .white
        cell.switchButton.addTarget(self, action: #selector(cleckOnSwitchButton), for: .touchUpInside)
        let item = catigories[indexPath.row]
        let imageUrl = helperCV.returnImage(urlString: item.icon)
        cell.imageCatigories.download(from: imageUrl)
        cell.name.text = item.name
        return cell
    }
}
