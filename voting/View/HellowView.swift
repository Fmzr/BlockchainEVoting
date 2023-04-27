//
//  HellowView.swift
//  voting
//
//  Created by Irfandi Kurniawan Anwar on 01/03/23.
//

import SwiftUI

struct HellowView: View {
    
    @ObservedObject var smartContractInteraction = SmartContractInteraction()
    @ObservedObject var smartContractTransaction0 = SendTransaction0()
    @ObservedObject var smartContractTransaction1 = SendTransaction1()
    @State private var button1 = false
    @State private var button2 = false
    
   
    var body: some View {
        ZStack {
            Color(red: 38 / 255, green: 49 / 255, blue: 89 / 255)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Group{
                    Text(smartContractInteraction.judul)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                    
                    Spacer()
                        .frame(height: 25)
                }
                
                
                Group{
                    
                    Button(smartContractInteraction.namaKandidatPertama){
                        smartContractTransaction0.writeSmartContract0()
                        smartContractInteraction.suaraKandidatPertama += 1
                        button1 = true
                    }
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .foregroundColor(Color.black)
                    .font(.system(size: 25))
                    Spacer()
                        .frame(height: 20)
                    
                    ProgressView(String(smartContractInteraction.suaraKandidatPertama) ,value: Double(smartContractInteraction.suaraKandidatPertama), total: 17)
                    
                    if button1 == true {
                        Text(smartContractTransaction0.hash)
                            .contextMenu(ContextMenu(menuItems: {
                                Button("Copy"){
                                    UIPasteboard.general.string = smartContractTransaction0.hash
                                }
                            }))
                        
                    }
                    
                    Spacer()
                        .frame(height: 25)
                    
                    Button(smartContractInteraction.namaKandidatKedua){
                        smartContractTransaction1.writeSmartContract1()
                        smartContractInteraction.suaraKandidatKedua += 1
                        button2 = true
                    }
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .foregroundColor(Color.black)
                    .font(.system(size: 25))
                    Spacer()
                        .frame(height: 10)
                    
                    ProgressView(String(smartContractInteraction.suaraKandidatKedua), value: Double(smartContractInteraction.suaraKandidatKedua), total: 17)
                    
                    if button2 == true {
                        Text(smartContractTransaction1.hash)
                            .contextMenu(ContextMenu(menuItems: {
                                Button("Copy"){
                                    UIPasteboard.general.string = smartContractTransaction1.hash
                                }
                            }))
                    }
                }
                
                Group{
                    Spacer()
                        .frame(height: 45)
                    
                    NavigationLink(destination: EtherscanView(url: "https://goerli.etherscan.io/address/0x31f0a00a455bc377f4b92d8650c9a07c371dfbfa")) {
                        Text("ETHERSCAN")
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(15)
                            .foregroundColor(Color.black)
                    }
                }
                
                
                
                /*Button(smartContractTransaction0.hash){
                 
                 }*/
                
            }
            
            .onAppear{
                //self.smartContractTransaction0
                self.smartContractInteraction.callSmartContract()
                
                
            }
        }
        
    }
    
}


struct HellowView_Previews: PreviewProvider {
    static var previews: some View {
        HellowView()
    }
}
