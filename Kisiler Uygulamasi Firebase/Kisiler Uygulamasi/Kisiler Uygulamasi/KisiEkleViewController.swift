//
//  KisiEkleViewController.swift
//  Kisiler Uygulamasi
//
//  Created by Yunus Emre Berdibek on 15.02.2023.
//

import UIKit
import Firebase

class KisiEkleViewController: UIViewController {

    @IBOutlet weak var kisiTelTextfield: UITextField!
    @IBOutlet weak var kisiAdTextfield: UITextField!
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    

    @IBAction func ekle(_ sender: Any) {
        
        if let ad = kisiAdTextfield.text, let tel = kisiTelTextfield.text {
            notEkle(kisi_ad: ad, kisi_tel: tel)
        }
    }
    
    func notEkle(kisi_ad:String, kisi_tel:String) {
        
        let dict:[String:Any] = ["kisi_ad":kisi_ad, "kisi_tel":kisi_tel]
        
        let newRef = ref.child("kisiler").childByAutoId()
        
        newRef.setValue(dict)
        
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
