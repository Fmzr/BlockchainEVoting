//
//  Web3Call.swift
//  voting
//
//  Created by Irfandi Kurniawan Anwar on 01/03/23.
//

import Web3

class SmartContractInteraction: ObservableObject {
    
    @Published var judul: String = ""
    @Published var namaKandidatPertama: String = ""
    @Published var namaKandidatKedua: String = ""
    @Published var suaraKandidatPertama: BigUInt = 0
    @Published var suaraKandidatKedua: BigUInt = 0
    
    
    
    
    func callSmartContract() {
        
        let web3 = Web3(rpcURL: "https://goerli.infura.io/v3/049172870f3942feb27cd4e6dcd933ab")
        
        
        do {
            // define contract
            let contractABI = """
                [
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "person",
                                "type": "address"
                            }
                        ],
                        "name": "pesertaYangDiizinkan",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "string",
                                "name": "name",
                                "type": "string"
                            }
                        ],
                        "name": "tambahkanKandidat",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "string",
                                "name": "namaPemilihan",
                                "type": "string"
                            }
                        ],
                        "stateMutability": "nonpayable",
                        "type": "constructor"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "uint256",
                                "name": "voteIndex",
                                "type": "uint256"
                            }
                        ],
                        "name": "vote",
                        "outputs": [],
                        "stateMutability": "nonpayable",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "name": "candidates",
                        "outputs": [
                            {
                                "internalType": "string",
                                "name": "name",
                                "type": "string"
                            },
                            {
                                "internalType": "uint256",
                                "name": "voteCount",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "electionName",
                        "outputs": [
                            {
                                "internalType": "string",
                                "name": "",
                                "type": "string"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "jumlahKandidat",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "namaKandidatKedua",
                        "outputs": [
                            {
                                "internalType": "string",
                                "name": "",
                                "type": "string"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "namaKandidatPertama",
                        "outputs": [
                            {
                                "internalType": "string",
                                "name": "",
                                "type": "string"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "owner",
                        "outputs": [
                            {
                                "internalType": "address",
                                "name": "",
                                "type": "address"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "suaraKandidatKedua",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "suaraKandidatPertama",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [],
                        "name": "totalVotes",
                        "outputs": [
                            {
                                "internalType": "uint256",
                                "name": "",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    },
                    {
                        "inputs": [
                            {
                                "internalType": "address",
                                "name": "",
                                "type": "address"
                            }
                        ],
                        "name": "voters",
                        "outputs": [
                            {
                                "internalType": "bool",
                                "name": "authorized",
                                "type": "bool"
                            },
                            {
                                "internalType": "bool",
                                "name": "voted",
                                "type": "bool"
                            },
                            {
                                "internalType": "uint256",
                                "name": "vote",
                                "type": "uint256"
                            }
                        ],
                        "stateMutability": "view",
                        "type": "function"
                    }
                ]
                """.data(using: .utf8)!
            let contract = try web3.eth.Contract(json: contractABI, abiKey: nil, address: EthereumAddress(ethereumValue: "0x31F0a00a455Bc377f4b92D8650C9A07C371dFbfA"))
            
            //try call function "greet" in the contract
            contract["electionName"]?().call() { response, error in
                if let response = response,
                   let message = response[""] as? String {
                    DispatchQueue.main.async {
                        self.judul = message.description
                    }
                }
                else {
                    print(error?.localizedDescription ?? "Failed to get response")
                }
            }
            
            //try call function namaKandidatPertama from contract
            contract["namaKandidatPertama"]?().call() { response, error in
                if let response = response,
                   let message = response[""] as? String {
                    DispatchQueue.main.async {
                        self.namaKandidatPertama = message.description
                    }
                    
                }
                else {
                    print(error?.localizedDescription ?? "Failed to get response")
                }
            }
            
            //try call function namaKandidatKedua from contract
            contract["namaKandidatKedua"]?().call() { response, error in
                if let response = response,
                   let message = response[""] as? String {
                    DispatchQueue.main.async {
                        self.namaKandidatKedua = message.description
                    }
                    
                }
                else {
                    print(error?.localizedDescription ?? "Failed to get response")
                }
            }
            
            contract["suaraKandidatPertama"]?().call() { response, error in
                if let response = response,
                   let message = response[""] as? BigUInt {
                    DispatchQueue.main.async {
                        self.suaraKandidatPertama = message
                    }
                    
                }
                else {
                    print(error?.localizedDescription ?? "Failed to get response")
                }
            }
            
            contract["suaraKandidatKedua"]?().call() { response, error in
                if let response = response,
                   let message = response[""] as? BigUInt {
                    DispatchQueue.main.async {
                        self.suaraKandidatKedua = message
                    }
                    
                }
                else {
                    print(error?.localizedDescription ?? "Failed to get response")
                }
            }

            
        }  catch {
            // Error handling
            print(error.localizedDescription)
        }
        
    }
}

