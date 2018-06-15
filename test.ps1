[CmdletBinding()]
Param(
    [Parameter(Mandatory)]
    $Root
)

$ErrorActionPreference = "stop"

function main
{
    $test = getTest
    $report = "$($test.DirectoryName)/report.xml"
    $success = runTest $test
    uploadReport $report
    if (! $success)
    {
        Write-Error "Test $($test.FullName) failed"
    }
}

function getTest
{
    Get-ChildItem "$Root\inverter-test" -Recurse -File -Include inverter-test,inverter-test.exe | Select-Object -First 1
}

function runTest($test, $report)
{
    
    &$test --gtest_output=xml:$report | Write-Host
    return $LASTEXITCODE -eq 0
}

function uploadReport($report)
{
    # https://www.appveyor.com/docs/running-tests/#uploading-xml-test-results
    if ($env:APPVEYOR_JOB_ID)
    {
        Write-Verbose "Uploading $report to AppVeyor"
        $wc = New-Object 'System.Net.WebClient'
        $wc.UploadFile("https://ci.appveyor.com/api/testresults/junit/$($env:APPVEYOR_JOB_ID)", $report)
    }
    else
    {
        Write-Verbose "Not running under a CI framework - not uploading $report"
    }
}

main