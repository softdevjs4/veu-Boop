//
//  UpdateBuddy.swift
//  Boop
//
//  Created by Ivan on 5/30/20.
//  Copyright © 2020 OKatBest. All rights reserved.
//

import Foundation

class UpdateBuddy: NSObject {
    
    @IBOutlet weak var statusView: StatusView!
    
    override init() {
        super.init()
        self.check()
    }
    
    func check() {
        
        guard let url = URL(string: "https://boop.okat.best/version.json") else {
            print("Cannot create update checker URL...")
            return
        }

        URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error -> Void in
            guard let data = data else {
                return
            }
            
            try? self.handleResponse(data: data)
            
        }).resume()
    }
    
    private func handleResponse(data: Data) throws {
        let decoder = JSONDecoder()
        
        let payload = try decoder.decode(VersionContainer.self, from: data)
        
        let latest = payload.standalone
        
        guard let thisVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return
        }
        
        if latest.version.compare(thisVersion, options: .numeric) == .orderedDescending {
            DispatchQueue.main.async {
                self.statusView.setStatus(.updateAvailable(latest.link))
            }
        }
    }
}
