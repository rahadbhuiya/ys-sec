param(
  [Parameter(Position=0)] [string]$Command = "help",
  [Parameter(Position=1)] [string]$A = "",
  [Parameter(Position=2)] [string]$B = "",
  [Parameter(Position=3)] [string]$C = "",
  [switch]$Service,
  [switch]$Json,
  [string]$Out = ""
)

$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$source = Join-Path $root "ys-sec.y"

$env:YS_SEC_CMD = $Command
$env:YS_SEC_A = $A
$env:YS_SEC_B = $B
$env:YS_SEC_C = $C
$env:YS_SEC_SERVICE = if ($Service) { "1" } else { "0" }
$env:YS_SEC_JSON = if ($Json) { "1" } else { "0" }
$env:YS_SEC_OUT = $Out

& ys $source
$code = $LASTEXITCODE

Remove-Item Env:YS_SEC_CMD,Env:YS_SEC_A,Env:YS_SEC_B,Env:YS_SEC_C,Env:YS_SEC_SERVICE,Env:YS_SEC_JSON,Env:YS_SEC_OUT -ErrorAction SilentlyContinue
exit $code
