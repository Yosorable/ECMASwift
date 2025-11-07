import JavaScriptCore

/// `JSRuntime` wraps a `JSContext` and implements a few missing browser APIs
/// (mostly networking related, fetch, request etc.), which are then registered with the context.
/// So, a `JSRuntime` can be used as headless browser to execute ``LTCore``.
///
/// The following browser APIs are implemented in Swift and added to the JSContext:
///
/// - ``Blob``
/// - ``AbortController``
/// - ``Request``
/// - ``Fetch``
/// - ``Headers``
/// - ``URLSearchParams``
/// - ``URL``
/// - ``Console``
/// - ``Timer``
/// - ``TextEncoder``
/// - ``Crypto``
public struct JSRuntime {
    public let context: JSContext = .init()
    private let blobAPI = BlobAPI()
    private let abortControllerAPI = AbortControllerAPI()
    private let requestAPI = RequestAPI()
    private let headersAPI = HeadersAPI()
    private let urlSearchParamsAPI = URLSearchParamsAPI()
    private let urlAPI = URLAPI()
    private let consoleAPI = ConsoleAPI()
    private let timerAPI = TimerAPI()
    private let textEncoderAPI = TextEncoderAPI()
    private let cryptoAPI = CryptoAPI()


    private let fetchAPI: FetchAPI


    public init(client: HTTPClient = URLSession.shared) {
        fetchAPI = FetchAPI(client: client)
        registerAPIs(client: client)
    }

    private func registerAPIs(client: HTTPClient) {
        // Runtime APIs
        blobAPI.registerAPIInto(context: context)
        abortControllerAPI.registerAPIInto(context: context)
        requestAPI.registerAPIInto(context: context)
        fetchAPI.registerAPIInto(context: context)
        headersAPI.registerAPIInto(context: context)
        urlSearchParamsAPI.registerAPIInto(context: context)
        urlAPI.registerAPIInto(context: context)
        consoleAPI.registerAPIInto(context: context)
        timerAPI.registerAPIInto(context: context)
        textEncoderAPI.registerAPIInto(context: context)
        cryptoAPI.registerAPIInto(context: context)
    }
}
