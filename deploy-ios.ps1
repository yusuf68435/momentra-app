# =============================================================================
# Momentra — iOS Submission Helper Script
# =============================================================================
# Tek komutla tüm submission akışını ayağa kaldırır:
#   1. Web (public/) deploy → Vercel
#   2. iOS production build → EAS
#   3. App Store Connect'e submit
#
# USAGE:
#   pwsh -File deploy-ios.ps1                 # all phases
#   pwsh -File deploy-ios.ps1 -SkipWeb        # skip vercel deploy
#   pwsh -File deploy-ios.ps1 -SkipBuild      # skip EAS build (re-submit last)
#   pwsh -File deploy-ios.ps1 -SubmitOnly     # only submit, no build
#
# PREREQUISITES:
#   - Node + npm installed
#   - Vercel CLI authenticated (`vercel login`)
#   - EAS CLI authenticated (`eas login`)
#   - momentra.app domain pointing to Vercel
#   - Apple Team ID filled in `public/.well-known/apple-app-site-association`
#   - AuthKey_X2MRHFV27Z.p8 in parent dir (already done)
# =============================================================================

param(
    [switch]$SkipWeb,
    [switch]$SkipBuild,
    [switch]$SubmitOnly
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "🚀 Momentra iOS Submission Pipeline" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# ----- Sanity checks -----
$projectRoot = $PSScriptRoot
if (-not (Test-Path "$projectRoot\app.json")) {
    Write-Host "❌ app.json not found in $projectRoot. Run this script from project root." -ForegroundColor Red
    exit 1
}

$ascKey = "$projectRoot\..\AuthKey_X2MRHFV27Z.p8"
if (-not (Test-Path $ascKey)) {
    Write-Host "⚠️  ASC API key missing: $ascKey" -ForegroundColor Yellow
    Write-Host "    `eas submit` will prompt for it interactively." -ForegroundColor Yellow
}

# ----- Phase 1: Vercel deploy -----
if (-not $SkipWeb -and -not $SubmitOnly) {
    Write-Host "📡 Phase 1/3: Deploying public/ to Vercel..." -ForegroundColor Green
    Push-Location $projectRoot
    try {
        vercel --prod public/
        if ($LASTEXITCODE -ne 0) { throw "Vercel deploy failed." }
        Write-Host "✅ Web deployed.`n" -ForegroundColor Green
    } finally {
        Pop-Location
    }

    Write-Host "🌐 Verify these URLs return 200 + correct content:" -ForegroundColor Yellow
    Write-Host "   https://momentra.app/privacy.html" -ForegroundColor Gray
    Write-Host "   https://momentra.app/terms.html" -ForegroundColor Gray
    Write-Host "   https://momentra.app/.well-known/apple-app-site-association (must be JSON)" -ForegroundColor Gray
    Write-Host ""
    $continue = Read-Host "URLs OK? Continue with build? (y/n)"
    if ($continue -ne "y") {
        Write-Host "Aborted by user. Web is live, but build skipped." -ForegroundColor Yellow
        exit 0
    }
}

# ----- Phase 2: EAS Build -----
if (-not $SkipBuild -and -not $SubmitOnly) {
    Write-Host "🏗  Phase 2/3: Starting EAS iOS production build..." -ForegroundColor Green
    Write-Host "    (this runs on EAS cloud, ~15-25 min)" -ForegroundColor Gray
    Push-Location $projectRoot
    try {
        eas build --platform ios --profile production --non-interactive
        if ($LASTEXITCODE -ne 0) { throw "EAS build failed." }
        Write-Host "✅ Build complete.`n" -ForegroundColor Green
    } finally {
        Pop-Location
    }
}

# ----- Phase 3: EAS Submit -----
Write-Host "📤 Phase 3/3: Submitting latest build to App Store Connect..." -ForegroundColor Green
Push-Location $projectRoot
try {
    eas submit --platform ios --latest --non-interactive
    if ($LASTEXITCODE -ne 0) { throw "EAS submit failed." }
    Write-Host "✅ Submitted to App Store Connect.`n" -ForegroundColor Green
} finally {
    Pop-Location
}

Write-Host "🎉 Done! Next steps:" -ForegroundColor Cyan
Write-Host "   1. Open https://appstoreconnect.apple.com" -ForegroundColor White
Write-Host "   2. App → Momentra → 1.0 Prepare for Submission" -ForegroundColor White
Write-Host "   3. Bind the uploaded build (may take 5-10 min to appear)" -ForegroundColor White
Write-Host "   4. Fill metadata from APP_STORE_METADATA.md" -ForegroundColor White
Write-Host "   5. Upload screenshots from assets/screenshots/{tr,en}/" -ForegroundColor White
Write-Host "   6. Submit for Review" -ForegroundColor White
Write-Host ""
