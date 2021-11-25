//  Created by Dominik Hauser on 08.10.21.
//  
//

import Foundation
import Combine

class ToDoItemStore {
  var itemPublisher =
    CurrentValueSubject<[ToDoItem], Never>([])
  private var items: [ToDoItem] = [] {
    didSet {
      itemPublisher.send(items)
    }
  }
    var storage: LocalStorage
    
    init(storage: LocalStorage) {
        self.storage = storage
        loadItems()
    }

  func add(_ item: ToDoItem) {
    items.append(item)
    saveItems()
  }

  func check(_ item: ToDoItem) {
    var mutableItem = item
    mutableItem.done = true
    if let index = items.firstIndex(of: item) {
      items[index] = mutableItem
      saveItems()
    }
  }

    private func saveItems() {
        storage.save(items: items)
    }

    private func loadItems() {
        items = storage.load()
    }
}
