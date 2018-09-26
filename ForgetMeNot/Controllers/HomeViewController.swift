//
//  HomeViewController.swift
//  ForgetMeNot
//
//  Created by Elle Gover on 9/24/18.
//  Copyright © 2018 com.detroitlabs. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var events: [Event] = []
    var selectedEventIndex: Int?
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentDate()
        populateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        cell.textLabel?.text = getTimeIntervalString(event: events[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedEventIndex = indexPath.row
        return indexPath
    }
    
    func populateData() {
        let eventDatabase = EventDatabase()
        for event in eventDatabase.events {
            events.append(event)
        }
    }
    
    func getTimeIntervalString(event: Event) -> String {
        let eventDate = event.dateOfEvent
        let timeIntervalInSeconds = event.countdownToEvent(dateOfEvent: eventDate)
        return "\(event.formatTimeInterval(seconds: timeIntervalInSeconds)) until \(event.eventTitle)"
    }

    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let today = Date()
        let todayString = dateFormatter.string(from: today)
        let formattedToday = dateFormatter.date(from: todayString)
        
        return dateFormatter.string(from: formattedToday!)
    }
    
    func displayCurrentDate() {
        
        dateLabel.text = "Today is \(formattedDate())"
    }
    


}
