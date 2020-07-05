//
//  Script+Require.swift
//  Boop
//
//  Created by Ivan on 6/29/20.
//  Copyright © 2020 OKatBest. All rights reserved.
//

import Foundation
import JavaScriptCore

extension Script {
    
    static private let boopPrefix = "@boop/"
    static private let moduleExt = ".js"
    
    func setupRequire() {
        let require: @convention(block) (String) -> (JSValue?) = {
            path in
            
            let savedExports = self.context.objectForKeyedSubscript("exports")

            
            var path = path
            
            if !path.hasSuffix(Script.moduleExt) {
                path += Script.moduleExt
            }
            
            guard
                let url = self.url(for: path),
                let rawCode = try? String(contentsOf: url)
            else {
                return nil
            }
            
            // This is not ideal, I tried using native JSC bindings
            // but no luck getting it to play nice. TODO I guess?
            
           let wrappedCode =
"""
/***********************************
*     Start of Boop's wrapper      *
***********************************/
            
(function() {
    var module = {
        exports: {}
    };
            
    const moduleWrapper = (function (exports, module) {

/***********************************
 *      End of Boop's wrapper      *
 ***********************************/

\(rawCode)
            
/***********************************
*     Start of Boop's wrapper      *
***********************************/
            
    }).apply(module.exports, [module.exports, module]);

    return module.exports;
})();
            
/***********************************
*      End of Boop's wrapper      *
***********************************/
            
"""
            
            return self.context.evaluateScript(wrappedCode, withSourceURL: url)
        }
        
        self.context.setObject(require, forKeyedSubscript: "require" as NSString)

    }
    
    private func url(for path: String) -> URL? {
        if path.starts(with: Script.boopPrefix) {
            let fileName = String(path.dropFirst(Script.boopPrefix.count).dropLast(3))
            return Bundle.main.url(forResource: fileName, withExtension: Script.moduleExt, subdirectory: "scripts/lib")
        }
        
        return nil
                   
    }
}
