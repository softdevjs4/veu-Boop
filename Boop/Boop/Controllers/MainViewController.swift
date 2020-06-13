//
//  MainViewController.swift
//  Boop
//
//  Created by Ivan on 1/26/19.
//  Copyright © 2019 OKatBest. All rights reserved.
//

import Cocoa
import SavannaKit

class MainViewController: NSViewController {

    @IBOutlet weak var editorView: SyntaxTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        editorView.delegate = self
        editorView.theme = DefaultTheme()
        
        editorView.contentTextView.selectedTextAttributes = [.backgroundColor:NSColor(red:0.19, green:0.44, blue:0.71, alpha:1.0), .foregroundColor: NSColor.white]
        
    }
    @IBAction func openHelp(_ sender: Any) {
        guard let url = URL(string: "https://github.com/IvanMathy/Boop/blob/master/Boop/Documentation/Readme.md") else {
            assertionFailure("Could not generate help URL.")
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    @IBAction func clear(_ sender: Any) {
        let textView = editorView.contentTextView
        textView.textStorage?.beginEditing()
        
        let range = NSRange(location: 0, length: textView.string.count)
        
        
        guard textView.shouldChangeText(in: range, replacementString: "") else {
            return
        }
        

        textView.textStorage?.replaceCharacters(in: range, with: "")
        
        textView.textStorage?.endEditing()
        textView.didChangeText()
    }
}

extension MainViewController: SyntaxTextViewDelegate {
    func didChangeText(_ syntaxTextView: SyntaxTextView) {
        
    }
    
    func didChangeSelectedRange(_ syntaxTextView: SyntaxTextView, selectedRange: NSRange) {
        
    }
    
    func didChangeFont(_ font: Font) {
        //
    }
    
    func lexerForSource(_ source: String) -> Lexer {
        return BoopLexer()
    }
    
    
}
