//
//  KisiDetayViewController.swift
//  Kisiler Uygulamasi
//
//  Created by Yunus Emre Berdibek on 15.02.2023.
//

import UIKit

class KisiDetayViewController: UIViewController {
    
    @IBOutlet weak var kisiTelLabel: UILabel!
    @IBOutlet weak var kisiAdLabel: UILabel!
    
    var kisi: Kisiler?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let k = kisi {
            kisiAdLabel.text = k.kisi_ad
            kisiTelLabel.text  = k.kisi_tel
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
