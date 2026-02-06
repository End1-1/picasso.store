$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$pubspec = Join-Path $scriptDir "..\pubspec.yaml"
$pubspec = Resolve-Path $pubspec

$content = Get-Content $pubspec

for ($i = 0; $i -lt $content.Length; $i++) {
    if ($content[$i] -match '^version:\s*([0-9\.]+)\+([0-9]+)') {
        $ver = $matches[1]
        $build = [int]$matches[2] + 1
        $content[$i] = "version: $ver+$build"
        Write-Host "Version bumped: $ver+$build"
        break
    }
}

Set-Content $pubspec $content -Encoding UTF8
