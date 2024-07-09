//
//  MainViewController.swift
//  Reminder Project
//
//  Created by dopamint on 7/4/24.
//

import UIKit

import SnapKit
import Then
import FSCalendar

class MainViewController: BaseViewController<MainView> {
    
    var customCategories: [Category] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadCollectionView(_:)),
            name: .reloadCollectionView,
            object: nil
        )
    }
    @objc func reloadCollectionView(_ notification: Notification) {
        DispatchQueue.main.async {
            self.rootView.mainCollectionView.reloadData()
        }
    }
    
    // TODO: 적절한 시점에 observe를 지워주어야 한다??? 그럼 안되던데..
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
//        NotificationCenter.default.removeObserver(self, name: .reloadCollectionView, object: nil)
    }

    override func configureView() {
        view.backgroundColor = .black
        configureNavigationBar()
        rootView.mainCollectionView.delegate = self
        rootView.mainCollectionView.dataSource = self
        rootView.mainCollectionView.register(MainCollectionViewCell.self, 
                                             forCellWithReuseIdentifier: MainCollectionViewCell.id)
        rootView.mainViewHandler = {
            let nextVC = TodoEditorViewController(.add)
            let vc = UINavigationController(rootViewController: nextVC)
            self.present(vc, animated: true)
        }
    }
    // TODO: 달력 안뜸 -
    private func configureNavigationBar() {
        let calandarButton = UIBarButtonItem(title: "달력보기",
                                             image: UIImage(systemName: "calendar.circle"),
                                             target: self,
                                             action: #selector(calendarButtonTapped),
                                             menu: nil)
        navigationItem.leftBarButtonItem = calandarButton
    }
    @objc
    func calendarButtonTapped() {
        let nextVC = UINavigationController(rootViewController: CalendarViewController())
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            ListCategory.allCases.count - 1
        } else {
            customCategories.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = ListCategory.allCases[indexPath.item]
        customCategories = repository.fetchCategory()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id,
                                                            for: indexPath) as? MainCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        if indexPath.section == 0 {
            switch category {
            case .today:
                cell.listCategory = .today
                cell.setUpCellData(count: repository.fetchToday().count)
            case .scheduled:
                cell.listCategory = .scheduled
                cell.setUpCellData(count: repository.fetchScheduled().count)
            case .all:
                cell.listCategory = .all
                cell.setUpCellData(count: repository.fetchAll().count)
            case .flagged:
                cell.listCategory = .flagged
                cell.setUpCellData(count: repository.fetchFlagged().count)
            case .done:
                cell.listCategory = .done
                cell.setUpCellData(count: repository.fetchDone().count)
            case .custom:
                break
            }
        } else {
            print("sfkasjfnajlksdnflasjknf")
            cell.setUpCellData(count: customCategories[indexPath.row].todolist.count)
            cell.titleLabel.text = customCategories[indexPath.row].name
        }
        
        cell.iconView.layer.cornerRadius = cell.iconView.frame.height / 2
        cell.iconView.clipsToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let category = ListCategory.allCases[indexPath.item]
        switch category {
            
        case .today:
            navigationController?.pushViewController(TodoListViewController(listCategory: .today), animated: true)
        case .scheduled:
            navigationController?.pushViewController(TodoListViewController(listCategory: .scheduled), animated: true)
        case .all:
            navigationController?.pushViewController(TodoListViewController(listCategory: .all), animated: true)
        case .flagged:
            navigationController?.pushViewController(TodoListViewController(listCategory: .flagged), animated: true)
        case .done:
            navigationController?.pushViewController(TodoListViewController(listCategory: .done), animated: true)
        case .custom:
            navigationController?.pushViewController(TodoListViewController(listCategory: .done), animated: true)
        }
    }
}
