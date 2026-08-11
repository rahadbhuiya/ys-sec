fn ip_to_int(ip) {
    let p = y.split(ip, ".")

    if y.len(p) != 4 { return -1 }

    let a = y.int(p[0])
    let b = y.int(p[1])
    let c = y.int(p[2])
    let d = y.int(p[3])

    if a < 0 || a > 255 { return -1 }
    if b < 0 || b > 255 { return -1 }
    if c < 0 || c > 255 { return -1 }
    if d < 0 || d > 255 { return -1 }

    return a * 16777216 + b * 65536 + c * 256 + d
}

fn int_to_ip(n) {
    let a = n / 16777216
    let r1 = n % 16777216
    let b = r1 / 65536
    let r2 = r1 % 65536
    let c = r2 / 256
    let d = r2 % 256

    return y.str(a) + "." + y.str(b) + "." + y.str(c) + "." + y.str(d)
}

fn subnet_info() {
    let cidr = require_env("YS_SEC_A", "CIDR")
    if y.is_nil(cidr) { return }

    let p = y.split(cidr, "/")
    if y.len(p) != 2 {
        y.println("Invalid IPv4 CIDR")
        return
    }

    let ip = ip_to_int(p[0])
    let bits = y.int(p[1])

    if ip < 0 || bits < 0 || bits > 32 {
        y.println("Invalid IPv4 CIDR")
        return
    }

    let block = y.int(y.math.pow(2, 32 - bits))
    let network = (ip / block) * block

    y.println("Network: " + int_to_ip(network))
    y.println("Prefix:  /" + y.str(bits))
    y.println("Addresses: " + y.str(block))

    if bits <= 30 {
        let broadcast = network + block - 1
        y.println("Broadcast: " + int_to_ip(broadcast))
        y.println("First host: " + int_to_ip(network + 1))
        y.println("Last host:  " + int_to_ip(broadcast - 1))
    }

    if has_flag("YS_SEC_JSON") {
        let report = y.map.new()
        report = y.map.set(report, "cidr", cidr)
        report = y.map.set(report, "network", int_to_ip(network))
        report = y.map.set(report, "prefix", bits)
        report = y.map.set(report, "addresses", block)

        let encoded = y.json.stringify(report)
        y.println(encoded)
        save_if_requested(encoded)
    }
}

fn subnet_hosts() {
    let cidr = require_env("YS_SEC_A", "CIDR")
    if y.is_nil(cidr) { return }

    let p = y.split(cidr, "/")
    if y.len(p) != 2 {
        y.println("Invalid IPv4 CIDR")
        return
    }

    let ip = ip_to_int(p[0])
    let bits = y.int(p[1])

    if ip < 0 || bits < 0 || bits > 30 {
        y.println("Host enumeration requires a valid IPv4 /30 or larger network")
        return
    }

    let block = y.int(y.math.pow(2, 32 - bits))
    let network = (ip / block) * block

    var i = network + 1
    let last = network + block - 2

    while i <= last {
        y.println(int_to_ip(i))
        i = i + 1
    }

    y.println("Broadcast: " + int_to_ip(last + 1))
}
