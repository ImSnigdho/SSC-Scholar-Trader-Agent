# SSC Crypto Assistant - Demo Mode

param(
    [switch]$Video
)

$ErrorActionPreference = "Stop"

function Write-Header {
    param([string]$text)
    Write-Host ""
    Write-Host ("=" * 60) -ForegroundColor Cyan
    Write-Host "  $text" -ForegroundColor Yellow
    Write-Host ("=" * 60) -ForegroundColor Cyan
    Write-Host ""
}

function Write-Alert {
    param([string]$text)
    Write-Host "ALERT: $text" -ForegroundColor Red
}

function Write-Success {
    param([string]$text)
    Write-Host "[OK] $text" -ForegroundColor Green
}

function Write-Info {
    param([string]$text)
    Write-Host "[INFO] $text" -ForegroundColor Blue
}

function Write-Price {
    param([string]$label, [double]$price, [double]$change)
    $color = if ($change -ge 0) { "Green" } else { "Red" }
    $sign = if ($change -ge 0) { "+" } else { "" }
    $formattedPrice = [math]::Round($price, 2)
    Write-Host "  $label : `$$formattedPrice ($sign$change%)" -ForegroundColor $color
}

# Demo Data
$demoPrices = @{
    BTC = @{ Current = 73744.00; High = 74500; Low = 71200; Change = -2.34 }
    ETH = @{ Current = 2286.50; High = 2350; Low = 2250; Change = 1.12 }
    BNB = @{ Current = 679.36; High = 685; Low = 670; Change = 0.45 }
}

$demoPortfolio = @(
    @{ Exchange = "Binance"; Asset = "BTC"; Amount = 0.0015; Value = 110.62 },
    @{ Exchange = "Binance"; Asset = "ETH"; Amount = 0.05; Value = 114.33 },
    @{ Exchange = "Binance"; Asset = "BNB"; Amount = 0.15; Value = 101.90 },
    @{ Exchange = "Binance"; Asset = "USDT"; Amount = 50.00; Value = 50.00 },
    @{ Exchange = "Bybit"; Asset = "BTC"; Amount = 0.0005; Value = 36.87 },
    @{ Exchange = "Bybit"; Asset = "USDT"; Amount = 25.00; Value = 25.00 }
)

Clear-Host
Write-Host ""
Write-Host "  [SSC CRYPTO ASSISTANT]" -ForegroundColor Yellow
Write-Host "  [DEMO MODE ACTIVE]" -ForegroundColor Magenta
Write-Host "  All data simulated for demonstration" -ForegroundColor DarkGray
Write-Host ""

Start-Sleep -Seconds 1

# === FEATURE 1: Price Monitoring ===
Write-Header "FEATURE 1: Real-Time Price Monitoring"
Write-Info "Fetching prices from Binance API..."
Start-Sleep -Seconds 1

Write-Host ""
Write-Price "BTC/USDT" $demoPrices.BTC.Current $demoPrices.BTC.Change
Write-Price "ETH/USDT" $demoPrices.ETH.Current $demoPrices.ETH.Change
Write-Price "BNB/USDT" $demoPrices.BNB.Current $demoPrices.BNB.Change
Write-Success "Prices updated: $(Get-Date -Format 'HH:mm:ss')"

Start-Sleep -Seconds 2

# === FEATURE 2: Smart Alert ===
Write-Header "FEATURE 2: Smart Price Alert"
Write-Info "Monitoring BTC for >2% movement..."
Start-Sleep -Seconds 1

Write-Alert "BTC dropped 2.34% in the last hour!"
Write-Host ""
Write-Host "  [BTC PRICE ALERT]" -ForegroundColor Red
Write-Host "  Previous: `$75,504.00" -ForegroundColor White
Write-Host "  Current:  `$73,744.00" -ForegroundColor White
Write-Host "  Change:   -2.34%" -ForegroundColor Red
Write-Host "  Time:     $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor White
Write-Host ""
Write-Host "  Logic Report:" -ForegroundColor Yellow
Write-Host "  Technical: RSI at 38, approaching oversold on 4H" -ForegroundColor White
Write-Host "  Sentiment: Market cautious, 55% bearish news" -ForegroundColor White

Start-Sleep -Seconds 2

# === FEATURE 3: Portfolio ===
Write-Header "FEATURE 3: Multi-Exchange Portfolio"
Write-Info "Checking Binance and Bybit balances..."
Start-Sleep -Seconds 1

$binanceItems = @($demoPortfolio | Where-Object { $_.Exchange -eq "Binance" })
$bybitItems = @($demoPortfolio | Where-Object { $_.Exchange -eq "Bybit" })
$binanceTotal = 0
foreach ($item in $binanceItems) { $binanceTotal += $item.Value }
$bybitTotal = 0
foreach ($item in $bybitItems) { $bybitTotal += $item.Value }
$grandTotal = $binanceTotal + $bybitTotal

Write-Host ""
Write-Host "  BINANCE" -ForegroundColor Yellow
Write-Host "  -------" -ForegroundColor DarkGray
foreach ($item in $binanceItems) {
    Write-Host "  $($item.Asset): $($item.Amount) = `$$($item.Value)" -ForegroundColor White
}
Write-Host "  Total: `$$([math]::Round($binanceTotal, 2))" -ForegroundColor Green

Write-Host ""
Write-Host "  BYBIT" -ForegroundColor Blue
Write-Host "  -----" -ForegroundColor DarkGray
foreach ($item in $bybitItems) {
    Write-Host "  $($item.Asset): $($item.Amount) = `$$($item.Value)" -ForegroundColor White
}
Write-Host "  Total: `$$([math]::Round($bybitTotal, 2))" -ForegroundColor Green

Write-Host ""
Write-Host "  =================================" -ForegroundColor Cyan
$bdtValue = [math]::Round($grandTotal * 122.66, 0)
Write-Host "  TOTAL FORTUNE: `$$([math]::Round($grandTotal, 2)) (BDT $bdtValue)" -ForegroundColor Yellow
Write-Host "  =================================" -ForegroundColor Cyan

Start-Sleep -Seconds 2

# === FEATURE 4: Spread Detection ===
Write-Header "FEATURE 4: Cross-Exchange Spread Detection"
Write-Info "Comparing BTC prices across exchanges..."
Start-Sleep -Seconds 1

$binancePrice = 73744.70
$bybitPrice = 73738.90
$spread = [math]::Abs($binancePrice - $bybitPrice)

Write-Host ""
Write-Host "  Binance: `$$binancePrice" -ForegroundColor Yellow
Write-Host "  Bybit:   `$$bybitPrice" -ForegroundColor Blue
Write-Host "  ---------------------" -ForegroundColor DarkGray
Write-Host "  Spread:  `$$([math]::Round($spread, 2))" -ForegroundColor Green

if ($spread -gt 10) {
    Write-Alert "Arbitrage opportunity detected!"
} else {
    Write-Success "Spread within normal range - No arbitrage right now"
}

Start-Sleep -Seconds 2

# === FEATURE 5: Connection Monitor ===
Write-Header "FEATURE 5: API Connection Monitor"
Write-Info "Checking API connectivity..."
Start-Sleep -Seconds 1

Write-Host ""
Write-Host "  Binance API: " -NoNewline
Write-Host "ONLINE" -ForegroundColor Green
Write-Host "  Bybit API:   " -NoNewline
Write-Host "ONLINE" -ForegroundColor Green
Write-Host "  Latency:     142ms" -ForegroundColor DarkGray
Write-Success "All connections healthy"

Start-Sleep -Seconds 1

# === FEATURE 6: Connection Loss Simulation ===
Write-Header "FEATURE 6: Connection Loss Simulation"
Write-Info "Simulating API disconnection..."
Start-Sleep -Seconds 1

Write-Host ""
Write-Host "  [18:30:00] Binance API: " -NoNewline
Write-Host "ONLINE" -ForegroundColor Green
Start-Sleep -Seconds 1
Write-Host "  [18:35:00] Binance API: " -NoNewline
Write-Host "OFFLINE" -ForegroundColor Red
Start-Sleep -Seconds 1
Write-Host "  [18:40:00] Binance API: " -NoNewline
Write-Host "OFFLINE (10+ min - preparing alert)" -ForegroundColor Red
Start-Sleep -Seconds 1
Write-Host "  [18:42:00] Binance API: " -NoNewline
Write-Host "ONLINE (restored)" -ForegroundColor Green

Write-Alert "Critical Connection Lost!"
Write-Host ""
Write-Host "  [CONNECTION ALERT]" -ForegroundColor Red
Write-Host "  API:       Binance" -ForegroundColor White
Write-Host "  Downtime:  12 minutes" -ForegroundColor White
Write-Host "  Status:    Restored" -ForegroundColor Green
Write-Host "  Time:      $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor White

Start-Sleep -Seconds 2

# === SUMMARY ===
Write-Header "DEMO COMPLETE"

Write-Host "  Features demonstrated:" -ForegroundColor White
Write-Host "  [OK] Real-time price monitoring" -ForegroundColor Green
Write-Host "  [OK] Smart price alerts (>2% movement)" -ForegroundColor Green
Write-Host "  [OK] Multi-exchange portfolio tracking" -ForegroundColor Green
Write-Host "  [OK] Cross-exchange spread detection" -ForegroundColor Green
Write-Host "  [OK] API connection monitoring" -ForegroundColor Green
Write-Host "  [OK] Connection loss and recovery alerts" -ForegroundColor Green
Write-Host ""
Write-Host "  ----------------------------------------" -ForegroundColor DarkGray
Write-Host "  SSC Crypto Assistant" -ForegroundColor Yellow
Write-Host "  Built for Binance OpenClaw AI Contest 2026" -ForegroundColor DarkGray
Write-Host "  By @DasIstNowrid + Vera AI" -ForegroundColor DarkGray
Write-Host ""
