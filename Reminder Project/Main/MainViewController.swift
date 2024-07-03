//
//  MainViewController.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

import SnapKit
import Then

class MainViewController: BaseViewController {
    private let rootView = MainView()
    
    // TODO: 개선하기
    
    override func loadView() {
        view = rootView
    }
    
    override func configureView() {
        view.backgroundColor = .black
        configureNavigationBar()
        rootView.mainCollectionView.delegate = self
        rootView.mainCollectionView.dataSource = self
        rootView.mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
        //        rootView.handler = {
        //            let addNewTodoVC = AddNewTodoViewController()
        //            let vc = UINavigationController(rootViewController: addNewTodoVC)
        //            self.present(vc, animated: true)
        //        }
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
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as? MainCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        return cell
    }
}
