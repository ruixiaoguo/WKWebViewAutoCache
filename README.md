# WKWebViewAutoCache
### 基于JWNetAutoCache实现web缓存+离线缓存
### 使用方法

    1.在viewDidLoad里通过注册把http和https请求交给NSURLProtocol处理
        [NSURLProtocol wk_registerScheme:@"http"];
        [NSURLProtocol wk_registerScheme:@"https"];
    
    2.在需要开启的时候调用
        [JWCacheURLProtocol startListeningNetWorking];
      
    3.使用结束后调用：
        [JWCacheURLProtocol cancelListeningNetWorking];
