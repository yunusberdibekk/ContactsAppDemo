//
//  KisiGuncelleViewController.swift
//  Kisiler Uygulamasi
//
//  Created by Yunus Emre Berdibek on 15.02.2023.
//

import UIKit
import Firebase

class KisiGuncelleViewController: UIViewController {
    
    @IBOutlet weak var kisiTelTextfield: UITextField!
    @IBOutlet weak var kisiAdTextfield: UITextField!
    
    var ref: DatabaseReference!
    var kisi:Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        if let k = kisi {
            kisiAdTextfield.text = k.kisi_ad
            kisiTelTextfield.text = k.kisi_tel
        }
    }
    
    @IBAction func guncelle(_ sender: Any) {
        
        if let k = kisi, let  ad = kisiAdTextfield.text, let tel = kisiTelTextfield.text {
            kisiGuncelle(kisi_id:k.kisi_id!, kisi_ad:ad, kisi_tel:tel)        }
    }
    
    func kisiGuncelle(kisi_id:String, kisi_ad:String, kisi_tel:String) {
        
        let dict:[String:Any] = ["kisi_ad":kisi_ad, "kisi_tel":kisi_tel]
        
        ref.child("kisiler").child(kisi_id).updateChildValues(dict)
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
