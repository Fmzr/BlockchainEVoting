//
//  ContentView.swift
//  voting
//
//  Created by Irfandi Kurniawan Anwar on 01/03/23.
//

import SwiftUI
import Glaip


struct ContentView: View {
    
    @ObservedObject private var glaip = Glaip(title: "Dvote Prototype", description: "Dvote Login", supportedWallets: [.MetaMask])
    
    @State private var showLoginScreen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 38 / 255, green: 49 / 255, blue: 89 / 255)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Decentralization eVoting")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Text("Blockchain for Voting")
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                        .frame(height: 75)
                    
                    Button("Meta Mask"){
                        glaip.loginUser(type: .MetaMask) { result in
                            switch result {
                            case .success(let user):
                                print(user.wallet.address)
                                showLoginScreen = true
                            case .failure(let error):
                                print(error)
                            }
                        }
                        
                    }
                    .padding()
                    .foregroundColor(Color(red: 38 / 255, green: 49 / 255, blue: 89 / 255))
                    
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    NavigationLink(destination: HellowView(), isActive: $showLoginScreen){
                        EmptyView()
                    }
                }
            }
            .navigationBarHidden(true)
        }
       
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


