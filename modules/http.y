fn http_inspect() {
    let url = require_env("YS_SEC_A", "URL")
    if y.is_nil(url) || url == "" { return }

    let raw = process.spawn("powershell.exe -NoProfile -NonInteractive -File bin/http-helper.ps1")

    if y.is_nil(raw) || y.trim(raw) == "" {
        y.println("HTTP request failed")
        return
    }

    let lines = y.split(raw, "\n")
    var status = ""
    var body_len = "0"
    var error = ""

    for line in lines {
        let t = y.trim(line)
        if y.starts_with(t, "STATUS=") {
            status = y.substr(t, 7, y.len(t))
        } else if y.starts_with(t, "BODY_LEN=") {
            body_len = y.substr(t, 9, y.len(t))
        } else if y.starts_with(t, "ERROR=") {
            error = y.substr(t, 6, y.len(t))
        }
    }

    if error != "" {
        y.println("HTTP request failed: " + error)
        return
    }

    y.println("Status: " + status)
    y.println("Body length: " + body_len)
}
