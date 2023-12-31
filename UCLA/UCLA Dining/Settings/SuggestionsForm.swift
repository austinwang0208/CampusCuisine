//
//  SuggestionsForm.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 2/11/23.
//

import SwiftUI
import Alamofire

struct SuggestionsForm: View {
    @State private var issue: String = ""
    @State private var contact: String = ""
    @State private var message: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack{
                    Form {
                        Section(header: Text("Issue")) {
                            TextField("Enter the issue", text: $issue)
                        }.frame(height:30)

                        Section(header: Text("Contact Information (optional)")) {
                            TextField("Enter your email or phone number", text: $contact)
                        }.frame(height:30)

                        Button(action: {
                            submitSuggestion(issue: self.issue, contact: self.contact)
                        }) {
                            Text("Submit Suggestion")
                        }.frame(height:30)

                        if !message.isEmpty {
                            Text(message)
                                .foregroundColor(.green)
                        }
                    }.frame(height: geometry.size.height)
                }
            }
        }
    }

    
    func submitSuggestion(issue: String, contact: String) {
        let parameters: [String: Any] = ["issue": issue, "contact": contact]
        let issue = issue.replacingOccurrences(of: " ", with: "_")
        let contact = contact.replacingOccurrences(of: " ", with: "_")
        AF.request("https://u5lrxx1mr4.execute-api.us-west-1.amazonaws.com/v1/usersuggestions?file=suggestions.txt&contact_info=\(contact)&issue=\(issue)", method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    self.message = "Suggestion submitted successfully"
                case .failure(let error):
                    self.message = "Failed to submit suggestion: \(error)"
                }
        }
    }
}


struct SuggestionsForm_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsForm()
    }
}
