//
//  FillInView.swift
//  schoolSelector test
//
//  Created by Rohan Sehgal on 1/15/23.
//

import SwiftUI
import UIKit

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings View")
        }.navigationBarTitle("Settings")
    }
}

struct SelectedView: View {
    @Binding var selectedKey: String?
    var body: some View {
        NavigationView {
            VStack {
                Text("Selected Key: \(selectedKey!)")
                Spacer()
            }
            .navigationBarTitle("Selected Key")
            .navigationBarItems(trailing:
                Button(action: {
                    // navigate to settings view
                }) {
                    Image(systemName: "gear")
                }
            )
        }
    }
}

struct FillInView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedKey: String?
    @State private var searchText: String = ""
    let options = ["option1": "key1", "option2": "key2", "option3": "key3", "option4": "key4", "option5": "key5"]
    let defaults = UserDefaults.standard

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            if !searchText.isEmpty {
                List {
                    ForEach(options.filter({searchText.isEmpty ? true : $0.key.localizedCaseInsensitiveContains(searchText)}), id: \.key) { option in
                        Text(option.key)
                            .onTapGesture {
                                self.selectedKey = option.value
                                self.defaults.set(option.value, forKey: "selectedKey")
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
            }
        }
    }
}

//Search Bar struct

struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}


struct FillInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FillInView(selectedKey: .constant(""))
            FillInView(selectedKey: .constant("key2"))
        }
    }
}
