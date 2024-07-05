//
//  MainViewController.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

import SnapKit
import Then

class MainViewController: BaseViewController<MainView> {
    
    override func configureView() {
        view.backgroundColor = .black
        configureNavigationBar()
        rootView.mainCollectionView.delegate = self
        rootView.mainCollectionView.dataSource = self
        rootView.mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
        rootView.mainViewHandler = {
            let nextVC = AddNewTodoViewController()
            let vc = UINavigationController(rootViewController: nextVC)
            self.present(vc, animated: true)
        }
    }
    private func configureNavigationBar() {
        let menu = configurePullDownButton()
        let menuButton = UIBarButtonItem(title: nil,
                                         image: UIImage(systemName: "ellipsis.circle"),
                                         target: nil,
                                         action: nil,
                                         menu: menu)
        navigationItem.rightBarButtonItem = menuButton
    }
    private func configurePullDownButton() -> UIMenu {
       // 기능 추가 예정
        return UIMenu(children: [])
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ListCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = ListCategory.allCases[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id,
                                                            for: indexPath) as? MainCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        switch category {
        case .today:
            cell.listCategory = .today
            cell.setUpCellData(count: 0)
        case .scheduled:
            cell.listCategory = .scheduled
            cell.setUpCellData(count: 0)
        case .all:
            cell.listCategory = .all
            cell.setUpCellData(count: 0)
        case .flaged:
            cell.listCategory = .flaged
            cell.setUpCellData(count: 0)
        case .done:
            cell.listCategory = .done
            cell.setUpCellData(count: 0)
        }
        
        cell.iconView.layer.cornerRadius = cell.iconView.frame.height / 2
        cell.iconView.clipsToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, 
                                                            for: indexPath) as? MainCollectionViewCell
        else {
            return
        }
        let category = ListCategory.allCases[indexPath.item]
        switch category {
            
        case .today:
            navigationController?.pushViewController(TodoListViewController(listCategory: .today), animated: true)
        case .scheduled:
            navigationController?.pushViewController(TodoListViewController(listCategory: .scheduled), animated: true)
        case .all:
            navigationController?.pushViewController(TodoListViewController(listCategory: .all), animated: true)
        case .flaged:
            navigationController?.pushViewController(TodoListViewController(listCategory: .flaged), animated: true)
        case .done:
            navigationController?.pushViewController(TodoListViewController(listCategory: .done), animated: true)
        }
    }
}
