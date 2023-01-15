//
//  ContentView.swift
//  UCLA
//
//  Created by Rohan Sehgal on 10/15/22.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    @State private var bannerView: GADBannerView?
    
    //passed API output and storing in var
    var APIoutput : [String: [String : [String] ]]
    
    var body: some View {

        let NoData = ["No Data displayed" : ["Nothing to show"]]
        
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea(.all)
                //v stack with your ucla dining hall text
                VStack {
                    //UCLA Dining Hall text / NAVBAR
                    HStack {
                        Image("UCLA designer text")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 44)
                        Text("Dining")
                            .font(.system(size: 32))
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("NavBar color"))
                    .edgesIgnoringSafeArea(.horizontal)
                    
                    
                    ScrollView {
                        
                        ZStack {
                            
                            VStack {
                                //Dining Hall buttons
                                VStack{
                                    
                                    let EpicuriaData = Hall(
                                        name: "Epicuria at Covel",
                                        dishes: APIoutput["Epicuria"] ?? NoData,
                                        image: "Epicuria at Covel"
                                    )
                                    
                                    let DeNeveData = Hall(
                                        name: "De Neve",
                                        dishes: APIoutput["DeNeve"] ?? NoData,
                                        image: "De Neve"
                                    )
                                    
                                    let BruinPlateData = Hall(
                                        name: "Bruin Plate",
                                        //change back to BruinPlate after testing
                                        dishes: APIoutput["BruinPlate"] ?? NoData,
                                        image: "Bruin Plate"
                                    )
                                    
                                    //Spacer()
                                    //Epicuria Icon
                                    NavigationLink(
                                        destination: Menu(hall: EpicuriaData),
                                        label: {
                                            FoodIcon(hall: EpicuriaData)
                                        })
                                    
                                    //De Neve Icon
                                    NavigationLink(
                                        destination: Menu(hall: DeNeveData),
                                        label: {
                                            FoodIcon(hall: DeNeveData)
                                        })
                                    
                                    //Bruin Plate icon
                                    NavigationLink(
                                        destination: Menu(hall: BruinPlateData),
                                        label: {
                                            FoodIcon(hall: BruinPlateData)
                                        })
                                    //Spacer()
                                }
                                
                                
                                //Restaurant text
                                HStack {
                                    Text("Quick Service Restaurants")
                                        .font(.system(size:28, weight: .medium, design: .default))
                                        .foregroundColor(.black)
                                }
                                
                                //Restaurant Buttons
                                VStack{
                                    let BruinCafeData = Hall(
                                        name: "Bruin Cafe",
                                        //dishes: APIoutput["BruinCafe"] ?? [NoData],
                                        image: "Bruin Cafe",
                                        fixed_menu: ["Bruin Cafe fixed menu 1", "Bruin Cafe fixed menu 2"],
                                        sections: 2,
                                        section_names: ["Lunch & Dinner", "Smoothies and Coffee"]
                                    )
                                    
                                    NavigationLink(
                                        destination: fixed_menu(hall: BruinCafeData),
                                        label: {
                                            FoodIcon(hall: BruinCafeData)
                                        })
                                    
                                    let EpicuriaAckermanData = Hall(
                                        name: "Epicuria at Ackerman",
                                        //dishes: APIoutput["EpicAtAckerman"] ?? [NoData],
                                        image: "Epicuria at Ackerman",
                                        fixed_menu: ["Ackerman fixed menu 1"],
                                        sections: 1
                                    )
                                    
                                    NavigationLink(
                                        destination: fixed_menu(hall: EpicuriaAckermanData),
                                        label: {
                                            FoodIcon(hall: EpicuriaAckermanData)
                                        })
                                    
                                    let DreyData = Hall(
                                        name: "The Drey",
                                        //dishes: APIoutput["Drey"] ?? [NoData],
                                        image: "the drey",
                                        fixed_menu: ["The Drey fixed menu 1"],
                                        sections: 1
                                    )
                                    
                                    NavigationLink(
                                        destination: fixed_menu(hall: DreyData),
                                        label: {
                                            FoodIcon(hall: DreyData)
                                        })
                                    
                                    let RendezvousData = Hall(
                                        name: "Rendezvous",
                                        //dishes: APIoutput["Rendezvous"] ?? [NoData],
                                        image: "Rendezvous",
                                        fixed_menu: ["Rendezvous fixed menu 1", "Rendezvous fixed menu 2", "Rendezvous fixed menu 3"],
                                        sections: 3,
                                        section_names: ["West", "East", "Boba"]
                                    )
                                    
                                    NavigationLink(
                                        destination: fixed_menu(hall: RendezvousData),
                                        label: {
                                            FoodIcon(hall: RendezvousData)
                                        })
                                    
                                    //let Cafe1919Data = Hall(
                                    //    name: "Cafe 1919",
                                    //    dishes: APIoutput["Cafe 1919"] ?? [NoData],
                                    //    image: "Cafe 1919"
                                    //)
                                    
                                    //NavigationLink(
                                    //    destination: Menu(hall: Cafe1919Data),
                                    //    label: {
                                    //        FoodIcon(hall: Cafe1919Data)
                                    //    })
                                    
                                    let DeNeveLateNightData = Hall(
                                        name: "De Neve Late Night",
                                        //dishes: APIoutput["DeNeveLateNight"] ?? [NoData],
                                        image: "De Neve Late Night",
                                        fixed_menu: ["De Neve fixed menu 1"],
                                        sections: 1
                                    )
                                    
                                    NavigationLink(
                                        destination: fixed_menu(hall: DeNeveLateNightData),
                                        label: {
                                            FoodIcon(hall: DeNeveLateNightData)
                                        })
                                    
                                    let TheStudyatHedrickData = Hall(
                                        name: "The Study at Hedrick",
                                        //dishes: APIoutput["HedrickStudy"] ?? [NoData],
                                        image: "The Study at Hedrick",
                                        fixed_menu: ["Hedrick fixed menu 1", "Hedrick fixed menu 2", "Hedrick fixed menu 3", "Hedrick fixed menu 4", "Hedrick fixed menu 5"],
                                        sections: 5,
                                        section_names: ["Cafe Bakery", "Breakfast", "Lunch & Dinner", "Beverages", "Market"]
                                    )
                                    
                                    NavigationLink(
                                        destination: fixed_menu(hall: TheStudyatHedrickData),
                                        label: {
                                            FoodIcon(hall: TheStudyatHedrickData)
                                        })
                                    
                                    let SpiceKitchen = Hall(
                                        name: "The Spice Kitchen",
                                        //dishes: [NoData],
                                        image: "The Spice Kitchen",
                                        fixed_menu: ["Spice Kitchen fixed menu 1"],
                                        sections: 1
                                    )
                                    
                                    NavigationLink(
                                        destination: fixed_menu(hall: SpiceKitchen),
                                        label: {
                                            FoodIcon(hall: SpiceKitchen)
                                        }
                                    )
                                }
                            }
                            .padding()
                        }
                    }.edgesIgnoringSafeArea(.all)
                    //ZStack {
                    // Add the banner view at the bottom of the screen.
                    
                    //}
                }
                //better to insert here that way your don't need that weird nav bottom thingy
            }.colorScheme(.light)
        }.preferredColorScheme(.light)

    }
}

struct ContentView_Previews: PreviewProvider {
    static let APIpreview = ["this" : ["is" : ["something"]]]
    
    static var previews: some View {
        // 5. Use the right SecondView initializator
        ContentView(APIoutput: APIpreview)
    }
}
