# BasketFX - Unified Expert Advisor

## Purpose
This project aims to unify 9 separate Expert Advisor (EA) MQ4 files into a single MQ4 file that can be compiled into one .ex4 file for MetaTrader 4.

## Current Status
⚠️ **AWAITING INPUT FILES**

To complete this unification, please upload the following files to this repository:

1. **9 MQ4 files** - The individual Expert Advisors to be unified
2. **1 TXT file** - Documentation explaining how the Expert Advisor functions

## Next Steps

Once the files are provided, the unified EA will include:

### 1. Strategy Selection System
- Individual enable/disable switches for each of the 9 strategies
- Master enable/disable switch
- Strategy naming and identification

### 2. Configurable Parameters
Each strategy will have its own set of configurable parameters:
- Lot sizes
- Stop loss and take profit levels
- Indicator parameters
- Entry/exit rules
- Risk management settings
- Time filters

### 3. Unified Architecture
The unified EA will follow this structure:
```
UnifiedBasketFX.mq4
├── Global Parameters
│   ├── Strategy 1 Parameters
│   ├── Strategy 2 Parameters
│   ├── ...
│   └── Strategy 9 Parameters
├── Global Variables
├── OnInit() - Initialization
├── OnDeinit() - Cleanup
├── OnTick() - Main execution
│   ├── Strategy 1 Logic
│   ├── Strategy 2 Logic
│   ├── ...
│   └── Strategy 9 Logic
└── Helper Functions
    ├── Trade Management
    ├── Risk Calculation
    ├── Order Handling
    └── Utilities
```

### 4. Features to Include
- Individual strategy monitoring
- Consolidated position management
- Unified risk management
- Performance tracking per strategy
- Error handling and logging
- Magic number management for each strategy

## How to Use After Unification

1. Place the unified MQ4 file in MetaTrader 4's `Experts` folder
2. Compile it using MetaEditor (F7)
3. Attach the resulting .ex4 file to a chart
4. Configure parameters in the EA properties dialog
5. Enable/disable specific strategies as needed

## Files to Upload

Please add your files to the repository:
```
/BasketFX
├── strategy1.mq4 (or your actual filename)
├── strategy2.mq4
├── strategy3.mq4
├── strategy4.mq4
├── strategy5.mq4
├── strategy6.mq4
├── strategy7.mq4
├── strategy8.mq4
├── strategy9.mq4
└── documentation.txt (description of the EA functionality)
```

## Questions to Consider

When providing the files, please also consider:
1. Should all strategies trade on the same chart/symbol or different ones?
2. Should there be a master risk management system across all strategies?
3. Are there dependencies between strategies?
4. Should strategies be able to run simultaneously or in sequence?
5. Are there any common functions/code shared across the EAs?
