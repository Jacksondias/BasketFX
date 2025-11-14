# UnifiedBasketFX - User Guide

## Introduction

UnifiedBasketFX is a comprehensive Expert Advisor that combines 9 different trading strategies into a single EA. This guide will help you install, configure, and use the EA effectively.

## Table of Contents

1. [Installation](#installation)
2. [First-Time Setup](#first-time-setup)
3. [Parameter Configuration](#parameter-configuration)
4. [Strategy Management](#strategy-management)
5. [Risk Management](#risk-management)
6. [Monitoring](#monitoring)
7. [Troubleshooting](#troubleshooting)
8. [Best Practices](#best-practices)

## Installation

### Step 1: Copy Files

1. Open your MetaTrader 4 data folder:
   - In MT4, click `File` → `Open Data Folder`
   - Navigate to `MQL4/Experts/`

2. Copy `UnifiedBasketFX.mq4` to the `Experts` folder

3. If there are additional files:
   - Copy `.mqh` files to `MQL4/Include/`
   - Copy indicator files to `MQL4/Indicators/`
   - Copy library files to `MQL4/Libraries/`

### Step 2: Compile the EA

1. Open MetaEditor (press F4 in MT4 or click the MetaEditor icon)
2. Navigate to `Experts` in the Navigator panel
3. Double-click `UnifiedBasketFX.mq4` to open it
4. Press F7 to compile
5. Check the "Errors" tab for any issues
6. Successful compilation creates `UnifiedBasketFX.ex4`

### Step 3: Refresh MT4

1. Return to MetaTrader 4
2. Right-click in the Navigator panel
3. Select "Refresh" or press F5
4. `UnifiedBasketFX` should appear under "Expert Advisors"

## First-Time Setup

### Attaching the EA to a Chart

1. Open a chart of your preferred trading symbol (e.g., EURUSD)
2. Set the desired timeframe (e.g., H1)
3. Drag `UnifiedBasketFX` from Navigator onto the chart
4. The "Expert Advisor Properties" dialog will appear

### Initial Configuration

For your first time, configure these essential settings:

#### Common Tab:
- ✅ Check "Allow live trading"
- ✅ Check "Allow DLL imports" (if required by any strategy)
- ✅ Check "Allow imports of external experts" (if needed)

#### Inputs Tab:
Start with these conservative settings:

```
=== MASTER CONTROLS ===
EnableEA: true
TradeOnNewBarOnly: true
MagicNumberBase: 10000

=== RISK MANAGEMENT ===
MaxRiskPercent: 1.0
MaxDailyLoss: 100.0
MaxOpenTrades: 5
MaxTradesPerStrategy: 1

=== STRATEGY 1-9 ===
Enable_Strategy1: true  (start with just one)
Enable_Strategy2: false (disable others initially)
... (disable all except one for testing)
```

## Parameter Configuration

### Master Controls

| Parameter | Description | Recommended Value |
|-----------|-------------|-------------------|
| EnableEA | Master on/off switch | true |
| TradeOnNewBarOnly | Only trade when new bar forms | true (safer) |
| MagicNumberBase | Base number for trade identification | 10000 |

### Strategy-Specific Parameters

Each strategy (1-9) has its own set of parameters:

| Parameter Pattern | Description | Notes |
|-------------------|-------------|-------|
| Enable_Strategy# | Enable/disable this strategy | true/false |
| Lot_Strategy# | Fixed lot size | Start small: 0.01 |
| StopLoss_Strategy# | Stop loss in pips | 30-100 typical |
| TakeProfit_Strategy# | Take profit in pips | 50-200 typical |
| Param1_Strategy# | Strategy-specific parameter | See EA docs |
| Param2_Strategy# | Strategy-specific parameter | See EA docs |

**Note:** The actual parameters for each strategy will depend on the original EA logic.

### Risk Management Parameters

| Parameter | Description | Recommended Range |
|-----------|-------------|-------------------|
| MaxRiskPercent | Max risk per trade (% of balance) | 0.5% - 2.0% |
| MaxDailyLoss | Max allowed daily loss in $ | $50 - $500 |
| MaxOpenTrades | Total concurrent trades allowed | 3 - 10 |
| MaxTradesPerStrategy | Trades per strategy simultaneously | 1 - 3 |

## Strategy Management

### Enabling Strategies

**Start with One Strategy:**
1. Enable only `Enable_Strategy1 = true`
2. Set all others to `false`
3. Test for several days
4. Monitor performance

**Adding More Strategies:**
1. Once Strategy 1 is stable, enable Strategy 2
2. Test both together
3. Gradually enable additional strategies
4. Monitor for conflicts or overtrading

### Disabling Strategies

To disable a strategy:
1. Open EA properties (F7 on the chart or right-click EA → Properties)
2. Go to Inputs tab
3. Set `Enable_Strategy# = false`
4. Click OK

**Important:** Disabling a strategy will:
- ✅ Prevent new trades for that strategy
- ❌ NOT close existing trades (you must do this manually if desired)

### Closing Strategy Trades Manually

To close all trades for a specific strategy:
1. Note the Magic Number: `MagicNumberBase + Strategy Number`
   - Strategy 1 = 10001
   - Strategy 2 = 10002
   - etc.
2. In MT4 Terminal → Trade tab, identify trades by Magic Number or Comment
3. Close them manually or use a trade management script

## Risk Management

### Understanding Risk Limits

The EA includes multiple layers of risk protection:

1. **Per-Trade Risk (MaxRiskPercent)**
   - Calculated based on account balance
   - Applied to each new trade
   - Formula: Risk Amount = Balance × MaxRiskPercent / 100

2. **Daily Loss Limit (MaxDailyLoss)**
   - Tracks P&L for current trading day
   - Stops all trading when limit reached
   - Resets at start of new day (00:00 server time)

3. **Trade Count Limits**
   - `MaxOpenTrades`: Total trades across all strategies
   - `MaxTradesPerStrategy`: Per-strategy concurrent trades
   - Prevents overtrading

### Recommended Settings by Account Size

| Account Size | MaxRiskPercent | MaxDailyLoss | MaxOpenTrades |
|--------------|----------------|--------------|---------------|
| $500 - $1,000 | 0.5% - 1.0% | $50 - $100 | 3 - 5 |
| $1,000 - $5,000 | 1.0% - 1.5% | $100 - $250 | 5 - 8 |
| $5,000 - $10,000 | 1.0% - 2.0% | $250 - $500 | 8 - 12 |
| $10,000+ | 1.0% - 2.0% | $500 - $1,000 | 10 - 15 |

### Risk Management Best Practices

1. **Start Conservative:** Use lower risk settings initially
2. **Scale Gradually:** Increase risk only after proven performance
3. **Monitor Daily:** Check daily loss limit regularly
4. **Adjust for Volatility:** Lower risk during high volatility periods
5. **Use Stop Loss:** Always ensure stop loss is set for each strategy

## Monitoring

### Information Display

The EA displays key information on the chart:
- Daily P&L
- Active strategies
- Open trades count
- Risk limit status

### What to Monitor Daily

1. **Daily P&L**
   - Check against MaxDailyLoss limit
   - Look for unusual losses

2. **Trade Performance**
   - Win rate per strategy
   - Average profit/loss
   - Drawdown levels

3. **Strategy Activity**
   - Which strategies are trading
   - Trade frequency
   - Entry/exit quality

4. **MT4 Journal**
   - Check for errors
   - Look for warnings
   - Verify trade execution

### Using MT4 Terminal

Access detailed information in the Terminal window (Ctrl+T):

- **Trade Tab:** View open positions
  - Check Magic Numbers to identify strategy
  - Monitor profit/loss
  - Check SL/TP levels

- **Account History Tab:** Review closed trades
  - Filter by Magic Number
  - Calculate performance per strategy
  - Identify patterns

- **Experts Tab:** View EA log messages
  - Initialization messages
  - Trade signals
  - Errors or warnings

## Troubleshooting

### EA Not Trading

**Possible causes:**
1. ✓ Check `EnableEA = true`
2. ✓ Check at least one strategy is enabled
3. ✓ Verify "Allow live trading" is checked in Common tab
4. ✓ Check if daily loss limit reached
5. ✓ Verify account has sufficient margin
6. ✓ Check if max trade limits reached

### Compilation Errors

**Common issues:**
1. Missing include files → Copy to `MQL4/Include/`
2. Missing indicators → Copy to `MQL4/Indicators/`
3. Syntax errors → Review Errors tab in MetaEditor
4. Version compatibility → Ensure using MQL4 (not MQL5)

### Trades Not Opening

**Check these:**
1. Market conditions match entry rules
2. Spread is not too wide
3. Trading hours (if strategy has time filters)
4. Minimum lot size meets broker requirements
5. Sufficient free margin
6. No connection issues with broker

### Unexpected Trade Behavior

**Verify:**
1. Parameters are set correctly
2. No conflicting strategies (both trying to trade simultaneously)
3. Check Expert Journal for messages
4. Compare with original EA behavior (if testing against individual EAs)

### Performance Issues

**If EA seems slow:**
1. Reduce number of active strategies
2. Increase `TradeOnNewBarOnly` to true
3. Check indicator calculation frequency
4. Verify no infinite loops in custom code

## Best Practices

### Testing

1. **Strategy Tester First**
   - Test in MT4 Strategy Tester with historical data
   - Verify each strategy works individually
   - Test with multiple strategies enabled

2. **Demo Account**
   - Run on demo account for at least 1-2 weeks
   - Use realistic account size
   - Test during different market conditions

3. **Small Live Account**
   - Start with minimum lot sizes
   - Use conservative risk settings
   - Monitor closely for first month

### Ongoing Management

1. **Regular Review**
   - Weekly performance review
   - Adjust parameters if needed
   - Disable underperforming strategies

2. **Keep Records**
   - Screenshot settings
   - Document parameter changes
   - Track performance metrics

3. **Stay Informed**
   - Monitor economic calendar
   - Be aware of high-impact news
   - Adjust risk during volatile periods

### Parameter Optimization

**DO:**
- ✓ Test parameter changes on demo first
- ✓ Make small incremental changes
- ✓ Document all changes
- ✓ Allow sufficient time (2+ weeks) to evaluate

**DON'T:**
- ✗ Change multiple parameters at once
- ✗ Optimize in live account
- ✗ Over-optimize to historical data
- ✗ Make changes based on short-term results

### Backup Strategy

1. **Save Your Settings**
   - Save parameter sets using MT4's "Save" button in EA properties
   - Name them descriptively (e.g., "Conservative_Settings_Jan2024")

2. **Export Trades**
   - Regularly export account history
   - Save to external file for analysis

3. **Keep EA Files Safe**
   - Maintain backup copies
   - Document any custom modifications

## Advanced Topics

### Multiple Chart Setup

You can run UnifiedBasketFX on multiple charts:
- Different symbols (EURUSD, GBPUSD, etc.)
- Different timeframes
- Different strategy combinations

**Important:** Ensure MagicNumberBase is different on each chart to avoid conflicts.

Example:
- Chart 1 (EURUSD): MagicNumberBase = 10000
- Chart 2 (GBPUSD): MagicNumberBase = 20000
- Chart 3 (USDJPY): MagicNumberBase = 30000

### Custom Modifications

If you need to modify the EA:
1. Work on a copy (e.g., `UnifiedBasketFX_Custom.mq4`)
2. Comment your changes clearly
3. Test thoroughly before live use
4. Keep original version for reference

### Performance Tracking

Consider using external tools:
- Myfxbook for automated analysis
- FX Blue for trade tracking
- Excel spreadsheets for custom metrics
- MT4 reports for detailed statistics

## Support and Updates

### Getting Help

If you encounter issues:
1. Check this user guide
2. Review the INTEGRATION_GUIDE.md for technical details
3. Open an issue on GitHub
4. Provide detailed information:
   - MT4 version
   - Broker name
   - Error messages
   - Screenshots
   - EA settings

### Updates

Check the repository regularly for:
- Bug fixes
- Performance improvements
- New features
- Updated documentation

## Disclaimer

**Important:** Trading forex carries risk. This EA is provided for educational purposes. Always:
- Test thoroughly before live trading
- Never risk money you cannot afford to lose
- Understand that past performance doesn't guarantee future results
- Consult with a financial advisor if unsure
- Use proper risk management

---

**Happy Trading!** 📈

For questions or support, visit: https://github.com/Jacksondias/BasketFX
