# SSC Crypto Assistant - Heartbeat Configuration

## BTC & ETH Price Monitor
- Check BTCUSDT and ETHUSDT prices every 5 minutes
- Compare current price to price from 1 hour ago
- If movement > 2% (up or down) in the last hour:
  1. Send alert to user via current channel
  2. Include: price, % change, and likely reason (news/market)
  3. Check and display Binance balances immediately
- Store price history in memory/heartbeat-state.json
- Use Binance public API for prices (no auth needed)

## API Connection Monitor
- Check Binance API (api.binance.com) and Bybit API (api.bybit.com) connectivity every 5 minutes
- Track connection status in memory/heartbeat-state.json
- If EITHER API is unreachable for more than 10 minutes:
  1. Log the outage timestamp
  2. When connection is restored, send "Critical Connection Lost" alert to Telegram
  3. Include: which API(s) were down, duration of outage, current status
- If both APIs are healthy, silently continue
