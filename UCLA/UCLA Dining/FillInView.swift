//
//  FillInView.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/15/23.
//

import SwiftUI
import UIKit

struct FillInView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedKey: String?
    @State private var searchText: String = ""
    let options = [
        "University of California, Berkeley": "key1",
        "University of California, Los Angeles": "diningmenus",
        "University of California, San Diego": "key2",
        "University of California, Santa Barbara": "ucsbdiningmenus",
        "University of California, Irvine" : "key4",
        "University of California, Davis": "key5",
        "University of California, Santa Cruz" : "key6",
        "University of California, Riverside" : "key7",
        "University of California, Merced" : "key8",
        "Stanford" : "key9"
    ]
    let defaults = UserDefaults.standard

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            //if !searchText.isEmpty {
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
                .transition(.move(edge: .top))
            //}
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
