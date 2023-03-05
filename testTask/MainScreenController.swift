//
//  ViewController.swift
//  testTask
//
//  Created by BigSynt on 19.01.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import UIKit

protocol MainScreenProtocol {
    func getDrugs(drugs: [DrugEntity])
    func collectionViewDidLoad()
}

class MainScreenController: UIViewController, MainScreenProtocol {
    
    let titleFont = UIFont.systemFont(ofSize: 13)
    let infoFont = UIFont.systemFont(ofSize: 11)
    
    let helperCV = HelperCollectionView()
    var presenter: MainScreenPresenter?
    var drugs: [DrugEntity] = [DrugEntity]()
    var searchButton = UIBarButtonItem()
    
    var searchController = UISearchController()
    var filterSearch = [DrugEntity]()
    let enlargedView = ProductOverviewController()
    var pointCell = CGPoint()
    
    var backToColViewButton = UIButton()
    var favoritesButton = UIButton()
    var buyButton = UIButton()
    
    var blurEffectView = UIVisualEffectView()
    
    private var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 18
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "customCell")
        
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //var tabBar = TaskBarViewController()//UITabBar()
        //tabBar.tabBarItem.tag = 0
        //navigationController?.tabBarItem = tabBar.tabBarItem
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Товары"
        navigationController?.navigationItem.titleView?.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.6068962216, green: 0.7755689025, blue: 0.7669673562, alpha: 1)
        navigationController?.navigationBar.tintColor = .black

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let searchButtonImage = UIImage(systemName: "magnifyingglass")
        searchButton = UIBarButtonItem(image: searchButtonImage, style: .plain, target: self, action: #selector(didTapSearchButton))
    }

    @objc public func didTapSearchButton() {
        searchController.searchBar.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchControllerConfiguration()
        view.backgroundColor = #colorLiteral(red: 0.6068962216, green: 0.7755689025, blue: 0.7669673562, alpha: 1)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = .init(
            top: 15,
            left: 22,
            bottom: 25,
            right: 22
        )
        setCollectionViewConstraints()
        
        presenter?.view = self
        presenter?.getData()
    }
    
    func searchControllerConfiguration() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.keyboardAppearance = .light
        searchController.searchBar.tintColor = .white
        searchController.searchBar.placeholder = "поиск"
    }
    
    func setCollectionViewConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = true
    }
    
    func getDrugs(drugs: [DrugEntity]) {
        self.drugs = helperCV.shorteningText(drugs: helperCV.texEditing(drugs: drugs), view: view, font: infoFont)
    }
    
    func collectionViewDidLoad() {
        collectionView.reloadData()
    }
    
    func getElementCoordinate(indexPath: IndexPath) -> CGPoint {
        let cellRect = collectionView.cellForItem(at: indexPath)
        let y = cellRect?.frame.origin.y ?? 0
        let contentOffsetY = collectionView.contentOffset.y
        let contentOffsetX: CGFloat =  indexPath.item % 2 == 0 ? 22 : 198
        return CGPoint(x: contentOffsetX, y: y - contentOffsetY)
    }
    
    @objc func backButtonClickInLargeView(_ sender: UIButton) {
        let width = view.frame.width/10
        backToColViewButton.tintColor = .black
        let indexPath = collectionView.indexPathForItem(at: pointCell) ?? IndexPath(item: 0, section: 0)
        let cellRect = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 1.4, animations: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        })
        UIView.animate(withDuration: 0.1, animations: {
            self.backToColViewButton.frame = CGRect(x: 8*width - 60, y: 5, width: 35, height: 35) //250
        })
        UIView.animate(withDuration: 0.1, delay: 0.1, animations: {
            self.backToColViewButton.frame = CGRect(x: 8*width - 40, y: 5, width: 35, height: 35) //260
        })
        UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
            self.enlargedView.imageCatigories.alpha = 0
            self.backToColViewButton.alpha = 0
            self.favoritesButton.alpha = 0
            self.buyButton.alpha = 0
            self.enlargedView.name.alpha = 0
            self.enlargedView.info.alpha = 0
        })
        UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
            self.enlargedView.card.backgroundColor = .clear
            self.blurEffectView.alpha = 0
        })
        UIView.animate(withDuration: 0.6, delay: 0.7, animations: {
            self.enlargedView.shadow.frame = CGRect(x: indexPath.item%2 == 0 ? 27 : self.pointCell.x/5 - 15, y: 10, width: 100, height: 140)
            self.enlargedView.image.frame = CGRect(x: indexPath.item%2 == 0 ? 38 : self.pointCell.x/5 - 6, y: 15, width: 80, height: 130)
            self.enlargedView.card.frame = CGRect(origin: self.pointCell, size: cellRect?.bounds.size ?? CGSize(width: 0, height: 0))
        })
        UIView.animate(withDuration: 0.001, delay: 1.3, animations: {
            self.enlargedView.shadow.alpha = 0
            self.enlargedView.image.alpha = 0
            self.enlargedView.view.frame.origin = CGPoint(x: -1000, y: 0)
            self.enlargedView.card.frame.origin = CGPoint(x: -1000, y: 0)
            self.backToColViewButton.frame.origin = CGPoint(x: -1000, y: 0)
            self.favoritesButton.frame.origin = CGPoint(x: -1000, y: 0)
            self.enlargedView.shadow.frame = CGRect(origin: CGPoint(x: -1000, y: 0), size: CGSize(width: 80, height: 130))
            self.enlargedView.image.frame = CGRect(origin: CGPoint(x: -1000, y: 0), size: CGSize(width: 100, height: 140))
            self.enlargedView.imageCatigories.frame = CGRect(origin: CGPoint(x: -1000, y: 0), size: CGSize(width: 50, height: 50))
            self.blurEffectView.frame = CGRect(origin: CGPoint(x: -1000, y: 0), size: CGSize(width: 0, height: 0))
        })
        collectionViewDidLoad()
    }
    
    @objc func clickOnFavoritesButton(_ sender: UIButton) {
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)
        let imageForBackCVButton = UIImage(systemName: "star.fill", withConfiguration: config)
        UIView.animate(withDuration: 0.3, animations: {
            self.favoritesButton.setImage(imageForBackCVButton, for: .normal)
            self.favoritesButton.tintColor = #colorLiteral(red: 1, green: 0.7667039037, blue: 0, alpha: 1)
        })
    }
    
    @objc func cleckOnWereBuy(_ sender: UIButton) {
        buyButton.setTitleColor(.black, for: .normal)
        buyButton.frame = CGRect(x: 32, y: 444, width: 240, height: 38)
        UIView.animate(withDuration: 0.1, delay: 0.1, animations: {
            self.buyButton.frame = CGRect(x: 25, y: 440, width: 250, height: 40)
        })
    }
    
    func configureBlurView() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 120
        blurEffectView.alpha = 0
        view.insertSubview(blurEffectView, belowSubview: enlargedView.view)
    }
    
    func buttonConfigure() {
        var config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .medium)
        var imageForBackCVButton = UIImage(systemName: "xmark.circle", withConfiguration: config)
        backToColViewButton.setImage(imageForBackCVButton, for: .normal)
        backToColViewButton.addTarget(self, action: #selector(backButtonClickInLargeView), for: .touchUpInside)
        backToColViewButton.tintColor = .gray
        backToColViewButton.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        enlargedView.card.addSubview(backToColViewButton)
        
        config = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)
        imageForBackCVButton = UIImage(systemName: "star", withConfiguration: config)
        favoritesButton.setImage(imageForBackCVButton, for: .normal)
        favoritesButton.addTarget(self, action: #selector(clickOnFavoritesButton), for: .touchUpInside)
        favoritesButton.tintColor = .gray
        let width = view.frame.width/10
        favoritesButton.frame = CGRect(x: 8*width - 50, y: 445, width: 35, height: 32)
        enlargedView.card.addSubview(favoritesButton)
        
        buyButton.setTitle("ГДЕ КУПИТЬ", for: .normal)
        buyButton.setTitleColor(.gray, for: .normal)
        buyButton.addTarget(self, action: #selector(cleckOnWereBuy), for: .touchUpInside)
        buyButton.backgroundColor = #colorLiteral(red: 0.5124076009, green: 1, blue: 0.9198634028, alpha: 1)
        buyButton.layer.cornerRadius = 10
        buyButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        buyButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        buyButton.layer.shadowRadius = 10
        buyButton.layer.shadowOpacity = 0.5
        buyButton.frame = CGRect(x: width - 20, y: 440, width: width*6, height: 40)
        enlargedView.card.addSubview(buyButton)
    }
    
    func defaultValue(indexPath: IndexPath) {
        if let viewWithTag = self.view.viewWithTag(120) {
            viewWithTag.removeFromSuperview()
        }
        enlargedView.view.removeFromSuperview()
        enlargedView.view.backgroundColor = .clear
        enlargedView.card.backgroundColor = .clear
        enlargedView.card.layer.shadowOffset = CGSize(width: 0, height: 3)
        enlargedView.card.layer.shadowColor = #colorLiteral(red: 0, green: 0.8183047175, blue: 0.8288889527, alpha: 1)
        enlargedView.card.layer.shadowRadius = 10
        enlargedView.card.layer.shadowOpacity = 1
        backToColViewButton.alpha = 0
        favoritesButton.alpha = 0
        buyButton.alpha = 0
        buyButton.setTitleColor(.gray, for: .normal)
        
        enlargedView.shadow.alpha = 1
        enlargedView.image.alpha = 1
        enlargedView.imageCatigories.alpha = 0
        enlargedView.name.alpha = 0
        enlargedView.info.alpha = 0
        
        enlargedView.setData(drug: filterSearch != [] ? filterSearch[indexPath.item] : drugs[indexPath.item])
        view.addSubview(enlargedView.view)
        
        let cellRect = collectionView.cellForItem(at: indexPath)
        pointCell = getElementCoordinate(indexPath: indexPath)
        enlargedView.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.view.frame.size)
        enlargedView.card.frame = CGRect(origin: pointCell, size: cellRect?.bounds.size ?? CGSize(width: 0, height: 0))
        
        enlargedView.shadow.frame = CGRect(x: indexPath.item%2 == 0 ? enlargedView.card.center.x/2 - 21 : pointCell.x/5 - 15, y: 10, width: 100, height: 140)
        enlargedView.shadow.backgroundColor = #colorLiteral(red: 0, green: 0.8183047175, blue: 0.8288889527, alpha: 1)
        enlargedView.image.frame = CGRect(x: indexPath.item%2 == 0 ? enlargedView.card.center.x/2 - 10 : pointCell.x/5 - 6, y: 15, width: 80, height: 130)
        enlargedView.imageCatigories.frame = CGRect(x: indexPath.item%2 == 0 ? enlargedView.card.center.x/2 - 37 : pointCell.x/5 - 27, y: 15, width: 50, height: 50)
    }
    
    func showAlert(massage: String) {
        let alert = UIAlertController(title: "Поиск товара", message: massage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension MainScreenController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate, UISearchControllerDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterSearch.removeAll()
        guard searchText != "" || searchText != " " else {
            return
        }
        for item in drugs {
            let text = searchText.lowercased()
            let isItemContain = item.name.lowercased().range(of: text)
            if isItemContain != nil {
                filterSearch.append(item)
            }
        }
        collectionViewDidLoad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if filterSearch.isEmpty {
            self.showAlert(massage: "Товар по вашему запросу не найден.")
            searchBar.text = nil
        }
        collectionViewDidLoad()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterSearch = []
        collectionViewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCell: CGFloat = view.frame.width/2.4 + 100
        return CGSize(width: view.frame.width/2.4, height: sizeCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard filterSearch != [] else {
            return drugs.count
        }
        return filterSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defaultValue(indexPath: indexPath)
        buttonConfigure()
        configureBlurView()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.enlargedView.shadow.backgroundColor = #colorLiteral(red: 0.6836525798, green: 1, blue: 0.9262554049, alpha: 0.7475987555)
            self.blurEffectView.alpha = 0.6
        })
        UIView.animate(withDuration: 0.8, animations: {
            let spaceHeight = self.view.frame.height/5
            var spaceWidth = self.view.frame.width/10
            self.enlargedView.card.backgroundColor = .white
            self.backToColViewButton.frame = CGRect(x: 8*spaceWidth - 40, y: 5, width: 35, height: 35)
            self.enlargedView.card.frame = CGRect(x: spaceWidth, y: spaceHeight/2, width: spaceWidth*8, height: 500)
            spaceWidth = self.enlargedView.card.frame.width/2
            self.enlargedView.shadow.frame = CGRect(x: spaceWidth - 150/2, y: 15, width: 150, height: 210)
            self.enlargedView.shadow.alpha = 1
            self.enlargedView.image.frame = CGRect(x: spaceWidth - 120/2, y: 22, width: 120, height: 195)
            self.enlargedView.image.alpha = 1
            
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        })
        UIView.animate(withDuration: 0.4, delay: 0.4, animations: {
            self.backToColViewButton.alpha = 1
            self.enlargedView.imageCatigories.alpha = 1
            self.enlargedView.card.layer.shadowOpacity = 0
        })
        UIView.animate(withDuration: 0.2, delay: 0.6, animations: {
            self.favoritesButton.alpha = 1
            self.enlargedView.name.alpha = 1
            self.enlargedView.info.alpha = 1
            self.buyButton.alpha = 1
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CollectionViewCell
        guard filterSearch != [] else {
            let item = drugs[indexPath.row]
            cell = helperCV.setDataToCell(cell: cell, item: item)
            return cell
        }
        let item = filterSearch[indexPath.row]
        cell = helperCV.setDataToCell(cell: cell, item: item)
        return cell
    }
}
