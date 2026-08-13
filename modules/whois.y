fn whois_lookup() {
    let domain = require_env("YS_SEC_A", "domain")
    if y.is_nil(domain) || !valid_domain(domain) {
        y.println("Invalid domain")
        return
    }

    let command = "powershell.exe -NoProfile -NonInteractive -Command \"$ErrorActionPreference='Stop'; $c=New-Object System.Net.Sockets.TcpClient; $c.ReceiveTimeout=5000; $c.SendTimeout=5000; $c.Connect('whois.iana.org',43); $s=$c.GetStream(); $w=New-Object System.IO.StreamWriter($s); $w.NewLine=\\\"`r`n\\\"; $w.WriteLine('" + domain + "'); $w.Flush(); $r=New-Object System.IO.StreamReader($s); $text=$r.ReadToEnd(); $c.Close(); $text\""

    let response = process.spawn(command)

    if y.is_nil(response) || response == "" {
        y.println("WHOIS lookup failed")
        return
    }

    y.println(response)
}
