import SwiftUI

struct EventBookingHomeScreen: View {
    @StateObject private var viewModel = EventBookingViewModel()
    
    @State private var isEditing: Bool = false
    
    @State private var currentPage: Int = 0
    @State private var autoScrollTimer: Timer?
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ZStack {
            AppBackgrounds.gradientBackground
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                eventButton
                promoBanner
                serviceGridSection
                Spacer()
            }
            .padding()
        }
        .onAppear {
            viewModel.loadData()
            isEditing = viewModel.selectedEvent == nil
        }
        .onDisappear {
            stopAutoScroll()
        }
        .sheet(isPresented: $isEditing) {
            EventChoiceScreen(viewModel: viewModel, isEditing: $isEditing)
        }
        .navigationTitle("My Events")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}
extension EventBookingHomeScreen {
    private var eventButton: some View {
        Button(action: { isEditing = true }) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Your Event")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.85))
                    
                    Text(viewModel.selectedEvent?.name ?? "Select your event")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                Spacer()
                Image(systemName: "pencil")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.white.opacity(0.25).blur(radius: 2))
                    .clipShape(Circle())
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(
                ZStack {
                    LinearGradient(
                        colors: [Color.red.opacity(0.85), Color.red, Color.pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        .blur(radius: 2)
                }
            )
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.35), radius: 15, x: 0, y: 8)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.05), lineWidth: 1))
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var promoBanner: some View {
        VStack(spacing: 10) {
            GeometryReader { proxy in
                let horizontalPadding: CGFloat = 16
                let cardWidth = proxy.size.width - (horizontalPadding * 2)
                let cardHeight: CGFloat = 180
                
                TabView(selection: $currentPage) {
                    ForEach(viewModel.promos.indices, id: \.self) { index in
                        Group {
                            if let promoImage = viewModel.promos[index].imageName {
                                Image(promoImage)
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                Color.gray.opacity(0.2)
                            }
                        }
                        .frame(width: cardWidth, height: cardHeight)
                        .clipped()
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .padding(.horizontal, horizontalPadding)
                        .tag(index)
                    }
                }
                .frame(height: cardHeight)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .animation(.easeInOut(duration: 0.35), value: currentPage)
                .onAppear { restartAutoScrollIfNeeded() }
                .onChange(of: viewModel.promos) { _ in
                    if currentPage >= viewModel.promos.count {
                        currentPage = max(0, viewModel.promos.count - 1)
                    }
                    restartAutoScrollIfNeeded()
                }
                .onDisappear { stopAutoScroll() }
            }
            .frame(height: 180)
            
            HStack(spacing: 6) {
                ForEach(0..<max(viewModel.promos.count, 0), id: \.self) { index in
                    Capsule()
                        .fill(index == currentPage ? Color.red : Color.red.opacity(0.4))
                        .frame(width: index == currentPage ? 18 : 6, height: 6)
                        .animation(.easeInOut(duration: 0.25), value: currentPage)
                        .onTapGesture {
                            guard index < viewModel.promos.count else { return }
                            withAnimation(.easeInOut(duration: 0.35)) {
                                currentPage = index
                            }
                        }
                }
            }
            .opacity(viewModel.promos.count > 1 ? 1 : 0)
        }
    }
    
    private var serviceGridSection: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(viewModel.serviceTiles) { tile in
                Button {
                    withAnimation(.spring()) {
                        viewModel.selectedTile = viewModel.selectedTile?.id == tile.id ? nil : tile
                    }
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: tile.iconName)
                            .font(.system(size: 35))
                            .foregroundStyle(Color(.primary))
                        Text(tile.tileName ?? "")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(viewModel.selectedTile?.id == tile.id ? Color(.primary) : .clear, lineWidth: 2)
                    )
                    .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 20)
    }
    
    private func restartAutoScrollIfNeeded() {
        stopAutoScroll()
        guard viewModel.promos.count > 1 else { return }
        startAutoScroll()
    }
    
    private func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            guard !viewModel.promos.isEmpty else { return }
            let next = (currentPage + 1) % viewModel.promos.count
            withAnimation(.easeInOut(duration: 0.35)) {
                currentPage = next
            }
        }
        RunLoop.main.add(autoScrollTimer!, forMode: .common)
    }
    
    private func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
}
