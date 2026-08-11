fn banner_grab() {
    let host = require_env("YS_SEC_A", "host")
    let port_s = require_env("YS_SEC_B", "port")

    if y.is_nil(host) || y.is_nil(port_s) || !valid_host(host) { return }

    let port = y.int(port_s)
    if port < 1 || port > 65535 {
        y.println("Invalid port")
        return
    }

    let sock = y.net.connect(host, port)
    if sock == -1 {
        y.println("Connection failed: " + y.net.last_error())
        return
    }

    y.net.set_timeout(sock, 3000)
    let data = y.net.recv(sock, 4096)
    y.net.close(sock)

    if y.is_nil(data) || data == "" {
        y.println("No banner received")
        return
    }

    y.println(data)
}
