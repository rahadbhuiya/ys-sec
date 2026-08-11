fn whois_lookup() {
    let domain = require_env("YS_SEC_A", "domain")
    if y.is_nil(domain) || !valid_domain(domain) { return }

    let sock = y.net.connect("whois.iana.org", 43)

    if sock == -1 {
        y.println("WHOIS connection failed: " + y.net.last_error())
        return
    }

    y.net.set_timeout(sock, 5000)
    y.net.send(sock, domain + "\r\n")

    var response = ""
    var chunk = y.net.recv(sock, 8192)

    while chunk != "" {
        response = response + chunk
        chunk = y.net.recv(sock, 8192)
    }

    y.net.close(sock)
    y.println(response)
}
