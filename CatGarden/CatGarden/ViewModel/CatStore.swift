//
//  CatStore.swift
//  CatGarden
//
//  Created by edy on 2023/6/14.
//

import Foundation

class CatStore: ObservableObject {
    @Published var cats: [Cat] = []
    
    init() {
        loadCats()
        
        generateRandomCats()
    }
    
    func addCat(_ cat: Cat) {
        cats.append(cat)
        saveCats()
    }
    
    func deleteCat(at index: Int) {
        cats.remove(at: index)
        saveCats()
    }
    
    func deleteCat(_ cat: Cat) {
        if let index = cats.firstIndex(of: cat) {
            cats.remove(at: index)
        }
    }
    
    
    private func saveCats() {
        if let data = try? JSONEncoder().encode(cats) {
            UserDefaults.standard.set(data, forKey: "cats")
        }
    }
    
    private func loadCats() {
        if let data = UserDefaults.standard.data(forKey: "cats"),
           let savedCats = try? JSONDecoder().decode([Cat].self, from: data) {
            cats = savedCats
        }
    }
    
    
    func generateRandomCats() {
        let catNames = ["Whiskers", "Mittens", "Simba", "Luna", "Oliver", "Max", "Bella", "Charlie", "Lucy", "Leo"]
        let catBreeds = ["Persian", "Siamese", "Maine Coon", "Bengal", "Ragdoll", "Sphynx", "British Shorthair"]
        
        for _ in 1...10 {
            let randomName = catNames.randomElement() ?? "Unknown"
            let randomAge = Int.random(in: 1...20)
            let randomBreed = catBreeds.randomElement() ?? "Mixed Breed"
            let randomImageName = "https://s1.ax1x.com/2023/06/14/pCnqQbt.jpg"
            
            let cat = Cat(name: randomName)
            cats.append(cat)
        }
    }
}
