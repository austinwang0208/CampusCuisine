//
//  ContentView.swift
//  Example
//
//  Created by Daniil Manin on 07.10.2021.
//  Copyright © 2021 Exyte. All rights reserved.
//

import SwiftUI
import ProgressIndicatorView

struct ProgressBar: View {
    
    @State private var showProgressIndicator: Bool = true
    @State private var progress: CGFloat = 0.0
    @State private var progressForDefaultSector: CGFloat = 0.0
    
    private let timer = Timer.publish(every: 1 / 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.width / 5
            
            VStack {
                
                ProgressIndicatorView(isVisible: $showProgressIndicator, type: .bar(progress: $progress, backgroundColor: .gray.opacity(0.25)))
                    .frame(height: 10.0)
                    .foregroundColor(Color(red: 208/255, green: 190/255, blue: 128/255))
                    .padding([.bottom, .horizontal], size)
                
//                ProgressIndicatorView(isVisible: $showProgressIndicator, type: .impulseBar(progress: $progress, backgroundColor: .gray.opacity(0.25)))
//                    .frame(height: 8.0)
//                    .foregroundColor(Color(red: 208/255, green: 190/255, blue: 128/255))
//                    .padding([.bottom, .horizontal], size)
                
            }
        }
        .onReceive(timer) { _ in
            switch progress {
            case ...0.3, 0.4...0.6:
                progress += 1 / 50
            case 0.3...0.4:
                progress += 1 / 10
            case 0.6...0.85:
                progress += 1/20
            case 0.85...0.99:
                progress += 1/100
              default:
                  break
            }
            
            if progressForDefaultSector >= 1.5 {
                progressForDefaultSector = 0
            } else {
                progressForDefaultSector += 1 / 10
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}

