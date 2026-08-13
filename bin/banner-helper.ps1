$client = $null
try {
  $client = New-Object System.Net.Sockets.TcpClient
  $client.ReceiveTimeout = 3000
  $client.SendTimeout = 3000
  $client.Connect($env:YS_SEC_A, [int]$env:YS_SEC_B)
  $stream = $client.GetStream()
  $stream.ReadTimeout = 3000
  $buffer = New-Object byte[] 4096
  $n = $stream.Read($buffer, 0, $buffer.Length)
  if ($n -gt 0) {
    $text = [Text.Encoding]::ASCII.GetString($buffer, 0, $n)
    $text = $text -replace "`r", " " -replace "`n", " "
    Write-Output ("BANNER=" + $text.Trim())
  } else {
    Write-Output "BANNER="
  }
} catch {
  Write-Output "BANNER="
} finally {
  if ($null -ne $client) { $client.Close() }
}
