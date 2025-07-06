//
//  FiltersView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 02.07.2025.
//

import SwiftUI

struct FiltersView: View {
    @ObservedObject var coordinator: NavCoordinator
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Время отправления")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.blackApp)
            ForEach(PeriodicEnum.allCases, id: \.self) { period in
                HStack {
                    Text(period.rawValue)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.blackApp)
                    Spacer()
                    Button(action: {
                        if coordinator.timeFilters.contains(period) {
                            coordinator.timeFilters.remove(period)
                        } else {
                            coordinator.timeFilters.insert(period)
                        }
                    }) {
                        Image(systemName: coordinator.timeFilters.contains(period) ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.blackApp)
                    }
                }
                .frame(height: 60)
                .padding(.trailing, 2)
            }
            
            Text("Показывать варианты с пересадками")
                .font(.system(size: 20, weight: .bold))
                .padding(.top, 16)
            HStack {
                Text("Да")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.blackApp)
                Spacer()
                Button(action: { coordinator.showTransfers = true }) {
                    Image(coordinator.showTransfers == true ?  "radio_button_on" : "radio_button_off")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(.blackApp)
                        .frame(width: 24, height: 24)
                }
                .frame(height: 60)
                .padding(.trailing, 2)
            }
            HStack {
                Text("Нет")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.blackApp)
                Spacer()
                Button(action: { coordinator.showTransfers = false }) {
                    Image(coordinator.showTransfers == false ? "radio_button_on" : "radio_button_off")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(.blackApp)
                        .frame(width: 24, height: 24)
                }
                .frame(height: 60)
                .padding(.trailing, 2)
            }
            Spacer()
            if coordinator.isFiltersValid {
                Button(action: {coordinator.path.removeLast()}) {
                    Text("Применить")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.whiteUni)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
                .background(.blueUni)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.bottom, 24)
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(.chevronLeft)
                        .renderingMode(.template)
                        .foregroundStyle(.blackApp)
                }
            }
        }
    }
}

#Preview {
    FiltersView(coordinator: NavCoordinator())
}
