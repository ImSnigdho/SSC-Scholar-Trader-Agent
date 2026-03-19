# SSC Crypto Assistant - Main Monitor 🦞

# ============================================
# MAIN MONITOR - Real-time crypto monitoring
# Supports: Mainnet & Testnet
# ============================================

param(
    [switch]$Testnet,
    [switch]$Demo,
    [int]$IntervalSeconds = 300  # 5 minutes default
)

$ErrorActionPreference = "Stop"

# --- Configuration ---
$config = @{
    # API Endpoints
    BinanceMainnet = "https://api.binance.com"
    BinanceTestnet = "https://testnet.binance.vision"
    BybitMainnet = "https://api.bybit.com"
    BybitTestnet = "https://api-testnet.bybit.com"
    
    # Alert thresholds
    PriceChangeThreshold = 2.0  # percent
    SpreadThreshold = 10.0      # USDT
    ConnectionTimeout = 600     # seconds (10 minutes)
    
    # Tracked assets
    Watchlist = @("BTCUSDT", "ETHUSDT", "BNBUSDT")
}

# Determine environment
$env:MODE = if ($Testnet) { "TESTNET" } else { "MAINNET" }
$binanceUrl = if ($Testnet) { $config.BinanceTestnet } else { $config.BinanceMainnet }
$bybitUrl = if ($Testnet) { $config.BybitTestnet } else { $config.BybitMainnet }

# --- State ---
$state = @{
    PriceHistory = @{}
    ApiStatus = @{
        Binance = @{ LastOnline = [DateTime]::UtcNow; ConsecutiveFailures = 0 }
        Bybit = @{ LastOnline = [DateTime]::UtcNow; ConsecutiveFailures = 0 }
    }
    AlertsSent = @()
}

# --- Helper Functions ---
function Get-BinancePrice($symbol) {
    try {
        $response = Invoke-RestMethod "$binanceUrl/api/v3/ticker/price?symbol=$symbol" -TimeoutSec 5
        return [PSCustomObject]@{
            Symbol = $symbol
            Price = [double]$response.price
            Timestamp = [DateTime]::UtcNow
            Success = $true
        }
    } catch {
        return [PSCustomObject]@{
            Symbol = $symbol
            Price = $null
            Timestamp = [DateTime]::UtcNow
            Success = $false
            Error = $_.Exception.Message
        }
    }
}

function Get-BybitPrice($symbol) {
    try {
        $response = Invoke-RestMethod "$bybitUrl/v5/market/tickers?category=spot&symbol=$symbol" -TimeoutSec 5
        return [PSCustomObject]@{
            Symbol = $symbol
            Price = [double]$response.result.list[0].lastPrice
            Timestamp = [DateTime]::UtcNow
            Success = $true
        }
    } catch {
        return [PSCustomObject]@{
            Symbol = $symbol
            Price = $null
            Timestamp = [DateTime]::UtcNow
            Success = $false
            Error = $_.Exception.Message
        }
    }
}

function Check-PriceChange($symbol, $currentPrice) {
    $history = $state.PriceHistory[$symbol]
    if (-not $history -or $history.Count -lt 2) { return $null }
    
    # Find price from ~1 hour ago
    $oneHourAgo = [DateTime]::UtcNow.AddHours(-1)
    $oldPrice = $history | Where-Object { $_.Timestamp -le $oneHourAgo } | Select-Object -Last 1
    
    if (-not $oldPrice) {
        # Use oldest available price
        $oldPrice = $history | Select-Object -First 1
    }
    
    if ($oldPrice) {
        $change = (($currentPrice - $oldPrice.Price) / $oldPrice.Price) * 100
        return [math]::Round($change, 2)
    }
    return $null
}

function Check-Spread($symbol) {
    $binance = Get-BinancePrice $symbol
    $bybit = Get-BybitPrice $symbol
    
    if ($binance.Success -and $bybit.Success) {
        $spread = [math]::Abs($binance.Price - $bybit.Price)
        return [PSCustomObject]@{
            Symbol = $symbol
            Binance = $binance.Price
            Bybit = $bybit.Price
            Spread = [math]::Round($spread, 2)
            Alert = $spread -gt $config.SpreadThreshold
        }
    }
    return $null
}

function Send-Alert($type, $message) {
    $timestamp = Get-Date -Format "HH:mm:ss"
    Write-Host "[$timestamp] 🚨 ALERT: $message" -ForegroundColor Red
    $state.AlertsSent += @{ Type = $type; Message = $message; Time = [DateTime]::UtcNow }
}

# --- Main Loop ---
Clear-Host
Write-Host ""
Write-Host "  🦞 SSC CRYPTO ASSISTANT - MONITOR" -ForegroundColor Yellow
Write-Host "  📍 Mode: $($env:MODE)" -ForegroundColor $(if ($Testnet) { "Blue" } else { "Green" })
Write-Host "  ⏱️  Interval: $($IntervalSeconds)s" -ForegroundColor DarkGray
Write-Host "  📡 Watchlist: $($config.Watchlist -join ', ')" -ForegroundColor DarkGray
Write-Host ""

$iteration = 0
while ($true) {
    $iteration++
    $timestamp = Get-Date -Format "HH:mm:ss"
    
    Write-Host "[$timestamp] ── Iteration #$iteration ──" -ForegroundColor DarkGray
    
    # Check each asset
    foreach ($symbol in $config.Watchlist) {
        $binance = Get-BinancePrice $symbol
        $bybit = Get-BybitPrice $symbol
        
        if ($binance.Success) {
            # Store price history
            if (-not $state.PriceHistory[$symbol]) {
                $state.PriceHistory[$symbol] = @()
            }
            $state.PriceHistory[$symbol] += @{ Price = $binance.Price; Timestamp = [DateTime]::UtcNow }
            
            # Keep only last 24 hours
            $cutoff = [DateTime]::UtcNow.AddHours(-24)
            $state.PriceHistory[$symbol] = $state.PriceHistory[$symbol] | Where-Object { $_.Timestamp -gt $cutoff }
            
            $cleanSymbol = $symbol -replace "USDT", ""
            Write-Host "  $cleanSymbol : `$$([math]::Round($binance.Price, 2))" -ForegroundColor White -NoNewline
            
            # Check price change
            $change = Check-PriceChange $symbol $binance.Price
            if ($change -ne $null) {
                $color = if ($change -ge 0) { "Green" } else { "Red" }
                $sign = if ($change -ge 0) { "+" } else { "" }
                Write-Host " ($sign$change%)" -ForegroundColor $color -NoNewline
                
                if ([math]::Abs($change) -ge $config.PriceChangeThreshold) {
                    Send-Alert "PRICE" "$cleanSymbol moved $sign$change% — Current: `$$($binance.Price)"
                }
            }
            Write-Host ""
            
            $state.ApiStatus.Binance.LastOnline = [DateTime]::UtcNow
            $state.ApiStatus.Binance.ConsecutiveFailures = 0
        } else {
            $state.ApiStatus.Binance.ConsecutiveFailures++
            $offlineDuration = ([DateTime]::UtcNow - $state.ApiStatus.Binance.LastOnline).TotalMinutes
            Write-Host "  $symbol : API ERROR" -ForegroundColor Red
            
            if ($offlineDuration -gt 10) {
                Send-Alert "CONNECTION" "Binance API offline for $([math]::Round($offlineDuration)) minutes"
            }
        }
    }
    
    # Check spread
    $spread = Check-Spread "BTCUSDT"
    if ($spread -and $spread.Alert) {
        Send-Alert "SPREAD" "BTC spread `$$($spread.Spread) — Binance: `$$($spread.Binance), Bybit: `$$($spread.Bybit)"
    }
    
    Write-Host ""
    Write-Host "  Next check in $IntervalSeconds seconds..." -ForegroundColor DarkGray
    Start-Sleep -Seconds $IntervalSeconds
}
