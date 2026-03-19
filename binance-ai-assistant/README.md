# SSC Crypto Assistant 🦞

> **Smart, Simple, Connected** — An AI-powered crypto monitoring & trading assistant built on OpenClaw for the Binance OpenClaw AI Contest.

[![OpenClaw](https://img.shields.io/badge/Built%20with-OpenClaw-orange)](https://openclaw.ai)
[![Binance API](https://img.shields.io/badge/Binance%20API-v3-yellow)](https://binance-docs.github.io/apidocs/)
[![Bybit API](https://img.shields.io/badge/Bybit%20API-v5-blue)](https://bybit-exchange.github.io/docs/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 🎯 What Is This?

**SSC Scholar-Trader is a persistent, "Soul-driven" AI Agent built on the OpenClaw framework. It isn't just a bot; it’s a cross-platform companion designed to bridge the gap between high-stakes Binance trading and the academic discipline required for success.

Whether you are at your desk on Discord, on the go with WhatsApp, or staying private on Telegram, the Agent maintains a Unified Neural Memory. It monitors global markets, manages your portfolio, and enforces 50/10 Pomodoro study blocks—all through natural language.
**Just a seamless, intelligent conversation that protects your time and your trades.**

---

## ✨ Features

###🌐 Omni-Channel Neural Sync 
- Cross-Platform Memory: Unified memory shared across Telegram, WhatsApp, and Discord.
- Contextual Bridge: Ask on Telegram about a discussion that happened on Discord; the agent retrieves and summarizes the context.
- Persistent State: Your alerts and settings follow you regardless of which app you use.

### 🔔 Smart Price Alerts
- Monitors BTC & ETH prices every 5 minutes
- Automatic alerts when price moves >2% in 1 hour
- Includes price, % change, and market context
- Cross-exchange spread detection (Binance vs Bybit)

### 📊 Portfolio Tracking
- Real-time balance checks across Binance & Bybit
- Multi-currency display (USD, BDT, BTC)
- Spot + Earn + Launchpool positions
- Locked token tracking (vesting schedules)

### 🤖 AI Trading Assistant
- Natural language commands ("Check my BNB balance", "What's BTC doing?")
- Logic Reports with every recommendation (technical + sentiment reason)
- Spot vs Futures education
- Security-first approach (never shares API keys in chat)

### 🌐 Multi-Exchange Support
- **Binance** — Full spot, earn, and account integration
- **Bybit** — Official Bybit Trading Skill v1.0.3
- Cross-exchange price comparison & arbitrage detection

### 🔐 API Connection Monitor
- Checks Binance & Bybit API connectivity every 5 minutes
- "Critical Connection Lost" alert if either goes down for >10 minutes
- Automatic recovery notification

### 🌍 Localization Ready
- Bangla + English mixed conversation support
- BDT (Bangladeshi Taka) conversion built-in
- Timezone-aware (Asia/Dhaka)

---

## 🎬 Demo Mode

Want to see it in action without spending real money? **Demo Mode** simulates everything:

```bash
# Run demo mode
.\demo\demo-mode.ps1
```

**Demo Mode simulates:**
- 📉 BTC price drops 2% → triggers alert instantly
- 🐋 Whale movement detection → notification shown
- 💰 Fake portfolio → PnL dashboard updates live
- 🔌 API disconnection → reconnection alert

Perfect for recording your 2-minute demo video! 🎥

---

## 🧪 Testnet Support

Connect to Binance/Bybit Testnet for **zero-risk trading**:

```bash
# Set environment variables
$env:BINANCE_TESTNET = "true"
$env:BYBIT_ENV = "testnet"

# Run with testnet
.\src\monitor.ps1
```

- Uses **Binance Testnet** (fake USDT, real API)
- Uses **Bybit Testnet** (demo trading)
- All features work exactly like mainnet
- **Zero real money at risk**

---

## 🚀 Quick Start

### Prerequisites
- [OpenClaw](https://docs.openclaw.ai) installed
- Binance API Key (or Testnet key)
- Optional: Bybit API Key

### Installation

1. **Clone this repo:**
```bash
git clone https://github.com/yourusername/binance-ai-assistant.git
cd binance-ai-assistant
```

2. **Configure API keys in OpenClaw:**
```bash
openclaw config set skills.entries.binance.env.BINANCE_API_KEY "your_key"
openclaw config set skills.entries.binance.env.BINANCE_API_SECRET "your_secret"
```

3. **Set up heartbeat monitoring:**
```bash
# Copy heartbeat config
cp heartbeat-config.md ~/.openclaw/workspace/HEARTBEAT.md
```

4. **Start the gateway:**
```bash
openclaw gateway start
```

5. **Message your bot on Telegram:**
```
/start
Check my portfolio
```

---

## 📱 Supported Commands

| Command | Description |
|---------|-------------|
| `Check BTC price` | Current BTC/USDT price |
| `Check my balance` | Full portfolio across exchanges |
| `Compare BNB on Binance vs Bybit` | Cross-exchange price check |
| `What's the spread on BTC?` | Arbitrage opportunity detection |
| `Alert me if BTC moves 2%` | Set custom price alert |
| `Explain spot vs futures` | Crypto education |
| `Run demo mode` | Simulate all features |

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────┐
│              User (Telegram)                │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│          OpenClaw Gateway                   │
│  ┌─────────────────────────────────────┐    │
│  │  HEARTBEAT MONITOR (every 5 min)    │    │
│  │  • BTC/ETH price check              │    │
│  │  • API connection check             │    │
│  │  • Spread detection                 │    │
│  └─────────────────────────────────────┘    │
│  ┌─────────────────────────────────────┐    │
│  │  SKILLS                             │    │
│  │  • Binance API Skill                │    │
│  │  • Bybit Trading Skill v1.0.3       │    │
│  └─────────────────────────────────────┘    │
│  ┌─────────────────────────────────────┐    │
│  │  AI ENGINE                          │    │
│  │  • Natural language processing      │    │
│  │  • Logic Reports                    │    │
│  │  • Demo mode simulation             │    │
│  └─────────────────────────────────────┘    │
└───────┬─────────────────────────┬───────────┘
        │                         │
┌───────▼─────────┐    ┌──────────▼──────────┐
│    Binance API  │    │     Bybit API       │
│  (Spot/Earn)    │    │  (Spot/Derivatives) │
└─────────────────┘    └─────────────────────┘
```

---

## 🔒 Security

- ✅ API keys stored locally in `openclaw.json` (never in chat)
- ✅ Read + Trade permissions only (no Withdraw)
- ✅ Keys masked in all outputs (first 5 + last 4 chars)
- ✅ Confirmation required for all mainnet trades
- ✅ Prompt injection defense on external data

---

## 📸 Screenshots

| Price Alert | Portfolio Check | Cross-Exchange Spread |
|-------------|-----------------|----------------------|
| ![Alert](docs/alert.png) | ![Portfolio](docs/portfolio.png) | ![Spread](docs/spread.png) |

---

## 🗺️ Roadmap

- [x] BTC/ETH price monitoring
- [x] Multi-exchange portfolio tracking
- [x] Smart price alerts (>2% movement)
- [x] API connection monitoring
- [x] Cross-exchange spread detection
- [x] Demo mode
- [x] Testnet support
- [ ] Whale alert tracker (large wallet movements)
- [ ] Auto DCA bot
- [ ] AI trading signals (RSI + volume + sentiment)
- [ ] Bengali crypto education mode
- [ ] Telegram bot commands menu

---

## 👥 Team

Built by **@DasIstNowrid** with **Vera** (AI Assistant) 🶿️

---

## 📄 License

MIT License — feel free to fork, modify, and build on top of this!

---

## 🙏 Acknowledgments

- [Binance](https://binance.com) for the API & OpenClaw contest
- [Bybit](https://bybit.com) for the Trading Skill
- [OpenClaw](https://openclaw.ai) for the AI assistant framework

---

<div align="center">

**🦞 Built for the Binance OpenClaw AI Contest 2026**

*March 4-18, 2026*

</div>
