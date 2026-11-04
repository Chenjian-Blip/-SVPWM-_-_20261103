param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectRoot,
    [string]$BitPath,
    [string]$ExpectedBitSha256,
    [string]$OutputJson
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $ProjectRoot).Path
$files = @(Get-ChildItem -LiteralPath $root -Recurse -File)

$xpr = @($files | Where-Object Extension -eq '.xpr')
$rtl = @($files | Where-Object { $_.Extension -in '.v', '.sv', '.vhd', '.vhdl' })
$xdc = @($files | Where-Object Extension -eq '.xdc')
$bits = @($files | Where-Object Extension -eq '.bit')
$sim = @($files | Where-Object { $_.FullName -match '[\\/]sim[\\/]' })
$timing = @($files | Where-Object { $_.Name -match 'timing.*\.rpt$' })
$utilization = @($files | Where-Object { $_.Name -match 'utilization.*\.rpt$' })
$drc = @($files | Where-Object { $_.Name -match 'drc.*\.rpt$' })

$failures = [System.Collections.Generic.List[string]]::new()
if ($xpr.Count -eq 0) { $failures.Add('missing Vivado XPR') }
if ($rtl.Count -eq 0) { $failures.Add('missing RTL') }
if ($xdc.Count -eq 0) { $failures.Add('missing XDC') }
if ($bits.Count -eq 0) { $failures.Add('missing BIT') }
if ($sim.Count -eq 0) { $failures.Add('missing simulation files') }
if ($timing.Count -eq 0) { $failures.Add('missing timing report') }
if ($utilization.Count -eq 0) { $failures.Add('missing utilization report') }
if ($drc.Count -eq 0) { $failures.Add('missing DRC report') }

$selectedBit = $null
if ($BitPath) {
    $candidate = if ([System.IO.Path]::IsPathRooted($BitPath)) {
        $BitPath
    } else {
        Join-Path $root $BitPath
    }
    if (Test-Path -LiteralPath $candidate) {
        $selectedBit = (Resolve-Path -LiteralPath $candidate).Path
    } else {
        $failures.Add("specified BIT not found: $candidate")
    }
} elseif ($bits.Count -eq 1) {
    $selectedBit = $bits[0].FullName
}

$bitHash = $null
if ($selectedBit) {
    $bitHash = (Get-FileHash -LiteralPath $selectedBit -Algorithm SHA256).Hash
    if ($ExpectedBitSha256 -and $bitHash -ne $ExpectedBitSha256.ToUpperInvariant()) {
        $failures.Add("BIT SHA-256 mismatch: $bitHash")
    }
} elseif ($ExpectedBitSha256) {
    $failures.Add('BIT hash requested but no unique or specified BIT was selected')
}

$result = [ordered]@{
    project_root = $root
    passed = ($failures.Count -eq 0)
    failures = @($failures)
    counts = [ordered]@{
        xpr = $xpr.Count
        rtl = $rtl.Count
        xdc = $xdc.Count
        bit = $bits.Count
        sim = $sim.Count
        timing_report = $timing.Count
        utilization_report = $utilization.Count
        drc_report = $drc.Count
    }
    selected_bit = $selectedBit
    selected_bit_sha256 = $bitHash
}

$json = $result | ConvertTo-Json -Depth 6
if ($OutputJson) {
    $parent = Split-Path -Parent $OutputJson
    if ($parent) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    Set-Content -LiteralPath $OutputJson -Value $json -Encoding UTF8
}
$json

if ($failures.Count -gt 0) {
    exit 2
}
