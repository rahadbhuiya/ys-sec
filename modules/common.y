fn env(name) {
    return y.env.get(name)
}

fn has_flag(name) {
    return env(name) == "1"
}

fn require_env(name, label) {
    let v = env(name)
    if y.is_nil(v) || v == "" {
        y.println("Missing " + label)
        return nil
    }
    return v
}

fn valid_host(s) {
    if y.is_nil(s) || s == "" { return false }

    for ch in s {
        if ch == " " || ch == "\"" || ch == "'" || ch == ";" || ch == "&" || ch == "|" || ch == "`" {
            return false
        }
    }

    return true
}

fn valid_domain(s) {
    if !valid_host(s) { return false }
    if y.starts_with(s, ".") || y.ends_with(s, ".") { return false }
    return true
}

fn save_if_requested(text) {
    let out = env("YS_SEC_OUT")
    if !y.is_nil(out) && out != "" {
        y.fs.write(out, text)
        y.println("[+] report written: " + out)
    }
}
