$ErrorActionPreference = 'Stop'
try {
    $url = $env:YS_SEC_A
    if ([string]::IsNullOrWhiteSpace($url)) { throw "URL is empty" }

    $r = Invoke-WebRequest -UseBasicParsing -Uri $url -MaximumRedirection 5 -ErrorAction Stop
    $body = [string]$r.Content

    Write-Output ("STATUS=" + [int]$r.StatusCode)
    Write-Output ("BODY_LEN=" + [Text.Encoding]::UTF8.GetByteCount($body))
}
catch {
    Write-Output ("ERROR=" + $_.Exception.Message)
}
