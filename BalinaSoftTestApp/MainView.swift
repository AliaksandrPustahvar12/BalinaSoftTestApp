//
//  MainView.swift
//  BalinaSoftTestApp
//
//  Created by Aliaksandr Pustahvar on 22.09.23.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func setController(_ controller: MainControllerProtocol)
    func reloadTableView()
}

class MainView: UIViewController {
    
    private var controller: MainControllerProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.register(TableCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setUpView()
    }
    
    func setUpView() {
        
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
}

extension MainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.photos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell
        cell.cellLabel.text = controller?.photos[indexPath.row].name
        
        if let url = controller?.photos[indexPath.row].image {
            Task { @MainActor in
                if let imageData = await controller?.getImageData(url: url) {
                    cell.cellImageView.image = UIImage(data: imageData)
                }
            }
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        guard let controller = controller else { return }
        let pos = scrollView.contentOffset.y
        if pos > tableView.contentSize.height + 50 - scrollView.frame.size.height && pos > 0 {
            guard !controller.isPagOn else { return }
            Task {
                await controller.getPhotos(for: controller.page)
            }
        }
    }
}

extension MainView: MainViewProtocol {
    
    func setController(_ controller: MainControllerProtocol) {
        self.controller = controller
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}
