//
//  CatRecord.swift
//  CatGarden
//
//  Created by edy on 2023/6/14.
//

import Foundation

struct CatRecord: Identifiable {
    let id = UUID()
    let date: Date
    var fedFood: Bool
    var fedWater: Bool
}
