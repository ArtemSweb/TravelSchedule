//
//  CustomSearchBar.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 01.07.2025.
//


import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    var placeholder: String = "Введите запрос"
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.grayUni)
            
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.grayUni)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(10)
        .background(.appGrey)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 16)
    }
}

