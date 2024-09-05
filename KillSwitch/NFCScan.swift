//
//  NFCScan.swift
//  KillSwitch
//
//  Created by GooseMooz on 2024-08-29.
//

import CoreNFC

class NFCScan: NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    var nfcSession: NFCNDEFReaderSession?
    @Published var word: String = ""
    func scan(message: String) {
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = message
        nfcSession?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated: \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var result = ""
        for payload in messages.first!.records {
            result.append(String(decoding: payload.payload, as: Unicode.UTF8.self))
        }
        
        DispatchQueue.main.async {
            self.word = String(result.dropFirst(3))
        }
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("The session became active")
    }
}
