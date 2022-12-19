//
//  ContentView.swift
//  Demo
//
//  Created by Eidinger, Marco on 12/19/22.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    @State var pasted: String?
    var body: some View {
        Form {
            TextField("Enter a text to be copied & pasted", text: $text)
            Button("Copy & Paste") {
                // copy
                UIPasteboard.general.string = text
                // paste
                if let copied = UIPasteboard.general.string {
                    pasted = copied
                }
            }
            LabeledContent("Pasted Value:", value: pasted ?? "n/a")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
