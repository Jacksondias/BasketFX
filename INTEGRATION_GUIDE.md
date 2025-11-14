# Integration Guide - Unifying Multiple MQ4 Expert Advisors

## Overview
This guide explains how to merge the 9 individual Expert Advisor (EA) MQ4 files into the unified `UnifiedBasketFX.mq4` file.

## Prerequisites
Before starting the integration, ensure you have:
- [ ] All 9 MQ4 files
- [ ] Documentation file explaining each EA's functionality
- [ ] MetaEditor installed (comes with MetaTrader 4)
- [ ] Basic understanding of MQL4 programming

## Integration Process

### Step 1: Analyze Each EA

For each of the 9 EAs, identify and document:

1. **Input Parameters**
   - What variables can users configure?
   - Default values
   - Valid ranges

2. **Global Variables**
   - What state does the EA maintain?
   - Are there any static variables?

3. **Core Logic**
   - Entry signals (buy/sell conditions)
   - Exit signals (close conditions)
   - Indicators used
   - Timeframes used

4. **Functions**
   - Custom functions defined
   - Helper functions
   - Trade management functions

5. **Dependencies**
   - External indicators required
   - Include files needed
   - DLL imports (if any)

### Step 2: Organize Parameters

In the unified EA template, each strategy has its own parameter section:

```mql4
// Example for Strategy 1
input string    Separator2 = "=== STRATEGY 1 ===";
input bool      Enable_Strategy1 = true;
input double    Lot_Strategy1 = 0.01;
input int       StopLoss_Strategy1 = 50;
input int       TakeProfit_Strategy1 = 100;
// Add more parameters as needed from the original EA
```

**Actions:**
1. Copy all input parameters from the original EA
2. Rename them by adding `_Strategy#` suffix
3. Group them under the appropriate strategy section
4. Maintain the same data types and default values

### Step 3: Merge Global Variables

Each EA may have global variables. To avoid conflicts:

```mql4
// If original EA has:
// datetime lastTradeTime;
// int signalCount;

// In unified EA, rename to:
datetime lastTradeTime_Strategy1;
int signalCount_Strategy1;
```

**Actions:**
1. List all global variables from each EA
2. Rename them with `_Strategy#` suffix
3. Add them to the global variables section of the unified EA
4. Check for duplicate variable names across EAs

### Step 4: Integrate OnInit() Functions

If any EA has initialization code in `OnInit()`:

```mql4
int OnInit()
{
   // Existing unified EA init code
   
   // Strategy 1 initialization
   if(Enable_Strategy1)
   {
      // Copy init code from Strategy 1's OnInit()
   }
   
   // Strategy 2 initialization
   if(Enable_Strategy2)
   {
      // Copy init code from Strategy 2's OnInit()
   }
   
   // ... and so on for all strategies
   
   return(INIT_SUCCEEDED);
}
```

### Step 5: Integrate Strategy Logic

This is the core of the integration. For each strategy:

1. **Create a dedicated function:**
   ```mql4
   void ExecuteStrategy1()
   {
      int magic = MagicNumberBase + 1;
      
      // Check trade limits
      if(CountOpenTrades(1) >= MaxTradesPerStrategy) return;
      
      // Copy the main trading logic from original EA's OnTick()
      // Replace original parameters with Strategy1-specific parameters
      
      // Example: If original EA had:
      // double lot = LotSize;
      // int sl = StopLoss;
      
      // Replace with:
      // double lot = Lot_Strategy1;
      // int sl = StopLoss_Strategy1;
   }
   ```

2. **Adapt indicator calls:**
   - Ensure timeframe is correct
   - Update parameter references
   - Handle indicator buffers properly

3. **Update trade functions:**
   - Use unique magic number: `MagicNumberBase + StrategyNumber`
   - Add strategy identifier to order comments
   - Maintain original entry/exit logic

### Step 6: Merge Helper Functions

Each EA may have helper functions. Options:

**Option A: Keep separate (recommended)**
```mql4
double CalculateLotSize_Strategy1(double risk)
{
   // Original function code
}

double CalculateLotSize_Strategy2(double risk)
{
   // Different calculation
}
```

**Option B: Create unified functions**
```mql4
double CalculateLotSize(double risk, int strategy)
{
   switch(strategy)
   {
      case 1: return CalculateLotSize_Strategy1(risk);
      case 2: return CalculateLotSize_Strategy2(risk);
      // ... etc
   }
}
```

### Step 7: Handle Include Files and Libraries

If any EA uses `#include` or external indicators:

```mql4
// At the top of unified EA, after properties
#include <YourIncludeFile.mqh>
```

Ensure all required files are in the correct folders:
- Include files: `MQL4/Include/`
- Custom indicators: `MQL4/Indicators/`
- Libraries: `MQL4/Libraries/`

### Step 8: Magic Numbers

Each strategy needs a unique magic number to identify its trades:

```mql4
Strategy 1: MagicNumberBase + 1 = 10001
Strategy 2: MagicNumberBase + 2 = 10002
...
Strategy 9: MagicNumberBase + 9 = 10009
```

This allows:
- Individual strategy trade tracking
- Separate closing of strategy trades
- Performance analysis per strategy

### Step 9: Testing Checklist

After integration, verify:

- [ ] All parameters appear in EA properties dialog
- [ ] Each strategy can be enabled/disabled independently
- [ ] Magic numbers are unique for each strategy
- [ ] No variable name conflicts
- [ ] No compilation errors
- [ ] No compilation warnings (review each warning)
- [ ] Test in Strategy Tester with one strategy enabled
- [ ] Test with multiple strategies enabled
- [ ] Verify trades are opened with correct parameters
- [ ] Check trade comments show correct strategy number
- [ ] Verify risk management limits work

### Step 10: Compilation

1. Open MetaEditor
2. Load `UnifiedBasketFX.mq4`
3. Press F7 to compile
4. Review compilation log
5. Fix any errors or warnings
6. Successful compilation creates `UnifiedBasketFX.ex4`

## Common Issues and Solutions

### Issue: Variable Redefinition
**Solution:** Add strategy suffix to all global and local variables

### Issue: Function Name Conflicts
**Solution:** Rename functions with strategy suffix or use different names

### Issue: Indicator Handle Conflicts
**Solution:** Use separate indicator handles for each strategy

### Issue: Order Comment Length
**Solution:** Keep comments short, use codes like "UBF-S1" for "UnifiedBasketFX-Strategy1"

### Issue: Too Many Parameters
**Solution:** Group related parameters, use reasonable defaults

### Issue: Performance Issues
**Solution:** 
- Only calculate indicators when needed
- Use `TradeOnNewBarOnly` option
- Optimize indicator calculations
- Avoid redundant loops

## Best Practices

1. **Keep Original Files:** Always maintain backups of original EAs
2. **Comment Your Code:** Add comments explaining integration points
3. **Version Control:** Track changes as you integrate each strategy
4. **Test Incrementally:** Add and test one strategy at a time
5. **Document Behavior:** Note any behavior differences from original EAs
6. **Validate Logic:** Ensure entry/exit conditions are preserved exactly
7. **Risk Management:** Test with small lot sizes first
8. **Parameter Defaults:** Use conservative defaults that worked in original EAs

## Verification Template

For each strategy, complete this checklist:

```
Strategy #: ___
Original EA Name: _______________

✓ Parameters copied and renamed
✓ Global variables identified and renamed
✓ Init code integrated
✓ Main logic integrated into ExecuteStrategy#()
✓ Helper functions integrated
✓ Indicator calls updated
✓ Magic number assigned
✓ Trade functions updated
✓ Compilation successful
✓ Logic tested and verified
✓ Matches original EA behavior

Notes:
___________________________________
___________________________________
```

## Next Steps

Once integration is complete:
1. Document any deviations from original EAs
2. Create user manual with parameter descriptions
3. Test thoroughly in demo account
4. Monitor performance of each strategy
5. Keep original EAs for reference

## Support

For questions or issues during integration, refer to:
- MQL4 Documentation: https://docs.mql4.com/
- MQL4 Community: https://www.mql5.com/en/forum
- This project's repository: https://github.com/Jacksondias/BasketFX
