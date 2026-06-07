import SwiftUI

struct MatchCardView: View {
    let match: MockMatch
    let isSubscribed: Bool
    let onNotificationToggle: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            // 좌측 상태 인디케이터 컬러 바
            if match.status == "LIVE" {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 4)
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 4)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                // 상단 매치 뱃지 및 추가 기능 버튼
                HStack {
                    if match.status == "LIVE" {
                        HStack(spacing: 4) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 6, height: 6)
                            Text("● LIVE \(match.time)")
                                .font(.system(size: 11, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.red)
                        .cornerRadius(12)
                    } else if match.status == "NS" {
                        Text(match.time)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(Color.brandNavy)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.brandNavy.opacity(0.3), lineWidth: 1)
                            )
                    } else {
                        Text("종료")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                    }
                    
                    Spacer()
                    
                    if match.status == "NS" {
                        Button(action: onNotificationToggle) {
                            Image(systemName: isSubscribed ? "bell.fill" : "bell")
                                .font(.system(size: 16))
                                .foregroundColor(isSubscribed ? Color.brandNavy : .gray)
                        }
                    }
                }
                
                // 팀 이름 및 점수 스코어 레이아웃
                HStack {
                    Text(match.homeTeam)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if match.status == "LIVE" || match.status == "FT" {
                        HStack(spacing: 12) {
                            Text("\(match.homeScore ?? 0)")
                                .font(.system(size: 24, weight: .black))
                                .foregroundColor(.primary)
                            
                            Text(":")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.gray.opacity(0.6))
                            
                            Text("\(match.awayScore ?? 0)")
                                .font(.system(size: 24, weight: .black))
                                .foregroundColor(.primary)
                        }
                        .frame(width: 80)
                    } else {
                        Text("vs")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray.opacity(0.6))
                            .frame(width: 80)
                    }
                    
                    Text(match.awayTeam)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.vertical, 4)
                
                // 경기장 이름
                HStack {
                    Spacer()
                    Text(match.stadium)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 16)
    }
}
