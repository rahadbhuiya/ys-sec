fn http_inspect() {
    let url = require_env("YS_SEC_A", "URL")
    if y.is_nil(url) { return }

    let r = y.http.get(url)

    if y.is_nil(r) {
        y.println("HTTP request failed: " + y.net.last_error())
        return
    }

    let status = y.map.get(r, "status")
    let body = y.map.get(r, "body")
    let headers = y.map.get(r, "headers")

    y.println("Status: " + y.str(status))
    y.println("Body length: " + y.str(y.len(body)))
    y.println("")
    y.println(body)

    if has_flag("YS_SEC_JSON") {
        let report = {
            url: url,
            status: status,
            headers: headers,
            body: body
        }

        let encoded = y.json.stringify(report)
        y.println(encoded)
        save_if_requested(encoded)
    }
}
