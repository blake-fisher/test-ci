[CmdletBinding()]
Param(
    [Parameter(Mandatory)]
    $Root
)

$ErrorActionPreference = "stop"

function main
{
    foreach ($test in getTests)
    {
        $report = runTest $test
        uploadReport $report
    }
}

function getTests
{
    Get-ChildItem "$Root\inverter-test" -Recurse -File -Include inverter-test,inverter-test.exe
}

function runTest($test)
{
    $report = "$($test.DirectoryName)/report.xml"
    &$test --gtest_output=xml:$report | Write-Host
    return $report
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