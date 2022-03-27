import SwiftUI
import SwiftUI

struct SubmitButton_Test: View {
    
    @State var complete: Bool = false
    @State var inProgress: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
        
        Color(UIColor.systemGray6)
        AsyncButton(isComplete: complete, action: {
            inProgress = true
            // Start Async Task (Download, Submit, etc)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    complete = true
                }
            }
        })
            {
            Text(complete || inProgress ? "" : "Download")
           
        
        }.navigationTitle("Async Button")
                    .position(x: 207, y: 250)
//        RoundedRectangle(cornerRadius: 25)
//                    .frame(width: 350, height: 150)
//                    .foregroundColor(Color.white)
//                    .position(x: 207, y: 500)
//
//        Text("")
//                    .position(x: 207, y: 450)
        }
        }
    }
}




struct AsyncButton<Content: View>: View {
    
    var isComplete: Bool
    let action: ()->()
    let content: Content
    
    @State private var inProgress: Bool
    
    init(isComplete: Bool, action: @escaping ()->(), @ViewBuilder label: ()->Content) {
        self.action = action
        self.isComplete = isComplete
        self.content = label()
        self._inProgress = State.init(initialValue: false)
    }
    
    var body: some View {
        Button(action: {
            if !inProgress { action() }
            withAnimation(Animation.easeInOut(duration: 0.4)) {
                inProgress = true
                    
            }

        }, label: {
            VStack(alignment: .trailing) {
                if inProgress && !isComplete {
                    ProgressView()
                        .foregroundColor(.white)
                } else if isComplete {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 15, height: 15, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color.blue)
                } else {
                    content
                }
            }
            .frame(maxWidth: isComplete || inProgress ? 50 : 300, maxHeight: isComplete  || inProgress ? 50 : nil, alignment: .center)
            .padding(.vertical, isComplete  || inProgress ? 0 : 12)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(isComplete || inProgress ? 25 : 8)
            .font(Font.body.weight(.semibold))
            .padding(.all, 20)
        }).disabled(isComplete)


    }
    
    
}
struct SubmitButton_TestPreview: PreviewProvider {
    static var previews: some View {
        SubmitButton_Test()
    }
}
