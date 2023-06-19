//
//  ShareDataModel.swift
//  CatGarden
//
//  Created by edy on 2023/6/19.
//

import Foundation

/// 用于数据共享
class ShareDataModel: ObservableObject {
    
    // 详情
    @Published var cat: Cat?
    @Published var showDetailCat: Bool = false
    
    // 搜索
    @Published var fromSearchPage: Bool = false
    @Published var searchActivated: Bool = false
    @Published var searchDetail: Bool = false

    
    init() {
        loadCats()
    }
    
    // MARK: - 收藏操作
    @Published var collecCats: [Cat] = []
    
    
    /// 添加收藏
    func addToCollect(_ descCat: Cat) {
        if let index = collecCats.firstIndex(where: { cat in
            return descCat.id == cat.id
        }){
            deleteCat(index)
        }
        else{
            addCat(descCat)
        }
    }

    func addCat(_ cat: Cat) {
        collecCats.append(cat)
        saveCats()
    }
    
    func deleteCat(_ index: Int) {
        collecCats.remove(at: index)
        saveCats()
    }
    
    private func saveCats() {
        if let data = try? JSONEncoder().encode(collecCats) {
            UserDefaults.standard.set(data, forKey: "cats")
        }
    }
    
    private func loadCats() {
        if let data = UserDefaults.standard.data(forKey: "cats"),
           let savedCats = try? JSONDecoder().decode([Cat].self, from: data) {
            collecCats = savedCats
        }
    }
    
}
