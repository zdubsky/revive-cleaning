# Wraps prism-clean.html (the artifact source, which has no <html>/<head>) into a
# standalone index.html that any static host can serve. Run after editing the source:
#   powershell -ExecutionPolicy Bypass -File build.ps1
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$body = [IO.File]::ReadAllText((Join-Path $here 'prism-clean.html'), [Text.Encoding]::UTF8)
$head = @'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%}[hidden]{display:none!important}</style>
</head>
<body>
'@
$out = $head + "`n" + $body + "`n</body>`n</html>`n"
[IO.File]::WriteAllText((Join-Path $here 'index.html'), $out, (New-Object Text.UTF8Encoding($false)))
Write-Output "Wrote index.html ($($out.Length) chars)"
