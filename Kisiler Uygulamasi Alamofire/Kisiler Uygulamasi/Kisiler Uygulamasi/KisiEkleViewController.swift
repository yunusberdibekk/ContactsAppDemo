//
//  KisiEkleViewController.swift
//  Kisiler Uygulamasi
//
//  Created by Yunus Emre Berdibek on 15.02.2023.
//

import UIKit
import Alamofire

class KisiEkleViewController: UIViewController {
    
    @IBOutlet weak var kisiTelTextfield: UITextField!
    @IBOutlet weak var kisiAdTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ekle(_ sender: Any) {
        
        if let kisi_ad = kisiAdTextfield.text, let kisi_tel = kisiTelTextfield.text {
            kisiEkle(kisi_ad: kisi_ad, kisi_tel: kisi_tel)
        }
        
    }
    
    func kisiEkle(kisi_ad:String, kisi_tel:String) {
        
        let params : Parameters = ["kisi_ad":kisi_ad, "kisi_tel":kisi_tel]
        AF.request("http://kasimadalan.pe.hu/kisiler/insert_kisiler.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                
                do {
                    let cevap = try JSONSerialization.jsonObject(with: data)
                    print(cevap)
                } catch  {
                    print(error.localizedDescription)
                }
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
