//
//  KisiGuncelleViewController.swift
//  Kisiler Uygulamasi
//
//  Created by Yunus Emre Berdibek on 15.02.2023.
//

import UIKit

class KisiGuncelleViewController: UIViewController {

    @IBOutlet weak var kisiTelTextfield: UITextField!
    @IBOutlet weak var kisiAdTextfield: UITextField!
    
    var kisi:Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let k = kisi {
            kisiAdTextfield.text = k.kisi_ad
            kisiTelTextfield.text = k.kisi_tel
        }
    }
    
    @IBAction func guncelle(_ sender: Any) {
        if let ad = kisiAdTextfield.text, let tel = kisiTelTextfield.text {
            
            if let k = kisi {
                Kisilerdao().kisiGuncelle(kisi_id: k.kisi_id!, kisi_ad: ad, kisi_tel: tel)
            }
        }
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
