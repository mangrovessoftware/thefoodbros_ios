import SwiftUI

enum Service: String, CaseIterable, Identifiable {
    case catering = "Catering"
    case music = "Service Boys"
    case decoration = "Decoration"
    case photography = "Photography"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .catering: return "fork.knife"
        case .music: return "person.2.fill"
        case .decoration: return "sparkles"
        case .photography: return "camera"
        }
    }
    
    var screen: some View {
        VStack(spacing: 20) {
            if #available(iOS 16.0, *) {
                Image(systemName: iconName)
                    .font(.system(size: 60))
                    .foregroundStyle(.blue.gradient)
            }
            Text("\(rawValue) Details Coming Soon!")
                .font(.title2.bold())
                .foregroundColor(.primary)
        }
        .padding()
        .navigationTitle(rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EventBookingHomeScreen: View {
    @State private var currentIndex = 0
    private let promoColors: [Color] = [.red, .blue, .green, .orange, .purple, .pink, .yellow, .teal]
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    content
                        .navigationTitle("Event Booking")
                        .navigationBarTitleDisplayMode(.inline)
                }
            } else {
                NavigationView {
                    content
                        .navigationTitle("Event Booking")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
    
    private var content: some View {
        ZStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    BannerView
                    servicesSection
                }
                .padding(.vertical, 30)
            }
        }
    }
}

extension EventBookingHomeScreen {
    
    var gradientTitle: some View {
        Text("Event Booking")
            .font(.title2.bold())
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0, green: 120/255, blue: 200/255),
                        Color(red: 0, green: 78/255, blue: 139/255)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .padding(.top)
    }
    
    var BannerView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(Array(promoColors.enumerated()), id: \.offset) { item in
                    BannerCard(index: item.offset)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 180)
    }
    
    var servicesSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 16)], spacing: 16) {
                ForEach(Service.allCases) { service in
                    if #available(iOS 16.0, *) {
                        NavigationLink(value: service) {
                            ServiceCard(service: service)
                        }
                    } else {
                        NavigationLink(destination: service.screen) {
                            ServiceCard(service: service)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .ifAvailableNavigationDestination()
    }
}



struct BannerCard: View {
    let index: Int
    
    var body: some View {
        ZStack {
            Image("Ad")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.85, height: 150)
                .cornerRadius(12)
        }
        .onTapGesture {
            print("Banner \(index) tapped")
        }
    }
}

struct ServiceCard: View {
    let service: Service
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: service.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundStyle(.white)
                .padding(.top, 10)
            
            Text(service.rawValue)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
        .background(
            ZStack {
                Color.appThemeGradient
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            }
                .background(.ultraThickMaterial)
        )
        .cornerRadius(15)
        .shadow(color: .black.opacity(isPressed ? 0.1 : 0.3),
                radius: isPressed ? 2 : 8,
                x: 0, y: isPressed ? 1 : 5)
        .scaleEffect(isPressed ? 0.96 : 1)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onLongPressGesture(minimumDuration: 0.01, pressing: { pressing in
            isPressed = pressing
        }, perform: {
            
        })
    }
}

// MARK: - iOS 16 Compatibility Extension
extension View {
    @ViewBuilder
    func ifAvailableNavigationDestination() -> some View {
        if #available(iOS 16.0, *) {
            self.navigationDestination(for: Service.self) { $0.screen }
        } else {
            self
        }
    }
}


#Preview {
    EventBookingHomeScreen()
}
