//
//  FavouriteViewController.swift
//  ScheduleYourDay
//
//  Created by vineet singh on 02/01/21.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let model = DataHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.allowsSelection = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.favTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavouriteAddCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = model.favTask[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            model.favTask.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tsize = tableView.frame.size
        let button = UIButton(frame: CGRect(x: tsize.width - 80, y: 15, width: 50, height: 30))
        button.tag = section
        button.setImage(UIImage(named: "add.png"), for: .normal)
        button.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tsize.height, height: tsize.width))
        headerView.addSubview(button)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height: CGFloat = 60
        return height
    }
    
    // add Task in table view
    @objc func addTask() {
        let alertController = UIAlertController(title: "ADD FAV TASK", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter new task"
        }
        let save = UIAlertAction(title: "Save", style: .default) { (alert) in
            let textfield = alertController.textFields?[0].text
            if let text = textfield {
                self.model.favTask.append(text)
                self.tableView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
