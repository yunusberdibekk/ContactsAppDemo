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
        
        if let k = kisi, let ad = kisiAdTextfield.text, let tel = kisiTelTextfield.text {
            
            if let kid = Int(k.kisi_id!) {
                kisiGuncelle(kisi_id: kid, kisi_ad: ad, kisi_tel: tel)
            }
        }
    }
    
    func kisiGuncelle(kisi_id:Int, kisi_ad:String, kisi_tel:String) {
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/update_kisiler.php")!)
        request.httpMethod = "POST"
        let postString = "kisi_id=\(kisi_id)&kisi_ad=\(kisi_ad)&kisi_tel=\(kisi_tel)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if error != nil || data == nil {
                print("Hata! ")
                return
            }
            
            do {
                if let d = data {
                    
                    if let json = try JSONSerialization.jsonObject(with: d) as? [String:Any]{
                        print(json)
                    }
                    
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
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
