//
//  Kisiler.swift
//  Kisiler Uygulamasi
//
//  Created by Yunus Emre Berdibek on 1.03.2023.
//

import Foundation

class Kisiler
{
    var kisi_id:Int?
    var kisi_ad:String?
    var kisi_tel:String?
    
    init() {}
    
    init(kisi_id: Int, kisi_ad: String, kisi_tel: String) {
        self.kisi_id = kisi_id
        self.kisi_ad = kisi_ad
        self.kisi_tel = kisi_tel
    }
}
