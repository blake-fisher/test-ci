[CmdletBinding()]
Param(
    [Parameter(Mandatory)]
    $CMakeBuildFolder,
    [Parameter(Mandatory)]
    $Generator,
    [Parameter(Mandatory)]
    $Config
)

$ErrorActionPreference = "stop"

New-Item -Type Directory $CMakeBuildFolder -ErrorAction Ignore -Verbose | Out-Null
Push-Location $CMakeBuildFolder
try
{
    cmake -G $Generator $PSScriptRoot
    cmake --build . --config $Config
}
finally
{
    Pop-Location
}