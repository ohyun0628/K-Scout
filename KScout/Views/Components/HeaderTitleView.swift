import SwiftUI

struct HeaderTitleView: View {
    let title: String
    var showBackButton: Bool = false
    var onBackTap: (() -> Void)? = nil
    
    // 시즌 선택 바인딩 추가 (옵셔널)
    var selectedSeason: Binding<Int>? = nil
    var selectedMonth: Binding<Int>? = nil
    
    let seasons = [2026, 2025, 2024, 2023, 2022]
    
    @State private var showDatePicker = false
    
    var body: some View {
        HStack(spacing: 12) {
            backButtonView
            titleView
            Spacer()
            seasonSelectorView
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
    @ViewBuilder
    private var backButtonView: some View {
        if showBackButton {
            Button(action: {
                onBackTap?()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.brandNavy)
            }
        }
    }
    
    private var titleView: some View {
        Text(title)
            .font(.system(size: 28, weight: .black))
            .foregroundColor(Color.brandNavy)
    }
    
    @ViewBuilder
    private var seasonSelectorView: some View {
        if let selectedSeason = selectedSeason {
            if let selectedMonth = selectedMonth {
                monthYearButton(selectedSeason: selectedSeason, selectedMonth: selectedMonth)
            } else {
                seasonOnlyMenu(selectedSeason: selectedSeason)
            }
        }
    }
    
    private func monthYearButton(selectedSeason: Binding<Int>, selectedMonth: Binding<Int>) -> some View {
        Button(action: {
            showDatePicker = true
        }) {
            HStack(spacing: 4) {
                Text("\(String(selectedSeason.wrappedValue))년 \(selectedMonth.wrappedValue)월")
                    .font(.system(size: 14, weight: .bold))
                Image(systemName: "chevron.down")
                    .font(.system(size: 10, weight: .bold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.brandNavy)
            .cornerRadius(20)
        }
        .sheet(isPresented: $showDatePicker) {
            YearMonthPickerSheet(selectedYear: selectedSeason, selectedMonth: selectedMonth)
        }
    }
    
    private func seasonOnlyMenu(selectedSeason: Binding<Int>) -> some View {
        Menu {
            ForEach(seasons, id: \.self) { season in
                Button(action: {
                    selectedSeason.wrappedValue = season
                }) {
                    HStack {
                        Text("\(String(season)) 시즌")
                        if selectedSeason.wrappedValue == season {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack(spacing: 4) {
                Text("\(String(selectedSeason.wrappedValue))년")
                    .font(.system(size: 14, weight: .bold))
                Image(systemName: "chevron.down")
                    .font(.system(size: 10, weight: .bold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.brandNavy)
            .cornerRadius(20)
        }
    }
}

struct YearMonthPickerSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    
    let years: [Int] = Array((2010...2026).reversed())
    let months: [Int] = Array(1...12)
    
    var body: some View {
        VStack {
            Text("연도 및 월 선택")
                .font(.headline)
                .padding(.top, 24)
            
            HStack(spacing: 0) {
                Picker("연도", selection: $selectedYear) {
                    ForEach(years, id: \.self) { year in
                        Text("\(String(year))년").tag(year)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity)
                
                Picker("월", selection: $selectedMonth) {
                    ForEach(months, id: \.self) { month in
                        Text("\(month)월").tag(month)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("확인")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brandNavy)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
    }
}
