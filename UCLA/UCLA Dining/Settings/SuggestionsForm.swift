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
            }.frame(height:300)
            //.navigationBarTitle("Suggestions")
        }
    }
    
    func submitSuggestion(issue: String, contact: String) {
        let parameters: [String: Any] = ["issue": issue, "contact": contact]
        
        AF.request("https://your-api.com/submit_suggestion", method: .post, parameters: parameters)
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
