$ErrorActionPreference = 'Stop'
try {
  $url = $env:YS_SEC_A
  $r = Invoke-WebRequest -UseBasicParsing -Uri $url -MaximumRedirection 5 -ErrorAction Stop
  Write-Output ("STATUS=" + [int]$r.StatusCode)
  foreach ($key in $r.Headers.Keys) {
    Write-Output ("HEADER=" + $key + ": " + [string]$r.Headers[$key])
  }
} catch {
  Write-Output ("ERROR=" + $_.Exception.Message)
}
