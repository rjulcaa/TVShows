//
//  AuthenticationView.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 21/06/23.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication

struct AuthenticationView: View {
    
    @Binding var isUnlocked: Bool
    @State private var hasPIN: Bool = false
    @State private var pin: String = ""
    
    let pinLimit: Int = 5
    @State private var pinValidationError: Bool = false
    @State private var incorrectPINError: Bool = false
    @State private var hasTouchId: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            if hasPIN {
                Text("Insert PIN to enter")
                    .mainTitleStyle()
            } else {
                Text("Setup PIN to enter")
                    .mainTitleStyle()
            }
            SecureField("PIN", text: $pin)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .onReceive(Just(pin)) { _ in
                    if pin.count > pinLimit {
                        pin = String(pin.prefix(pinLimit))
                    }
                    pinValidationError = pin.count < pinLimit
                }
            if pinValidationError {
                Text("Your PIN must have \(pinLimit) characters")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(.red)
            } else if incorrectPINError {
                Text("Please enter the correct PIN")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(.red)
            }
            Spacer()
            if hasTouchId {
                Button("Try with Fingerprint") {
                    validateWithFingerprint()
                }
            }
            Button(hasPIN ? "Enter App" : "Register PIN") {
                if hasPIN {
                    validatePIN()
                } else {
                    registerPIN()
                }
            }
            .padding(.vertical, 25)
            
        }
        .onAppear {
            self.hasPIN = TVShowsKeychain.getPIN() != nil
            self.checkIfFingerprintisAvailable()
        }
        
    }
    
    func registerPIN() {
        TVShowsKeychain.savePIN(pin)
        isUnlocked = true
    }
    
    func validatePIN() {
        guard let currentPIN = TVShowsKeychain.getPIN() else {
            return
        }
        if currentPIN == pin {
           isUnlocked = true
        } else {
            incorrectPINError = true
        }
    }
    
    func checkIfFingerprintisAvailable() {
        let authContext = LAContext()
        let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        self.hasTouchId = authContext.biometryType == .touchID
    }
    
    func validateWithFingerprint() {
        let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "We need to your fingerprint to access TV Shows API"

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    self.isUnlocked = success
                }
            }
    }
    
}


