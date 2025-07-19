//
//  CloseButton.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 15.07.2025.
//

import SwiftUI

struct CloseButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button("", image: .closeButton) {
            action()
        }
    }
}

#Preview {
    CloseButton(action: {} )
}
