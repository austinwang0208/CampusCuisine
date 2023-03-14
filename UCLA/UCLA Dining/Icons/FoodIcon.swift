//
//  FoodIcons.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 10/18/22.
//

import SwiftUI

struct FoodIcon: View {
    var hall: Hall
    var hours : [String: [String : [[Float]]]]
    var open : String
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            //background image
            
            
            if let image = hall.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    //.aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 200)
                    .cornerRadius(20)
                    .shadow(color: Color.black, radius: 10, x: 0, y: 0)
            }
            let color = changeColor(open: open)
            RoundedCorners(tl: 0, tr: 0, bl: 20, br: 20)
                .frame(width: 350, height: 40)
                .foregroundColor(.white)
            HStack {
                Text(hall.name)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 10))
                    .foregroundColor(.black)
                    .font(.system(size: 17, weight: .medium, design: .default))
                Spacer()
                //opendict[hall.name]!
                Text(open)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 20))
                    .foregroundColor(color)
                    .font(.system(size: 15, weight: .bold, design: .default))
            }.frame(width: 350, height: 40)
        }
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
    }
    
    func testresult(hours: [String: [String : [[Float]]]]){
        print(hours)
    }
    
    func changeColor(open: String) -> Color{
        if open == "Open"{
            return Color("light green")
        } else {
            return Color("light red")
        }
    }
}

//adding struct for custom rectangle to have only specific corners rounded
struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        let h = rect.size.height
        
        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)
        
        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        
        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        path.closeSubpath()

        return path
    }
}

//struct FoodIcon_Previews: PreviewProvider {
//        static let HallPreview = Hall(
//            selectedKey: "diningmenus",
//            name: "Bruin Plate"
//            //dishes: ["default preview menu"],
//            //image: "Epicuria at Covel"
//        )
//
//        static var previews: some View {
//            // 5. Use the right SecondView initializator
//            FoodIcon(hall: HallPreview)
//        }
//}
