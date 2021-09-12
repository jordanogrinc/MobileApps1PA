//
//  SecondViewController.swift
//  MobileApps1PA
//
//  Created by Jordan Ogrinc on 9/11/21.
//

import UIKit
import FirebaseDatabase
import MapKit

class SecondViewController: UIViewController {
    public var rescount = 0
    let apiKey = "f4e748441e400659b6033a3abbead4c9"

    
    @IBOutlet weak var resNameText: UILabel!
    
    @IBOutlet weak var resAddr1Text: UILabel!
    
    @IBOutlet weak var resAddr2Text: UILabel!
    
    @IBOutlet weak var TempDisplay: UILabel!
    
    @IBOutlet weak var TempTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let ref = Database.database().reference()
        //let num = 1
        //public var rescount = 0
        // check connection ref.child("restaurants/test").setValue("jordan")
        
        //will need the count of the number of restaurants for bounds of random
        ref.child("restaurants/").observeSingleEvent(of: .value, with: {snapshot in guard let allres = snapshot.value as? [String: Any] else {
            return}
            self.rescount = allres.count
            
            //print("All Restaurants: \(self.rescount)")
        })
    
    }
    
    @IBAction func secondbtn(_ sender: Any) {
        let hapgen = UINotificationFeedbackGenerator()
        hapgen.notificationOccurred(.success)
        let ref = Database.database().reference()
        ref.child("restaurants/res\(Int.random(in:0..<(self.rescount)))").observeSingleEvent(of: .value, with: {snapshot in guard let value = snapshot.value as? [String: Any] else {
            return}
            let resName = value["name"] as? String ?? ""
            let resAddr1 = value["addr1"] as? String ?? ""
            let resAddr2 = value["addr2"] as? String ?? ""
            let resCity = value["city"] as? String ?? ""
            let resState = value["state"] as? String ?? ""
            
            self.resNameText.text = "\(resName)"
            self.resAddr1Text.text = "\(resAddr1)"
            self.resAddr2Text.text = "\(resAddr2)"
            self.TempTitle.text = "\(resCity) Current Temperature:"
            //print("TEST : https://api.openweathermap.org/data/2.5/weather?q=\(resCity),\(resState.lowercased()),usa&appid=\(self.apiKey)")
            if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(resCity),\(resState.lowercased()),usa&appid=\(self.apiKey)") {
                URLSession.shared.dataTask(with: url) {
                    data, respose, error in
                    if let data = data {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print(jsonString)
                        }
                    }
                }.resume()
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
