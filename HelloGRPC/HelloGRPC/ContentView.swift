//
//  ContentView.swift
//  HelloGRPC
//
//  Created by Koichi Saeki on 2020/03/13.
//  Copyright © 2020 Koichi Saeki. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name = ""
    @State private var message = ""
    
    var body: some View {
        VStack {
            TextField("Enter your name",
                      text: $name,
                      onEditingChanged: { _ in},
                      onCommit: {
                        self.name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
                        if (self.name.count != 0) {
                            do {
                                self.message = try Service.shared.sayHello(name: self.name)
                            } catch {
                                self.message = error.localizedDescription
                            }
                        } else {
                            self.message = ""
                        }
            }).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            Text(message)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
