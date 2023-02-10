import Foundation
import SwiftUI
import PDFKit

struct CustomPDFView: View {
    let displayedPDFURL: URL
    var body: some View {
        VStack {
            PDFKitRepresentedView(documentURL: displayedPDFURL)
                .accessibilityLabel("PDF from: \(displayedPDFURL)")
                .accessibilityValue("PDF of: \(displayedPDFURL)")
        }
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let documentURL: URL
    
    init (documentURL: URL)
    {
        self.documentURL = documentURL
    }
    
    func makeUIView(context: Context) -> some UIView {
        let pdfView: PDFView = PDFView()
        
        pdfView.autoresizesSubviews = true
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        pdfView.displayDirection = .vertical

        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displaysPageBreaks = true
        pdfView.document = PDFDocument(url: self.documentURL)
        
        
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) -> Void {
        //Do not put any code in here!!
    }
}

struct Fixed_Menu_Section: View {
    
    var hall: Hall
    var section_number: Int
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea(.all)
            VStack {
                VStack {
//                    let temp = hall.fixed_menu![section_number] + " pdf"
//                    let PDFurl = Bundle.main.url(forResource: temp, withExtension: "pdf")!//might need to add ! to unwrap unsure
                    let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
                    let newkey = hall.name.replacingOccurrences(of: " ", with: "_")
                    let pdfpath = directory!.appendingPathComponent("\(newkey)_Menu_\(section_number).pdf")
                    CustomPDFView(displayedPDFURL: pdfpath)
                    
                }.onAppear(perform: {printstuff(hall_name: hall.name, section_number: section_number)})
                VStack {
                    BannerAd(unitID: "ca-app-pub-7275807859221897/8994587990")
                }.frame(height: 45)
            }.navigationBarTitle("Menu - " + hall.name)
        }
    }
}

func printstuff(hall_name: String, section_number: Int){
    let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    let newkey = hall_name.replacingOccurrences(of: " ", with: "_")
    let pdfpath = directory!.appendingPathComponent("\(newkey)_Menu_\(section_number).pdf")
    print("pdfpath ", pdfpath)
}

struct Fixed_Menu_Section_Previews: PreviewProvider {
    static let HallPreview = Hall(
        name: "Bruin Cafe",
        fixed_menu: ["Bruin Cafe fixed menu 1", "Bruin Cafe fixed menu 2"],
        sections: 2,
        section_names: ["Lunch & Dinner", "Smoothies and Coffee"]
    )
    
    static var previews: some View {
        // 5. Use the right SecondView initializator
        fixed_menu(hall: HallPreview)
    }
}
