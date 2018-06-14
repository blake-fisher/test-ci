[CmdletBinding()]
Param(
    [Parameter(Mandatory)]
    $CMakeBuildFolder,
    [Parameter(Mandatory)]
    $Generator
)

$ErrorActionPreference = "stop"

New-Item -Type Directory $CMakeBuildFolder -ErrorAction Ignore -Verbose | Out-Null
Push-Location $CMakeBuildFolder
try
{
    cmake -G $Generator $PSScriptRoot
    cmake --build .
}
finally
{
    Pop-Location
}