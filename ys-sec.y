-- ys-sec main dispatcher
import "./modules/common.y"
import "./modules/portscan.y"
import "./modules/dns.y"
import "./modules/ping.y"
import "./modules/banner.y"
import "./modules/http.y"
import "./modules/headers.y"
import "./modules/whois.y"
import "./modules/subnet.y"

fn main() {
    let cmd = y.env.get("YS_SEC_CMD")

    if y.is_nil(cmd) || cmd == "" {
        help()
        return
    }

    if cmd == "help" { help() return }
    if cmd == "portscan" { portscan() return }
    if cmd == "dns" { dns_lookup() return }
    if cmd == "ping" { ping_host() return }
    if cmd == "banner" { banner_grab() return }
    if cmd == "http" { http_inspect() return }
    if cmd == "headers" { headers_inspect() return }
    if cmd == "whois" { whois_lookup() return }
    if cmd == "subnet" { subnet_info() return }
    if cmd == "subnet-hosts" { subnet_hosts() return }

    y.println("Unknown command: " + cmd)
    help()
}

fn help() {
    y.println("ys-sec - Yolish network/security toolkit")
    y.println("")
    y.println("Usage:")
    y.println("  ys-sec portscan <host> <start> <end> [--service] [--json] [-o file]")
    y.println("  ys-sec dns <host>")
    y.println("  ys-sec ping <host>")
    y.println("  ys-sec banner <host> <port>")
    y.println("  ys-sec http <url>")
    y.println("  ys-sec headers <url>")
    y.println("  ys-sec whois <domain>")
    y.println("  ys-sec subnet <ipv4/cidr>")
    y.println("  ys-sec subnet-hosts <ipv4/cidr>")
    y.println("")
    y.println("Only scan systems you own or are authorized to test.")
}
