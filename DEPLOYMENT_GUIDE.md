# BasketFX Deployment Guide

## Understanding the System

After analyzing all 8 MQ4 files, I discovered they are **IDENTICAL CODE** (same MD5 hash). The system works by having the same EA run with different names, and it self-configures based on its filename.

This is actually **BETTER** than a single unified file because:
1. Each strategy runs independently
2. No risk of one strategy affecting another
3. Original proven logic is preserved
4. Easier to troubleshoot
5. Can enable/disable by simply removing EA from chart

## How BasketFX Works

### The 8 Strategies

**2 Baskets** (7 currency pairs each):
1. **ReticoloFX_Basket_USD** - AUDUSD, USDCAD, USDCHF, EURUSD, GBPUSD, USDJPY, NZDUSD
2. **ReticoloFX_Basket_JPY** - AUDJPY, CADJPY, CHFJPY, EURJPY, GBPJPY, USDJPY, NZDJPY

**6 Rings** (3 currency pairs each):
3. **ReticoloFX_Ring_AUD-NZD-USD** - AUDUSD, AUDNZD, NZDUSD
4. **ReticoloFX_Ring_CAD-EUR-USD** - EURUSD, EURCAD, USDCAD
5. **ReticoloFX_Ring_CHF-EUR-USD** - EURCHF, EURUSD, USDCHF
6. **ReticoloFX_Ring_CHF-GBP-JPY** - CHFJPY, GBPCHF, GBPJPY
7. **ReticoloFX_Ring_EUR-GBP-USD** - EURGBP, EURUSD, GBPUSD
8. **ReticoloFX_Ring_EUR-JPY-USD** - EURJPY, EURUSD, USDJPY

### Total Charts Needed

If you use ALL 8 strategies, you need **32 charts total**:
- Basket_USD: 7 charts
- Basket_JPY: 7 charts
- 6 Rings: 3 charts each = 18 charts

**Total: 7 + 7 + 18 = 32 charts**

## Installation Guide

### Step 1: Prepare the EA Files

1. You need 8 copies of the EA with specific names:
   - ReticoloFX_Basket_USD.mq4
   - ReticoloFX_Basket_JPY.mq4
   - ReticoloFX_Ring_AUD-NZD-USD.mq4
   - ReticoloFX_Ring_CAD-EUR-USD.mq4
   - ReticoloFX_Ring_CHF-EUR-USD.mq4
   - ReticoloFX_Ring_CHF-GBP-JPY.mq4
   - ReticoloFX_Ring_EUR-GBP-USD.mq4
   - ReticoloFX_Ring_EUR-JPY-USD.mq4

2. Copy all 8 files to: `[MT4 Data Folder]/MQL4/Experts/`

3. Compile them in MetaEditor (F7 for each file)

### Step 2: Open Required Charts

For each strategy, open charts for ALL its currency pairs.

**Example for Basket_USD:**
1. Open AUDUSD chart, set to H4 timeframe
2. Open USDCAD chart, set to H4 timeframe
3. Open USDCHF chart, set to H4 timeframe
4. Open EURUSD chart, set to H4 timeframe
5. Open GBPUSD chart, set to H4 timeframe
6. Open USDJPY chart, set to H4 timeframe
7. Open NZDUSD chart, set to H4 timeframe

**Repeat for each strategy you want to use.**

### Step 3: Attach the EA

For Basket_USD example:
1. Drag **ReticoloFX_Basket_USD** onto AUDUSD chart
2. Configure parameters (lot_size, target_profit, etc.)
3. Click OK
4. Drag **ReticoloFX_Basket_USD** onto USDCAD chart
5. Use SAME parameters
6. Click OK
7. **Repeat for all 7 pairs in Basket_USD**

**Important:** Use the SAME EA name and parameters for all pairs in one strategy!

### Step 4: Repeat for Other Strategies

For each strategy you want to run:
1. Open all required charts
2. Attach the correctly-named EA to each chart
3. Use consistent parameters across all charts of that strategy

## Configuration Parameters

### Core Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| lot_size | 0.01 | Position size per trade |
| target_profit | 10.0 | Target profit in points for closing ALL positions |
| minimum_step | 20 | Minimum grid step in points |
| stop_after_close | FALSE | Stop trading after closing a cycle |
| trend_following | TRUE | Follow trend direction |
| closeby_enabled | TRUE | Use CloseBy feature |
| on_hold | FALSE | Pause trading |
| show_next_trades | TRUE | Show next trade levels |
| show_open_trades | TRUE | Show open trade markers |
| show_alert | FALSE | Show alert on close |
| play_sound | FALSE | Play sound on close |
| comment | "" | Custom comment (leave empty for auto) |

### Recommended Settings

**For beginners (conservative):**
```
lot_size = 0.01
target_profit = 10.0
minimum_step = 20
stop_after_close = FALSE
trend_following = TRUE
closeby_enabled = TRUE
on_hold = FALSE
```

**For experienced traders:**
```
lot_size = 0.02
target_profit = 15.0
minimum_step = 15
stop_after_close = FALSE
trend_following = TRUE
closeby_enabled = TRUE
on_hold = FALSE
```

## Money Management

**CRITICAL: Follow these guidelines!**

### Minimum Capital Requirements

Per the documentation:
- **0.01 lot** requires **$1,000** per strategy (or $10 on Cent account)
- For **ALL 8 strategies**: $8,000 minimum (or $80 on Cent account)
- For **3 strategies**: $3,000 minimum (or $30 on Cent account)

### Account Types

**Recommended: Cent-NDD account on Forex4you**
- Lower capital requirements
- Same functionality
- Less risk for testing

**Standard Accounts:**
- Higher capital required
- Full lot sizes
- Better for large accounts

### Risk Warning

⚠️ **This EA has NO STOP LOSS!**
- Uses hedging instead
- Can hold positions for MONTHS
- Requires proper capitalization
- Can experience large drawdowns
- **Risk only what you can afford to lose**

## How the Strategies Communicate

The EAs use **GlobalVariables** to coordinate:

- `{MAGIC}_CLOSE`: When target profit reached, this flag tells all instances to close
- `{MAGIC}_MAXDD`: Tracks maximum drawdown
- `{comment}_STOP`: Control flag for stopping after close

This means:
- All charts of ONE strategy work together
- When combined profit reaches target, ALL positions close
- Each strategy is independent from others

## Enabling/Disabling Strategies

### To Enable a Strategy:
1. Open all required charts
2. Attach the EA to each chart
3. Make sure "Allow live trading" is checked

### To Disable a Strategy:
1. Remove EA from all its charts, OR
2. Set `on_hold = TRUE` in parameters

### To Pause Trading:
- Set `on_hold = TRUE` in EA parameters
- Existing positions remain open
- No new positions will be opened

### To Stop After Next Close:
- Set `stop_after_close = TRUE`
- EA will close current cycle then stop
- Good for planned shutdown

## Monitoring Your EAs

### On-Chart Display

Each EA shows on its chart:
- Current status (RUNNING, STOPPED, ON HOLD)
- Current spread and grid step
- Next BUY/SELL levels
- Number of open orders (BUY/SELL)
- Current floating P/L
- Total P/L for all pairs in this strategy
- Magic number

### Terminal Tab

In MT4 Terminal (Ctrl+T):
- **Trade tab**: See all open positions
- **Account History**: See closed trades
- **Experts tab**: See EA messages and logs

### Understanding the Display

```
ReticoloFX_Basket_USD v1.51
======================
Status: RUNNING
--------------------------------------------
EURUSD Spread: 1.5
EURUSD Step: 25
EURUSD Next BUY @ 1.0950
EURUSD Next SELL @ 1.0900
--------------------------------------------
EURUSD Orders: BUY 3 \ SELL 1
EURUSD Orders Value: $45.50
EURUSD Closed Profit: $12.30
--------------------------------------------
TOTAL Orders: BUY 15 \ SELL 7
TOTAL Orders Value: $234.80
TOTAL Closed Profit: $89.40
TOTAL Max Floating DD: $-45.20
--------------------------------------------
Magic Number: 123456789
```

**Key Info:**
- **TOTAL** = across ALL 7 pairs in Basket_USD
- **EURUSD** = just this chart
- When TOTAL Orders Value reaches target_profit, all close

## Troubleshooting

### EA Not Trading

**Check these:**
1. ✓ "Allow live trading" enabled in Common tab
2. ✓ "Allow DLL imports" enabled (if needed)
3. ✓ Chart timeframe is H4
4. ✓ Symbol is in the strategy's pair list
5. ✓ EA is not on_hold
6. ✓ stop_after_close is not active
7. ✓ Market is open
8. ✓ Sufficient free margin

### Wrong EA on Wrong Chart

If you see:
```
ATTENTION PLEASE!
ReticoloFX_Basket_USD is not made to work on GBPJPY
```

**Solution:** You attached the wrong EA. Remove it and attach the correct one.

For GBPJPY, you need:
- ReticoloFX_Basket_JPY, OR
- ReticoloFX_Ring_CHF-GBP-JPY

### Positions Not Closing

**This is NORMAL if:**
- Target profit not reached yet
- Market is ranging (not trending)
- Strategy is waiting for optimal exit

**Positions can stay open for:**
- Days
- Weeks
- **Even MONTHS**

**This is by design!** The strategy waits for combined profit target.

### High Drawdown

**Normal Behavior:**
- EA uses hedging (BUY and SELL simultaneously)
- Drawdowns are expected
- Strategy relies on correlation and reversions
- Proper capitalization is CRITICAL

**If drawdown seems excessive:**
1. Check you're using correct lot size
2. Verify account capital is sufficient
3. Consider reducing lot_size
4. Review minimum capital requirements

## Best Practices

### 1. Start Small
- Begin with 1-2 strategies
- Use minimum lot sizes
- Test on demo account first
- Use Cent accounts for live testing

### 2. Use a VPS
- EA needs to run 24/5
- VPS ensures no disconnections
- Recommended for serious trading

### 3. Monitor Daily
- Check open positions
- Review floating P/L
- Monitor drawdown levels
- Verify all EAs running

### 4. Keep Terminal Running
- EA must run continuously
- From Sunday open to Friday close
- Any interruption affects strategy
- Use VPS if computer can't run 24/5

### 5. Don't Interfere
- Let EA manage positions
- Don't manually close trades
- Don't change parameters during cycle
- Trust the strategy

### 6. Maintain Margin
- Always have sufficient free margin
- Add funds if margin gets low
- Don't over-leverage
- Follow capital requirements

## Quick Setup Checklist

For each strategy you want to run:

- [ ] 8 EA files copied to Experts folder
- [ ] All EA files compiled successfully
- [ ] All required currency pair charts opened
- [ ] All charts set to H4 timeframe
- [ ] Correct EA attached to each chart
- [ ] Parameters configured identically across charts
- [ ] "Allow live trading" enabled
- [ ] Sufficient account capital
- [ ] VPS or 24/5 computer availability
- [ ] Understanding of how strategy works
- [ ] Acceptance of risk

## Advanced: Running Specific Strategies

### Scenario 1: Only Baskets (2 strategies)
**Charts needed:** 14 (7 + 7)
**Capital needed:** $2,000 (or $20 Cent)
**Setup time:** 30-45 minutes

### Scenario 2: Only Rings (6 strategies)
**Charts needed:** 18 (3 × 6)
**Capital needed:** $6,000 (or $60 Cent)
**Setup time:** 45-60 minutes

### Scenario 3: Custom Selection
**Example: Basket_USD + Ring_EUR-GBP-USD**
**Charts needed:** 7 + 3 = 10
**Capital needed:** $2,000 (or $20 Cent)
**Setup time:** 20-30 minutes

## Support and Updates

### Getting Help
- Review this guide thoroughly
- Check ANALYSIS_REPORT.md for technical details
- Refer to original "como o basketFX funciona.txt"
- Test on demo account first

### Performance Monitoring
- Track each strategy separately
- Monitor combined performance
- Keep trading journal
- Review monthly results

## Conclusion

The BasketFX system is sophisticated and requires:
- **Proper capitalization**
- **Continuous operation**
- **Patience** (positions can stay open long-term)
- **Understanding** of grid and hedging strategies
- **Risk management**

When used correctly with proper capital and settings, it provides an automated multi-currency trading solution based on correlation and mean reversion principles.

**Remember:** Trading involves risk. Never risk more than you can afford to lose. Test thoroughly on demo accounts before live trading.

---

**Questions?** Review the ANALYSIS_REPORT.md for technical details.

**Ready to deploy?** Follow the Installation Guide above step-by-step.
