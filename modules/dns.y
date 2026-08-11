fn dns_lookup() {
    let host = require_env("YS_SEC_A", "hostname")
    if y.is_nil(host) || !valid_host(host) { return }

    let output = process.spawn("nslookup " + host)
    y.println(output)
}
