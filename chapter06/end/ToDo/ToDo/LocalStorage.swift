//
//  LocalStorage.swift
//  ToDo
//
//  Created by Nour Araar on 11/25/21.
//

import Foundation

protocol LocalStorage {
    func save<T: Codable>(items: T);
    func load<T: Codable>() -> [T];
    func clear();
}

class FileLocalStorage: LocalStorage {

    private let fileName: String
    init(fileName: String = "todoitems") {
      self.fileName = fileName
    }
    
    func save<T>(items: T) where T : Decodable, T : Encodable {
        let url = FileManager.default
          .documentsURL(name: fileName)

        do {
          let data = try JSONEncoder().encode(items)
          try data.write(to: url)
        } catch {
          print("error: \(error)")
        }
    }
    
    func load<T>() -> [T] where T : Decodable, T : Encodable {
        let url = FileManager.default
          .documentsURL(name: fileName)
          do {
            let data = try Data(contentsOf: url)
           let items = try JSONDecoder()
              .decode([T].self, from: data)
              return items
          } catch {
            print("error: \(error)")
            return []
          }
    }
    
    func clear() {
        let url = FileManager.default
          .documentsURL(name: fileName)
        try? FileManager.default.removeItem(at: url)
    }
}
