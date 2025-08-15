//
//  ContentView.swift
//  cursor_test
//
//  Created by Tatwa on 14/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var kilograms: String = ""
    @State private var grams: Double = 0.0
    @State private var showingResult: Bool = false
    
    // Kenyan Flag Colors
    let kenyanBlack = Color(red: 0.0, green: 0.0, blue: 0.0)
    let kenyanRed = Color(red: 0.8, green: 0.0, blue: 0.0)
    let kenyanGreen = Color(red: 0.0, green: 0.4, blue: 0.0)
    let kenyanWhite = Color.white
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Header with Kenyan Flag Colors
                VStack(spacing: 15) {
                    // Flag-inspired header bar
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(kenyanBlack)
                            .frame(height: 8)
                        Rectangle()
                            .fill(kenyanRed)
                            .frame(height: 8)
                        Rectangle()
                            .fill(kenyanGreen)
                            .frame(height: 8)
                    }
                    .cornerRadius(4)
                    .padding(.horizontal)
                    
                    Image(systemName: "scalemass")
                        .font(.system(size: 60))
                        .foregroundColor(kenyanGreen)
                    
                    Text("Weight Converter")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(kenyanBlack)
                    
                    Text("Convert Kilograms to Grams")
                        .font(.subheadline)
                        .foregroundColor(kenyanRed)
                        .fontWeight(.medium)
                }
                .padding(.top, 20)
                
                // Input Section
                VStack(spacing: 15) {
                    Text("Enter weight in Kilograms")
                        .font(.headline)
                        .foregroundColor(kenyanBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("0.0", text: $kilograms)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(kenyanGreen, lineWidth: 2)
                        )
                        .onChange(of: kilograms) { _ in
                            convertWeight()
                        }
                }
                .padding(.horizontal)
                
                // Convert Button with Kenyan Flag Gradient
                Button(action: convertWeight) {
                    Text("Convert to Grams")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(kenyanWhite)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [kenyanRed, kenyanBlack]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(kenyanGreen, lineWidth: 2)
                        )
                }
                .padding(.horizontal)
                .disabled(kilograms.isEmpty)
                
                // Result Section with Kenyan Flag Theming
                if showingResult && !kilograms.isEmpty {
                    VStack(spacing: 10) {
                        Text("Result")
                            .font(.headline)
                            .foregroundColor(kenyanRed)
                            .fontWeight(.semibold)
                        
                        Text("\(grams, specifier: "%.0f") g")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(kenyanGreen)
                        
                        Text("\(kilograms) kg = \(grams, specifier: "%.0f") grams")
                            .font(.subheadline)
                            .foregroundColor(kenyanBlack)
                            .fontWeight(.medium)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(kenyanWhite)
                            .shadow(color: kenyanBlack.opacity(0.1), radius: 8, x: 0, y: 4)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [kenyanRed, kenyanGreen]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 3
                            )
                    )
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Info Section with Kenyan Flag Accent
                VStack(spacing: 8) {
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(kenyanBlack)
                            .frame(width: 30, height: 4)
                        Rectangle()
                            .fill(kenyanRed)
                            .frame(width: 30, height: 4)
                        Rectangle()
                            .fill(kenyanGreen)
                            .frame(width: 30, height: 4)
                    }
                    .cornerRadius(2)
                    
                    Text("1 kg = 1,000 g")
                        .font(.caption)
                        .foregroundColor(kenyanBlack)
                        .fontWeight(.medium)
                }
                .padding(.bottom)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [kenyanWhite, Color.gray.opacity(0.05)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationBarHidden(true)
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    private func convertWeight() {
        guard let kg = Double(kilograms), kg >= 0 else {
            // Handle invalid input - hide result for invalid/empty input
            showingResult = false
            return
        }
        
        grams = kg * 1000
        showingResult = true
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}
