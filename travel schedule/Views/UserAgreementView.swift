import SwiftUI
import WebKit

struct UserAgreementView: View {
    var body: some View {
        WebView(url: URL(string: "https://yandex.ru/legal/practicum_offer/")!)
            .ignoresSafeArea()
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
   
}

#Preview {
    UserAgreementView()
}
