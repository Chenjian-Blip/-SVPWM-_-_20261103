param(
    [Parameter(Mandatory = $true)]
    [string]$BaselineTiming,
    [Parameter(Mandatory = $true)]
    [string]$BaselineUtilization,
    [Parameter(Mandatory = $true)]
    [string]$ChaosTiming,
    [Parameter(Mandatory = $true)]
    [string]$ChaosUtilization,
    [string]$OutputMarkdown
)

$ErrorActionPreference = 'Stop'

function Get-FirstNumber {
    param([string]$Text, [string]$Pattern, [string]$Label)
    $match = [regex]::Match($Text, $Pattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)
    if (-not $match.Success) { throw "Cannot parse $Label" }
    return [double]$match.Groups[1].Value
}

function Read-Timing {
    param([string]$Path)
    $text = Get-Content -LiteralPath $Path -Raw
    $table = [regex]::Match(
        $text,
        'WNS\(ns\).*?\r?\n\s*-+.*?\r?\n\s*([-+]?\d+(?:\.\d+)?)\s+([-+]?\d+(?:\.\d+)?)',
        [System.Text.RegularExpressions.RegexOptions]::Singleline
    )
    if (-not $table.Success) { throw "Cannot parse timing summary: $Path" }
    [ordered]@{
        wns_ns = [double]$table.Groups[1].Value
        tns_ns = [double]$table.Groups[2].Value
        timing_met = $text.Contains('All user specified timing constraints are met.')
    }
}

function Read-Utilization {
    param([string]$Path)
    $text = Get-Content -LiteralPath $Path -Raw
    [ordered]@{
        slice_lut = Get-FirstNumber $text '^\|\s*Slice LUTs\s*\|\s*(\d+)' 'Slice LUTs'
        slice_register = Get-FirstNumber $text '^\|\s*Slice Registers\s*\|\s*(\d+)' 'Slice Registers'
        block_ram_tile = Get-FirstNumber $text '^\|\s*Block RAM Tile\s*\|\s*(\d+)' 'Block RAM Tile'
        dsp = Get-FirstNumber $text '^\|\s*DSPs\s*\|\s*(\d+)' 'DSPs'
    }
}

$baselineTimingData = Read-Timing $BaselineTiming
$baselineUtilData = Read-Utilization $BaselineUtilization
$chaosTimingData = Read-Timing $ChaosTiming
$chaosUtilData = Read-Utilization $ChaosUtilization

$lines = @(
    '# Vivado implementation comparison',
    '',
    '| Metric | Baseline | Chaos | Delta |',
    '|---|---:|---:|---:|',
    "| Slice LUT | $($baselineUtilData.slice_lut) | $($chaosUtilData.slice_lut) | $($chaosUtilData.slice_lut - $baselineUtilData.slice_lut) |",
    "| Slice register | $($baselineUtilData.slice_register) | $($chaosUtilData.slice_register) | $($chaosUtilData.slice_register - $baselineUtilData.slice_register) |",
    "| Block RAM tile | $($baselineUtilData.block_ram_tile) | $($chaosUtilData.block_ram_tile) | $($chaosUtilData.block_ram_tile - $baselineUtilData.block_ram_tile) |",
    "| DSP | $($baselineUtilData.dsp) | $($chaosUtilData.dsp) | $($chaosUtilData.dsp - $baselineUtilData.dsp) |",
    "| WNS (ns) | $($baselineTimingData.wns_ns) | $($chaosTimingData.wns_ns) | $($chaosTimingData.wns_ns - $baselineTimingData.wns_ns) |",
    "| TNS (ns) | $($baselineTimingData.tns_ns) | $($chaosTimingData.tns_ns) | $($chaosTimingData.tns_ns - $baselineTimingData.tns_ns) |",
    '',
    "- Baseline timing met: $($baselineTimingData.timing_met)",
    "- Chaos timing met: $($chaosTimingData.timing_met)"
)

$markdown = $lines -join [Environment]::NewLine
if ($OutputMarkdown) {
    $parent = Split-Path -Parent $OutputMarkdown
    if ($parent) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    Set-Content -LiteralPath $OutputMarkdown -Value $markdown -Encoding UTF8
}
$markdown
