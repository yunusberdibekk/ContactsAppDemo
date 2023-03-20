//
//  ViewController.swift
//  Kisiler Uygulamasi
//
//  Created by Yunus Emre Berdibek on 15.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var kisilerTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var kisilerListe = [Kisiler]()
    
    var aramaYapildiMi = false
    var arananKelime:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        veritabaniKopyala()
        
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (aramaYapildiMi){
            kisilerListe = Kisilerdao().aramaYap(kisi_ad: arananKelime!)
        } else{
            kisilerListe = Kisilerdao().tumKisilerAl()
        }
        
        kisilerTableView.reloadData()
    }
    
    //Geçiş olduğunda algılanıyor
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int

        if(segue.identifier == "toGuncelle"){
            let gidilecekVC = segue.destination as! KisiGuncelleViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
        
        if(segue.identifier == "toDetay"){
            let gidilecekVC = segue.destination as! KisiDetayViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
        
    }
    
    func veritabaniKopyala(){
        
        let bundleYolu = Bundle.main.path(forResource: "kisiler", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("kisiler.sqlite")
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabanı zaten var. Kopyalamaya gerek yok.")
        } else{
            do {
                
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            } catch  {
                print(error)
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
        
        cell.kisiYazıLabel.text = "\(kisi.kisi_ad!)-\(kisi.kisi_tel!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction, view, boolValue) in
            let kisi = self.kisilerListe[indexPath.row]
            
            Kisilerdao().kisiSil(kisi_id: kisi.kisi_id!)
            
            if (self.aramaYapildiMi){
                self.kisilerListe = Kisilerdao().aramaYap(kisi_ad: self.arananKelime!)
            } else{
                self.kisilerListe = Kisilerdao().tumKisilerAl()
            }
            
            self.kisilerTableView.reloadData()
        }
        
        let guncelleAction = UIContextualAction(style: .normal, title: "Guncelle"){ (contextualAction, view, boolValue) in
            
            
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction, guncelleAction])
        
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        arananKelime = searchText
        print("Arama sonuç: \(searchText)")
        
        if arananKelime == ""{
            aramaYapildiMi = false
        } else{
            aramaYapildiMi = true
        }
        
        kisilerListe = Kisilerdao().aramaYap(kisi_ad: arananKelime!)
        
        kisilerTableView.reloadData()
    }
}
