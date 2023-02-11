//
//  DeveloperSection.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 2/11/23.
//

import SwiftUI

struct Developer: Identifiable {
    let id = UUID()
    let name: String
    let position: String
    let linkedin: URL
}

struct DeveloperRow: View {
    let developer: Developer

    var body: some View {
        HStack {
            Image(uiImage: UIImage(named: developer.name)!)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(developer.name)
                    .font(.headline)
                Text(developer.position)
                    .font(.subheadline)
            }
            Spacer()
            Button(action: {
                // Open the developer's LinkedIn profile in Safari
                UIApplication.shared.open(self.developer.linkedin)
            }) {
                Image(systemName: "linkedin")
                    .imageScale(.large)
            }
        }
    }
}

struct DevelopersView: View {
    //let developers: [Developer]

    var body: some View {
        let developers = [    Developer(name: "Rohan Sehgal", position: "Founder/iOS Developer", linkedin:                              URL(string: "https://www.linkedin.com/in/rohansehgal2/")!),
                              //Developer(name: "Austin Wang", position: "Android Developer", linkedin: URL(string: "https://www.linkedin.com/in/austinwang0208/")!),
            ]
        VStack{
            List(developers) { developer in
                DeveloperRow(developer: developer)
            }
        }.frame(height: 150)
    }
}

struct DevelopersView_Previews: PreviewProvider {
    static var previews: some View {
        DevelopersView()
    }
}
