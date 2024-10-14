import SwiftUI

struct LockButton: View {
    var text: String
    var shape: AnyShape = .init(Circle())
    var duration: CGFloat = 1
    @State private var progress: CGFloat = 0.0
    @State private var isHolding: Bool = false
    @State private var isFinished: Bool = false

    var body: some View {
        Text(text)
            .padding(25)
            .background(
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color("GradientTwo"), Color("GradientOne")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                        .shadow(
                            .inner(color: Color.white.opacity(0.2), radius: 2, x:1, y:1)
                        )
                        .shadow(
                            .inner(color: Color.gray.opacity(0.5), radius: 2, x:-1, y:-1)
                        )
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x:10, y:10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    .shadow(color: Color.gray.opacity(0.1), radius: 10, x:-10, y:10)
                    .shadow(color: Color.gray.opacity(0.1), radius: 10, x:10, y:-10)
                    .overlay(
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(Color("AccentColor"), lineWidth: 3)
                            .rotationEffect(.init(degrees: -90))
                    )
            )
            .clipShape(shape)
            .contentShape(shape)
            .onLongPressGesture(minimumDuration: 1.0) { (isPressing) in
                if isPressing {
                    print("JIJO")
                    isHolding = true
                    withAnimation(.linear(duration: duration)) {
                        progress = 1
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeInOut) {
                            progress = 0
                        }
                    }
                }
            } perform: {
                print("cuh cuh cuh")
            }
    }

    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: duration)
            .onEnded { value in
                print("HELO")
                isHolding = value
                withAnimation(.linear(duration: duration)) {
                    progress = value ? 1 : 0
                }
            }
    }
}

#Preview {
    TempView()
}
