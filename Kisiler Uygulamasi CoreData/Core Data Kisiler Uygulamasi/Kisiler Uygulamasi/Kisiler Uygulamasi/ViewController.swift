//
//  ViewController.swift
//  Kisiler Uygulamasi
//
//  Created by Yunus Emre Berdibek on 15.02.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate


class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext //veritabanında veri kayıt işlemlerini yapar.
    
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
        tumKisilerAl()
        
        if(aramaYapiliyorMu){
            aramaYap(kisi_ad: aramaKelimesi!)
        } else{
            tumKisilerAl()
        }
        kisilerTableView.reloadData()//Tableview metodlarını çalıştırarak verileri güncelle.
        
    }
    
    //Geçiş olduğunda algılanıyor
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        if(segue.identifier == "toDetay"){
            let gidilecekVC =  segue.destination as! KisiDetayViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
        
        if(segue.identifier == "toGuncelle"){
            let gidilecekVC =  segue.destination as! KisiGuncelleViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
        
    }
    
    func tumKisilerAl(){
        do {
            kisilerListe = try context.fetch(Kisiler.fetchRequest())
        } catch  {
            print(error)
        }
    }
    
    func aramaYap(kisi_ad:String){
        let fetchRequest:NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "kisi_ad CONTAINS %@", kisi_ad)
        
        do {
            kisilerListe = try context.fetch(fetchRequest)
        } catch  {
            print(error)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! kisiHucreTableViewCell
        let kisi =  kisilerListe[indexPath.row]
        
        cell.kisiYazıLabel.text = "\(kisi.kisi_ad!) - \(kisi.kisi_tel!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction, view, boolValue) in
            
            let kisi = self.kisilerListe[indexPath.row]
            
            self.context.delete(kisi)
            appDelegate.saveContext()
            
            if(self.aramaYapiliyorMu){
                self.aramaYap(kisi_ad: self.aramaKelimesi!)
            }else{
                self.tumKisilerAl()
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
        
        aramaKelimesi = searchText
        
        if(searchText == ""){
            aramaYapiliyorMu = false
            tumKisilerAl()
        }else{
            aramaYapiliyorMu = true
            aramaYap(kisi_ad: aramaKelimesi!)
        }
        
        kisilerTableView.reloadData()
        
    }
}
