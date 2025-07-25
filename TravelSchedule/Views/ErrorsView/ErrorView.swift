//
//  ErrorView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 26.07.2025.
//

import SwiftUI

enum ErrorType {
    case serverError
    case connectionError

    var imageName: String {
        switch self {
        case .serverError:
            return "server_error"
        case .connectionError:
            return "internet_error"
        }
    }

    var errorMessage: String {
        switch self {
        case .serverError:
            return "Ошибка сервера"
        case .connectionError:
            return "Нет интернета"
        }
    }
}

struct ErrorView: View {
    var errorType: ErrorType
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(errorType.imageName)
                .resizable()
                .frame(width: 223, height: 223)
                .clipShape(RoundedRectangle(cornerRadius: 70))
            
            Text(errorType.errorMessage)
                .font(.bold24)
                .foregroundStyle(.blackApp)
            
            Spacer()
        }
        .padding()
        .background(.whiteApp)
    }
}

#Preview {
    Group {
        ErrorView(errorType: .serverError)
        ErrorView(errorType: .connectionError)
    }
}
