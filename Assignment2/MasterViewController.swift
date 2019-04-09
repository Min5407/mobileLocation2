//
//  MasterViewController.swift
//  Assignment2
//
//  Created by Min young Go on 9/4/19.
//  Copyright © 2019 Min young Go. All rights reserved.
//

import UIKit


protocol detailCancel {
    func cancel()
}
class MasterViewController: UITableViewController, detailCancel {
    
    
    
    func cancel() {
        
        if bool == true{
            objects.removeLast()
        }
        bool = false
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    

    
    func detailViewControllerDidUpdate(_ detailViewController: DetailViewController) {
        // Update/reloading data
        tableView.reloadData()
    }

    var detailViewController: DetailViewController? = nil
    var objects = [Location]()
    var bool: Bool = false

    var indexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.reloadData()

    }

    @objc
    func insertNewObject(_ sender: Any) {
        let indexPath = IndexPath(row: objects.count, section: 0)
        objects.append(Location(name: "", address: "", long: 0, lat: 0))
        tableView.insertRows(at: [indexPath], with: .automatic)
        self.indexPath = indexPath
        bool = true
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let indexPath: IndexPath
            if let path = tableView.indexPathForSelectedRow {
                indexPath = path
                bool = false
            }
            else {
                guard let path = sender as? IndexPath
                    else {
                        fatalError()
                }
                indexPath = path
            }
            self.indexPath = indexPath
            let object = objects[indexPath.row]
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.detailItem = object
            controller.delegate = self
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[indexPath.row]
        cell.textLabel!.text = object.name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let move =  objects[sourceIndexPath.item]
        objects.remove(at: sourceIndexPath.item)
        objects.insert(move, at: destinationIndexPath.item)
        
        
        //
        
        
    }


}


