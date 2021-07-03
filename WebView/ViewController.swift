//
//  ViewController.swift
//  WebView
//
//  Created by David Yoon on 2021/07/03.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var textURL: UITextField!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activityIndicatorVIew: UIActivityIndicatorView!
    
    // url의 인수를 통해 웹 페이지의 주소를 전달받아 웹 페이지를 보여 줌
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        webView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webView.navigationDelegate = self
        loadWebPage("http://github.com/davidyoon891122") // 앱 처음 시작시 보여주는 default 페이지
    }
    
    //WebView functions
    // didCommit -> 로딩 중인지 확인하기 위한 콜백 함수
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicatorVIew.startAnimating()
        activityIndicatorVIew.isHidden = false
        
    }
    // didFinish -> 작업이 완료되었을때 콜백 함수
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorVIew.stopAnimating()
        activityIndicatorVIew.isHidden = true
    }
    
    //didFail -> 작업이 실패했을떄 콜백 함수
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicatorVIew.stopAnimating()
        activityIndicatorVIew.isHidden = true
    }
    
    // "http://" 붙여서 도메인 주소 자동 완성해주는 func
    func checkURL(_ url:String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("https://")
        if !flag {
            strUrl = "https://" + strUrl
        }
        return strUrl
    }
    
    
    
    // textview에 string 가져와서 https:// 포멧 확인후 해당 url로 웹사이트 띄우기
    @IBAction func goAction(_ sender: UIButton) {
        let myUrl = checkURL(textURL.text!)
        textURL.text = ""
        loadWebPage(myUrl)
        
    }
    // 고정 사이트_1 띄우기
    @IBAction func site1Action(_ sender: UIButton) {
        loadWebPage("https://davidyoon891122.github.io")
    }
    // 고정 사이트_2 띄우기
    @IBAction func site2Action(_ sender: UIButton) {
        loadWebPage("http://fallinmac.tistory.com")
    }
    // String 형태로 html 코드 작성해서 해당 코드 보여주기
    @IBAction func htmlAction(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹 페이지 </p><p><a href=\"http://2sam.net\">2sam</a>으로 이동</p>"
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    // file형태로 앱 내에 html파일 만들어서 화면 띄우기 (이렇게 포멧 만들어 놓고 데이터만 가져오면 빠를 듯 ?)
    @IBAction func fileAction(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        webView.load(myRequest)
    }
    
    // webview 정지
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        webView.stopLoading()
    }
    
    // webview reload
    @IBAction func btnRefresh(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    // webview rewind
    @IBAction func btnRewind(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    // webview fastforward
    @IBAction func btnForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    
}

