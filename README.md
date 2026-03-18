# 🦞 SSC Scholar-Trader: AI Agent for Binance & Bybit

[![OpenClaw Version](https://img.shields.io/badge/OpenClaw-2026.3.13-blueviolet)](https://openclaw.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📖 Project Overview
The **SSC Scholar-Trader** is an autonomous AI agent built for the **Binance Little Lobster Competition**. As an SSC 2026 candidate, I designed this bot to solve a personal challenge: balancing high-volatility crypto trading with intensive academic preparation.

The bot leverages the **OpenClaw** framework to monitor the market, perform cross-exchange arbitrage, and execute risk-management strategies—allowing the user to stay focused on their studies.

---

## ✨ Key Features

### 🛡️ Study-Guard Logic (SSC Mode)
* Automatically tightens stop-losses on Binance and Bybit.
* Silences non-essential notifications.
* Moves active positions to USDT if unpredictable volatility (>5%) is detected.

### ⚖️ Dual-Exchange Arbitrage
Monitors price spreads between **Binance** and **Bybit** for $BTC and $LOBSTER, ensuring trades are always executed on the exchange with the most favorable price.

### 💓 Volatility Heartbeat
A proactive monitoring system that scans the market every 5 minutes. It sends instant Telegram/Discord alerts if price action becomes "unpredictable," keeping the user informed without requiring constant screen-watching.

---

## 🛠 Tech Stack
* **Framework:** [OpenClaw](https://github.com/open-claw/open-claw) (2026.3.13)
* **Trading APIs:** Binance Spot/Perpetual, Bybit V5
* **Language:** Python, PowerShell
* **Intelligence:** Hunter Alpha (via OpenClaw Gateway)

---

## 🚀 Installation & Setup

1. **Clone the Repo:**
   ```bash
   git clone [https://github.com/ImSnigdho/SSC-Scholar-Trader-Agent.git](https://github.com/ImSnigdho/SSC-Scholar-Trader-Agent.git)
   cd SSC-Scholar-Trader-Agent
