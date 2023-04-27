//
//  Web3Write1.swift
//  voting
//
//  Created by Irfandi Kurniawan Anwar on 03/03/23.
//

import Web3

class SendTransaction1: ObservableObject {
    
    @Published var hash: String = ""
    
    func writeSmartContract1() {
        
        let web3 = Web3(rpcURL: "https://goerli.infura.io/v3/049172870f3942feb27cd4e6dcd933ab")
        
        do {
            let account = try! EthereumPrivateKey(hexPrivateKey: "0x75f44eeb64f1802773eb6595062feb5f6e2063b6356a08b265de1c17a66ce050")
            
            
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
            
            
            
            firstly {
                web3.eth.getTransactionCount(address: account.address, block: .latest )
            }.done { nonce in
                // Contract transaction
                guard let transaction = contract["vote"]?(BigUInt(1)).createTransaction(nonce: nonce, from: account.address, value: 0, gas: EthereumQuantity(150000), gasPrice: EthereumQuantity(quantity: 21.gwei)
                ) else{
                    return
                }
                let signedTX = try transaction.sign(with: account, chainId: 5)
                
                firstly {
                    web3.eth.sendRawTransaction(transaction: signedTX)
                }.done { txHash in
                    self.hash = txHash.hex()
                    print(txHash.hex())
                }.catch { error in
                    print(error)
                }
            }.catch { error in
                print(error)
            }
            
        } catch {
            print("Is : ", error.localizedDescription)
        }
    }
    
}


