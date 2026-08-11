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
    if port == 587 { return "smtp-submission" }
    if port == 902 { return "vmware" }
    if port == 912 { return "vmware" }
    if port == 993 { return "imaps" }
    if port == 995 { return "pop3s" }
    if port == 2179 { return "vmrdp" }
    if port == 3306 { return "mysql" }
    if port == 3389 { return "rdp" }
    if port == 5040 { return "unknown" }
    if port == 5432 { return "postgresql" }
    if port == 6379 { return "redis" }
    if port == 7680 { return "delivery-optimization" }
    if port == 8080 { return "http-alt" }
    if port == 8443 { return "https-alt" }
    return "unknown"
}

fn windows_tcp_test(host, port) {
    let command = "powershell.exe -NoProfile -NonInteractive -Command \"Test-NetConnection -ComputerName " + host + " -Port " + y.str(port) + " -InformationLevel Quiet\""
    let result = process.spawn(command)

    if y.starts_with(result, "True") {
        return true
    }

    return false
}

fn portscan() {
    let host = require_env("YS_SEC_A", "target host")
    if y.is_nil(host) || !valid_host(host) { return }

    let start_s = require_env("YS_SEC_B", "start port")
    let end_s = require_env("YS_SEC_C", "end port")
    if y.is_nil(start_s) || y.is_nil(end_s) { return }

    let start = y.int(start_s)
    let end = y.int(end_s)

    if start < 1 || end > 65535 || start > end {
        y.println("Invalid port range")
        return
    }

    let service = has_flag("YS_SEC_SERVICE")
    let results = y.map.new()
    var p = start
    var open_count = 0

    while p <= end {
        if windows_tcp_test(host, p) {
            let name = service_name(p)

            if service {
                y.println("OPEN  " + y.str(p) + "  " + name)
            } else {
                y.println("OPEN  " + y.str(p))
            }

            results = y.map.set(results, y.str(p), name)
            open_count = open_count + 1
        }

        p = p + 1
    }

    if has_flag("YS_SEC_JSON") {
        let report = y.map.new()
        report = y.map.set(report, "target", host)
        report = y.map.set(report, "start", start)
        report = y.map.set(report, "end", end)
        report = y.map.set(report, "open_count", open_count)
        report = y.map.set(report, "ports", results)

        let encoded = y.json.stringify(report)
        y.println(encoded)
        save_if_requested(encoded)
    }
}
