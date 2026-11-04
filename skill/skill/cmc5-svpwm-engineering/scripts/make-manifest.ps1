param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectRoot,
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $ProjectRoot).Path
if (-not $OutputPath) {
    $OutputPath = Join-Path $root 'manifest.sha256.json'
}
$absoluteOutput = [System.IO.Path]::GetFullPath($OutputPath)

$entries = Get-ChildItem -LiteralPath $root -Recurse -File |
    Where-Object {
        $_.FullName -ne $absoluteOutput -and
        $_.FullName -notmatch '[\\/]\.Xil[\\/]' -and
        $_.Extension -notin '.jou', '.log'
    } |
    Sort-Object FullName |
    ForEach-Object {
        $relative = [System.IO.Path]::GetRelativePath($root, $_.FullName).Replace('\', '/')
        [ordered]@{
            path = $relative
            bytes = $_.Length
            sha256 = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash
        }
    }

$manifest = [ordered]@{
    format = 'sha256-manifest-v1'
    project_root_name = Split-Path -Leaf $root
    generated_utc = [DateTime]::UtcNow.ToString('o')
    file_count = @($entries).Count
    files = @($entries)
}

$parent = Split-Path -Parent $absoluteOutput
if ($parent) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
$manifest | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $absoluteOutput -Encoding UTF8
Get-Item -LiteralPath $absoluteOutput | Select-Object FullName, Length
