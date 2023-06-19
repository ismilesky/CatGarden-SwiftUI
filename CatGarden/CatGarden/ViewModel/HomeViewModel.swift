//
//  HomeViewModel.swift
//  CatGarden
//
//  Created by edy on 2023/6/16.
//

import Foundation
import Combine

/**
 @EnvironmentObject：@EnvironmentObject用于将全局共享的数据对象传递给视图层次结构中的多个视图。您可以通过在视图中声明该属性包装器并提供适当类型的全局共享对象来实现此目的。视图可以使用该属性包装器访问和修改共享对象的状态。

 @StateObject：@StateObject用于在视图中创建并持有一个独立的可观察对象。这个可观察对象的生命周期将与视图相同，即在视图销毁时，该对象也会被销毁。它通常用于在视图中管理和维护私有状态。

 @Published：@Published用于将属性标记为可观察的。当使用@Published标记的属性发生更改时，它会自动发布通知，以便订阅该属性的视图可以接收到更新。通常，@Published用于组合和发布数据模型中的属性变化。
 
 @State 是 SwiftUI 中用于管理视图内部状态的属性包装器。
 使用 @State 标记的属性将作为视图的一部分，并且当属性的值发生变化时，视图将自动刷新。这使得在 SwiftUI 中创建响应式的用户界面变得非常简单。
 
 @ObservableObject 是 SwiftUI 中用于创建可观察对象的属性包装器。
 使用 @ObservableObject 标记的属性将作为可观察对象存在，当对象的属性发生变化时，与之关联的视图将自动更新。这使得在 SwiftUI 中管理和传递共享的状态数据变得更加简单和方便。
 @ObservableObject 是 SwiftUI 中用于创建可观察对象的属性包装器。通过将属性标记为 @Published，我们可以实现对属性变化的自动观察，并使与之关联的视图自动更新。
 
 
 @Binding 是 SwiftUI 中用于创建双向绑定的属性包装器。它使得在父视图和子视图之间实现数据的双向同步变得非常简单和方便。
 @Binding 属性只能用于引用类型（class）的属性，因此它通常与 @State 属性一起使用。
 
 */

class HomeViewModel: ObservableObject {
    @Published var hairType: HairType = .Short
    
    /// 数据
    @Published var cats: [Cat] = []
    
    /// 过滤
    @Published var filteredCats: [Cat] = []

    
    // 搜索处理
    @Published var searchText: String = ""
    @Published var searchedCats: [Cat]?
    
    // 用于管理搜索订阅
    var searchCancellable: AnyCancellable?
    
    init() {
        loadData()
        
        filterCatsByType()
        
        // Combine 是一个用于处理异步事件流的框架
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in  //  使用 sink 操作符订阅一个数据发布者
                // 处理接收到的数据
                if str != ""{
                    self.filterProductBySearch()
                }
                else{
                    self.searchedCats = nil
                }
            })
    }
    
    /// 加载json数据
    private func loadData() {
        if let url = Bundle.main.url(forResource: "cat", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                cats = try decoder.decode([Cat].self, from: data)
                
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    /// 过滤出4条数据
    func filterCatsByType(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.cats
                .lazy
                .filter { cat in
                    
                    return cat.hairType == self.hairType.rawValue
                }
                .prefix(4)
            
            DispatchQueue.main.async {
                
                self.filteredCats = results.compactMap({ cat in
                    return cat
                })
            }
        }
    }
    
    /// 搜索数据
    func filterProductBySearch(){
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.cats
                .lazy
                .filter { cat in
                    return cat.name.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                self.searchedCats = results.compactMap({ cat in
                    return cat
                })
            }
        }
    }
    
}
