//
//  ViewController.swift
//  Kisiler Uygulamasi
//
//  Created by Yunus Emre Berdibek on 15.02.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var kisilerTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var kisilerListe = [Kisiler]()
    
    var aramaYapiliyorMu = false
    var aramaKelimesi:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        
        searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if aramaYapiliyorMu {
            aramaYap(arananKelime: aramaKelimesi!)
        } else{
            tumKisilerGetir()
        }
    }
    
    //Geçiş olduğunda algılanıyor
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indeks = sender as? Int
        
        if(segue.identifier == "toDetay"){
            let gidilecekVC = segue.destination as! KisiDetayViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
        
        if(segue.identifier == "toGuncelle"){
            let gidilecekVC = segue.destination as! KisiGuncelleViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
        
    }
    
    func tumKisilerGetir(){
        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php", method: .get).response { response in
            
            if let data = response.data {
                
                do {
                    let cevap = try JSONDecoder().decode(KisiCevap.self, from: data)
                    
                    if let gelenNotListesi = cevap.kisiler {
                        self.kisilerListe = gelenNotListesi
                    }else{
                        self.kisilerListe = [Kisiler]()
                    }
                    
                    DispatchQueue.main.async {
                        self.kisilerTableView.reloadData()
                    }
                    
                    
                } catch  {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    func aramaYap(arananKelime:String) {
        let params: Parameters = ["kisi_ad": arananKelime]
        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                
                do {
                    let cevap = try JSONDecoder().decode(KisiCevap.self, from: data)
                    
                    if let gelenKisiListesi = cevap.kisiler {
                        self.kisilerListe = gelenKisiListesi
                    } else{
                        self.kisilerListe = [Kisiler]()
                    }
                    
                    DispatchQueue.main.async {
                        self.kisilerTableView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    func kisiSil(kisi_id:Int){
        let params: Parameters = ["kisi_id": kisi_id]
        AF.request("http://kasimadalan.pe.hu/kisiler/delete_kisiler.php", method: .post, parameters: params).response { response in
            
            if let data = response.data {
                
                do {
                    let cevap = try JSONSerialization.jsonObject(with: data)
                    print(cevap)
                    
                    if self.aramaYapiliyorMu {
                        self.aramaYap(arananKelime: self.aramaKelimesi!)
                    } else{
                        self.tumKisilerGetir()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kisi = kisilerListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! kisiHucreTableViewCell
        cell.kisiYazıLabel.text = "\(kisi.kisi_ad!) - \(kisi.kisi_tel!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction, view, boolValue) in
            print("Sil tıklandı: \(self.kisilerListe[indexPath.row])")
            
            let kisi = self.kisilerListe[indexPath.row]
            
            if let kid = Int(kisi.kisi_id!) {
                self.kisiSil(kisi_id: kid)
            }
            
        }
        
        let guncelleAction = UIContextualAction(style: .normal, title: "Guncelle"){ (contextualAction, view, boolValue) in
            print("Güncelle tıklandı: \(self.kisilerListe[indexPath.row])")
            
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction, guncelleAction])
        
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        aramaKelimesi = searchText
        
        if aramaKelimesi == "" {
            aramaYapiliyorMu = false
        } else{
            aramaYapiliyorMu = true
        }
        
        aramaYap(arananKelime: aramaKelimesi!)
    }
}
