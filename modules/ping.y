fn ping_host() {
    let host = require_env("YS_SEC_A", "host")
    if y.is_nil(host) || !valid_host(host) { return }

    let output = process.spawn("ping -n 1 -w 2000 " + host)
    y.println(output)
}
