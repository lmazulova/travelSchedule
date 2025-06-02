import SwiftUI
import WebKit

struct UserAgreementView: View {
    @Binding var path: NavigationPath
    @State private var isLoading: Bool = false
    @State private var progress: Double = 0.0
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        ZStack {
            Color.customWhite
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                if isLoading {
                    ProgressView(value: progress, total: 1.0)
                        .progressViewStyle(.linear)
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(.black)
                        .scaleEffect(x: 1, y: 0.75, anchor: .trailing)
                }
                
                WebView(
                    urlToDisplay: "https://yandex.ru/legal/practicum_offer/",
                    isLoading: $isLoading,
                    progress: $progress
                )
            }
            .navigationTitle("Пользовательское соглашение")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        path.removeLast()
                    } label: {
                        Image("backArrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 17, height: 22)
                    }
                }
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    var urlToDisplay: URL?
    @Binding public var isLoading: Bool
    @Binding public var progress: Double
    
    public init(urlToDisplay: String, isLoading: Binding<Bool>, progress: Binding<Double>) {
        self.urlToDisplay = URL(string: urlToDisplay)
        self._isLoading = isLoading
        self._progress = progress
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        if let urlWeb = urlToDisplay {
            let request = URLRequest(url:urlWeb)
            webView.load(request)
        }
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        return webView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, isLoading: $isLoading)
    }
    
   
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        @Binding var isLoading: Bool
        
        init(_ parent: WebView, isLoading: Binding<Bool>) {
            self._isLoading = isLoading
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isLoading = false
            }
            parent.progress = 1.0
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.progress = Double(webView.estimatedProgress)
        }
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
}


#Preview {
//    UserAgreementView()
}
