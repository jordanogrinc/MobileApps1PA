//
//  SecondViewController.swift
//  MobileApps1PA
//
//  Created by Jordan Ogrinc on 9/11/21.
//

import UIKit
import FirebaseDatabase

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let ref = Database.database().reference()
        let num = 1
        var rescount = 0
        // check connection ref.child("restaurants/test").setValue("jordan")
        ref.child("restaurants/").observeSingleEvent(of: .value, with: {snapshot in guard let allres = snapshot.value as? [String: Any] else {
            return}
            rescount = allres.count
            print("All Restaurants: \(rescount)")
        })
        
        ref.child("restaurants/res\(num)").observeSingleEvent(of: .value, with: {snapshot in guard let value = snapshot.value as? [String: Any] else {
            return}
            print("Value: \(value)")
        })
    }
    
    @IBAction func secondbtn(_ sender: Any) {
        print("TEST")
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
