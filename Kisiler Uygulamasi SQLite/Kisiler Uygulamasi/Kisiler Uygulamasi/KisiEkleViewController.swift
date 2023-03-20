//
//  KisiEkleViewController.swift
//  Kisiler Uygulamasi
//
//  Created by Yunus Emre Berdibek on 15.02.2023.
//

import UIKit

class KisiEkleViewController: UIViewController {
    
    @IBOutlet weak var kisiTelTextfield: UITextField!
    @IBOutlet weak var kisiAdTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ekle(_ sender: Any) {
        
        if let ad = kisiAdTextfield.text, let tel = kisiTelTextfield.text {
            
            Kisilerdao().kisiEkle(kisi_ad: ad, kisi_tel: tel)
        }
    }

}
