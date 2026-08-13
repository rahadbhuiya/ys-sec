fn service_name(port) {
    if port == 21 { return "ftp" }
    if port == 22 { return "ssh" }
    if port == 23 { return "telnet" }
    if port == 25 { return "smtp" }
    if port == 53 { return "dns" }
    if port == 80 { return "http" }
    if port == 110 { return "pop3" }
    if port == 135 { return "msrpc" }
    if port == 139 { return "netbios-ssn" }
    if port == 143 { return "imap" }
    if port == 443 { return "https" }
    if port == 445 { return "microsoft-ds" }
    if port == 3306 { return "mysql" }
    if port == 3389 { return "rdp" }
    if port == 5432 { return "postgresql" }
    if port == 6379 { return "redis" }
    if port == 8080 { return "http-alt" }
    if port == 8443 { return "https-alt" }
    return "unknown"
}

fn banner_grab() {
    let host = require_env("YS_SEC_A", "host")
    let port_s = require_env("YS_SEC_B", "port")
    if y.is_nil(host) || y.is_nil(port_s) || !valid_host(host) { return }

    let port = y.int(port_s)
    if port < 1 || port > 65535 {
        y.println("Invalid port")
        return
    }

    let raw = process.spawn("powershell.exe -NoProfile -NonInteractive -File bin/banner-helper.ps1")
    y.println("Host: " + host)
    y.println("Port: " + y.str(port))
    y.println("Service: " + service_name(port))

    if y.is_nil(raw) || y.trim(raw) == "" {
        y.println("Banner: unavailable")
        return
    }

    let lines = y.split(raw, "\n")
    var banner = ""
    for line in lines {
        let t = y.trim(line)
        if y.starts_with(t, "BANNER=") {
            banner = y.substr(t, 7, y.len(t))
        }
    }

    if banner == "" {
        y.println("Banner: unavailable")
    } else {
        y.println("Banner:")
        y.println(banner)
    }
}
