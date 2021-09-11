//
//  SecondViewController.swift
//  MobileApps1PA
//
//  Created by Jordan Ogrinc on 9/11/21.
//

import UIKit
import FirebaseDatabase

class SecondViewController: UIViewController {
    public var rescount = 0

    @IBOutlet weak var NameText: UILabel!

    @IBOutlet weak var AddrText: UILabel!
    
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
            
            print("All Restaurants: \(self.rescount)")
        })
    
    }
    
    @IBAction func secondbtn(_ sender: Any) {
        let ref = Database.database().reference()
        ref.child("restaurants/res\(Int.random(in:0..<(self.rescount)))").observeSingleEvent(of: .value, with: {snapshot in guard let value = snapshot.value as? [String: Any] else {
            return}
            let resName = value["name"] as? String ?? ""
            //var resname = value["name"]
            print(value)
            print(resName)
            
            //self.NameText.text = "\(value["name"])"
            //print("Value: \(value.keys) and \(String(describing: value["name"]))")
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
