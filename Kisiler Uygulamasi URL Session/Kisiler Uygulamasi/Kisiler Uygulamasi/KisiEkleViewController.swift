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
        
        if let kisi_ad = kisiAdTextfield.text, let kisi_tel = kisiTelTextfield.text {
            kisiEkle(kisi_ad: kisi_ad, kisi_tel: kisi_tel)
        }
        
    }
    
    func kisiEkle(kisi_ad:String, kisi_tel:String) {
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php")!)
        request.httpMethod = "POST"
        let postString = "kisi_ad=\(kisi_ad)&kisi_tel=\(kisi_tel)"
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
