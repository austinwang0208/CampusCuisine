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
    @Binding var refresh: Bool
    @State private var searchText: String = ""
    let options = [
        "University of California, Berkeley": "ucbdiningmenus",
        "University of California, Los Angeles": "diningmenus",
        "University of California, San Diego": "ucsddiningmenus",
        "University of California, Santa Barbara": "ucsbdiningmenus",
        "University of California, Irvine" : "ucidiningmenus",
        "University of California, Davis": "ucddiningmenus",
        "University of California, Santa Cruz" : "ucscdiningmenus",
        "University of California, Riverside" : "ucrdiningmenus",
        "University of California, Merced" : "ucmdiningmenus",
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
                                self.refresh.toggle()
                                self.presentationMode.wrappedValue.dismiss()
//                                LaunchAnimation(selectedKey: selectedKey ?? "something wrong")
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
            FillInView(selectedKey: .constant(""), refresh: .constant(false))
        }
    }
}
