[CmdletBinding()]
Param(
    [Parameter(Mandatory)]
    $Root
)

$ErrorActionPreference = "stop"

$testExecutables = Get-ChildItem "$Root\inverter-test" -Recurse -File -Include inverter-test,inverter-test.exe
$testExecutables | Foreach-Object { &$_ }