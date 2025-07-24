//
//  View+Extension.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 24.07.2025.
//

import SwiftUI

extension View {
    func navigationToolbar(title: String?, presentationMode: Binding<PresentationMode>) -> some View {
        self.navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if let title = title {
                    ToolbarItem(placement: .principal) {
                        Text(title)
                            .fontWeight(.bold)
                            .foregroundStyle(.blackApp)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(.chevronLeft)
                            .renderingMode(.template)
                            .foregroundStyle(.blackApp)
                    }
                }
            }
    }
}
