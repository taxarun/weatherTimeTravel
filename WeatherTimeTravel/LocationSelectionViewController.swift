//
//  LocationSelectionViewController.swift
//  WeatherTimeTravel
//
//  Created by Nikolay Ermakov on 04.11.2020.
//

import UIKit
import RxSwift

class LocationSelectionViewController: UITableViewController, DetailControllerProviderInterface {

    let detailNavigation : BehaviorSubject<NavigationDestination> = BehaviorSubject(value: .weatherTimeTravel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.reuseIdentifier())
        
        // Example on how can detail be changed dynamically
//        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] (Timer) in
//            let screen : NavigationDestination = Int.random(in: 0...1) == 0 ? .blank : .weatherTimeTravel
//            self?.detailNavigation.onNext(screen)
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - DetailControllerProviderInterface
    func getDetailNavigationObservable() -> BehaviorSubject<NavigationDestination> {
        detailNavigation
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 23
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseIdentifier(), for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Router.shared.navigateTo(screen: .weatherTimeTravel)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
