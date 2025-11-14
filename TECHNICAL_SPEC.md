# Technical Specification - UnifiedBasketFX

## Overview
This document provides technical specifications for the unified Expert Advisor that combines 9 individual EAs into one.

## Architecture

### File Structure
```
UnifiedBasketFX.mq4
├── Properties & Metadata
├── Input Parameters
│   ├── Master Controls
│   ├── Strategy 1-9 Parameters
│   └── Risk Management
├── Global Variables
├── Initialization (OnInit)
├── Deinitialization (OnDeinit)
├── Main Loop (OnTick)
├── Strategy Execution Functions (1-9)
└── Helper Functions
```

## Parameter Specifications

### Master Controls
| Parameter | Type | Default | Range | Purpose |
|-----------|------|---------|-------|---------|
| EnableEA | bool | true | true/false | Master switch for entire EA |
| TradeOnNewBarOnly | bool | true | true/false | Execute only on new bar formation |
| MagicNumberBase | int | 10000 | 1-999999 | Base for magic number calculation |

### Per-Strategy Parameters
Each strategy (1-9) has the following parameters:

| Parameter Pattern | Type | Default | Purpose |
|-------------------|------|---------|---------|
| Enable_Strategy# | bool | true | Enable/disable this strategy |
| Lot_Strategy# | double | 0.01 | Position size for this strategy |
| StopLoss_Strategy# | int | 50 | Stop loss in pips |
| TakeProfit_Strategy# | int | 100 | Take profit in pips |
| Param1_Strategy# | int | 14 | Strategy-specific parameter 1 |
| Param2_Strategy# | int | 20 | Strategy-specific parameter 2 |

**Note:** Param1 and Param2 are placeholders. Actual parameters will be added based on original EA requirements.

### Risk Management Parameters
| Parameter | Type | Default | Range | Purpose |
|-----------|------|---------|-------|---------|
| MaxRiskPercent | double | 2.0 | 0.1-10.0 | Max risk per trade (% of balance) |
| MaxDailyLoss | double | 500.0 | 0-10000 | Max allowed daily loss ($) |
| MaxOpenTrades | int | 10 | 1-100 | Total concurrent trades allowed |
| MaxTradesPerStrategy | int | 3 | 1-20 | Max trades per strategy |

## Magic Number System

### Calculation
```
Strategy Magic Number = MagicNumberBase + StrategyNumber
```

### Examples
- Strategy 1: 10000 + 1 = 10001
- Strategy 2: 10000 + 2 = 10002
- ...
- Strategy 9: 10000 + 9 = 10009

### Purpose
- Unique identification of trades by strategy
- Trade filtering and counting
- Performance tracking per strategy
- Independent strategy management

## Global Variables

### Tracking Variables
| Variable | Type | Purpose |
|----------|------|---------|
| LastBarTime | datetime | Track last bar time for new bar detection |
| DailyPL | double | Track daily profit/loss |
| LastDayChecked | datetime | Track when daily P&L was reset |

### Variable Naming Convention
Original EA variables should be renamed with strategy suffix:
```
Original: lastTradeTime
Unified:  lastTradeTime_Strategy1
```

## Function Specifications

### Core Functions

#### OnInit()
```mql4
int OnInit()
```
**Purpose:** Initialize EA, setup variables, validate parameters
**Returns:** INIT_SUCCEEDED or error code
**Actions:**
- Print initialization message
- Set LastBarTime
- Reset DailyPL
- Initialize strategy-specific variables
- Validate parameters

#### OnDeinit()
```mql4
void OnDeinit(const int reason)
```
**Purpose:** Cleanup when EA is removed
**Parameters:** reason - why EA is being removed
**Actions:**
- Print deinitialization message
- Cleanup indicators (if any)
- Save state (if needed)

#### OnTick()
```mql4
void OnTick()
```
**Purpose:** Main execution loop, called on every tick
**Flow:**
1. Check if EA is enabled
2. Check for new bar (if TradeOnNewBarOnly)
3. Update daily P&L
4. Check risk limits
5. Execute enabled strategies

### Strategy Functions

#### ExecuteStrategy#()
```mql4
void ExecuteStrategy1()
void ExecuteStrategy2()
...
void ExecuteStrategy9()
```
**Purpose:** Execute specific strategy logic
**Actions:**
1. Get strategy magic number
2. Check strategy trade limits
3. Execute strategy entry logic
4. Execute strategy exit logic
5. Manage open positions

### Helper Functions

#### IsNewBar()
```mql4
bool IsNewBar()
```
**Returns:** true if new bar formed, false otherwise
**Logic:** Compare current Time[0] with LastBarTime

#### CheckRiskLimits()
```mql4
bool CheckRiskLimits()
```
**Returns:** true if trading allowed, false if limits reached
**Checks:**
1. Daily loss limit
2. Maximum open trades
3. Other risk constraints

#### CountOpenTrades()
```mql4
int CountOpenTrades(int strategyNumber)
```
**Parameters:** strategyNumber (0 = all strategies, 1-9 = specific)
**Returns:** Count of open trades
**Logic:** Loop through orders, filter by symbol and magic number

#### UpdateDailyPL()
```mql4
void UpdateDailyPL()
```
**Purpose:** Calculate current daily profit/loss
**Logic:**
1. Check if new day
2. Reset if needed
3. Sum profit from all EA trades

#### CalculateLotSize()
```mql4
double CalculateLotSize(double riskPercent, int stopLossPips)
```
**Parameters:**
- riskPercent: Risk as % of balance
- stopLossPips: Stop loss distance in pips
**Returns:** Calculated lot size
**Logic:** Risk-based position sizing calculation

#### OpenTrade()
```mql4
bool OpenTrade(int type, double lots, int slPips, int tpPips, int magic)
```
**Parameters:**
- type: OP_BUY or OP_SELL
- lots: Position size
- slPips: Stop loss in pips
- tpPips: Take profit in pips
- magic: Magic number
**Returns:** true if successful, false otherwise
**Actions:**
1. Calculate entry price
2. Calculate SL and TP prices
3. Send order
4. Handle errors

#### CloseStrategyTrades()
```mql4
void CloseStrategyTrades(int strategyNumber)
```
**Parameters:** strategyNumber (1-9)
**Purpose:** Close all trades for specific strategy
**Logic:** Loop through orders, close those matching magic number

## Data Flow

### Tick Processing Flow
```
Tick arrives
    ↓
OnTick() called
    ↓
Check EnableEA
    ↓ [false]
    └→ Return
    ↓ [true]
Check TradeOnNewBarOnly
    ↓ [true]
    Check IsNewBar()
        ↓ [false]
        └→ Return
    ↓ [true]
UpdateDailyPL()
    ↓
CheckRiskLimits()
    ↓ [false - limits reached]
    └→ Return
    ↓ [true - limits OK]
For each enabled strategy:
    ↓
    ExecuteStrategy#()
        ↓
        Check strategy trade limits
            ↓ [reached]
            └→ Skip
            ↓ [OK]
        Execute strategy logic
            ↓
            Check entry conditions
                ↓ [met]
                OpenTrade()
            ↓
        Check exit conditions
            ↓ [met]
            Close trades
```

## Error Handling

### Trade Errors
- ERR_INVALID_STOPS: Adjust SL/TP to broker requirements
- ERR_NOT_ENOUGH_MONEY: Check margin, reduce lot size
- ERR_TRADE_NOT_ALLOWED: Verify AutoTrading is enabled
- ERR_INVALID_TRADE_VOLUME: Adjust lot size to broker limits

### Common Checks
```mql4
// Check if trading is allowed
if(!IsTradeAllowed())
{
   Print("Trading not allowed");
   return;
}

// Check connection
if(!IsConnected())
{
   Print("No connection");
   return;
}

// Validate lot size
double minLot = MarketInfo(Symbol(), MODE_MINLOT);
double maxLot = MarketInfo(Symbol(), MODE_MAXLOT);
if(lots < minLot || lots > maxLot)
{
   Print("Invalid lot size");
   return;
}
```

## Performance Considerations

### Optimization Tips
1. **Cache Indicator Values:** Store frequently used indicators
2. **Limit Calculations:** Only calculate when needed
3. **Use New Bar Logic:** Avoid processing every tick
4. **Minimize Loops:** Optimize order searching
5. **Avoid Redundancy:** Don't recalculate same values

### Resource Usage
- **CPU:** Moderate (depends on strategy complexity)
- **Memory:** Low-Medium (9 strategies running)
- **Network:** Normal (trade execution only)

## Testing Requirements

### Pre-Deployment Tests
1. **Compilation Test**
   - No errors
   - No warnings (or only acceptable warnings)

2. **Strategy Tester**
   - Test each strategy individually
   - Test with multiple strategies
   - Test with all strategies
   - Verify magic numbers are unique
   - Check parameter behavior

3. **Visual Mode Test**
   - Observe entry/exit signals
   - Verify SL/TP placement
   - Check trade comments

4. **Risk Management Test**
   - Test daily loss limit
   - Test max trades limit
   - Test per-strategy limits
   - Verify calculations

### Demo Account Tests
1. Run for minimum 1-2 weeks
2. Monitor all strategies
3. Verify no conflicts
4. Check performance vs original EAs
5. Validate risk management

## Integration Checklist

When integrating actual EA files:

- [ ] Extract all input parameters
- [ ] Rename conflicting variables
- [ ] Preserve all trading logic
- [ ] Copy indicator calculations
- [ ] Integrate helper functions
- [ ] Update magic numbers
- [ ] Test compilation
- [ ] Verify each strategy works independently
- [ ] Test multiple strategies together
- [ ] Document any deviations from original
- [ ] Update parameter descriptions
- [ ] Create specific user documentation

## Compatibility

### MetaTrader Version
- **Target:** MetaTrader 4 (Build 1320+)
- **Language:** MQL4 (strict mode)
- **Compilation:** MetaEditor 4

### Broker Requirements
- Standard or ECN accounts supported
- Minimum spread requirements (strategy-dependent)
- Leverage requirements (strategy-dependent)
- Commission structure compatible

### Dependencies
- Standard MQL4 libraries only
- No external DLLs (unless original EAs require)
- Custom indicators (if used by original EAs)

## Security Considerations

### Input Validation
- Validate all user inputs
- Ensure lot sizes within broker limits
- Verify SL/TP distances meet minimums
- Check parameter ranges

### Risk Limits
- Hard-coded maximum lot size (safety)
- Maximum daily loss enforcement
- Trade count limits
- Balance protection

## Maintenance

### Version Control
- Track changes with git
- Tag releases (v1.0, v1.1, etc.)
- Document modifications
- Keep changelog

### Updates
- Bug fixes: Patch version (1.0.1)
- New features: Minor version (1.1.0)
- Major changes: Major version (2.0.0)

## Support

### Debugging
- Enable detailed logging
- Use Print() statements
- Check Expert Journal
- Review Account History

### Common Issues
- Trades not opening: Check parameters, limits, conditions
- Wrong lot size: Verify calculation, check broker limits
- Incorrect magic numbers: Verify MagicNumberBase
- Strategies conflict: Check timing, ensure proper separation

## Future Enhancements

Potential improvements:
- [ ] Web-based monitoring interface
- [ ] Email/push notifications
- [ ] Advanced risk management
- [ ] Dynamic parameter optimization
- [ ] Performance analytics dashboard
- [ ] Trade correlation analysis
- [ ] Multi-symbol support per strategy
- [ ] News filter integration
- [ ] Time-based strategy activation

---

**Document Version:** 1.0
**Last Updated:** 2025-11-14
**Status:** Template - Awaiting source files for specific implementation
