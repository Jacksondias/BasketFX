# File Upload Guide

## Required Files

To complete the unification of Expert Advisors, please upload the following files to this repository:

### 1. MQ4 Files (9 files required)

Upload your 9 Expert Advisor MQ4 files. You can organize them in a folder structure like:

```
/BasketFX
├── source_files/
│   ├── EA1_OriginalName.mq4
│   ├── EA2_OriginalName.mq4
│   ├── EA3_OriginalName.mq4
│   ├── EA4_OriginalName.mq4
│   ├── EA5_OriginalName.mq4
│   ├── EA6_OriginalName.mq4
│   ├── EA7_OriginalName.mq4
│   ├── EA8_OriginalName.mq4
│   └── EA9_OriginalName.mq4
└── documentation.txt
```

**OR** simply upload them directly to the root:

```
/BasketFX
├── EA1_OriginalName.mq4
├── EA2_OriginalName.mq4
├── EA3_OriginalName.mq4
├── EA4_OriginalName.mq4
├── EA5_OriginalName.mq4
├── EA6_OriginalName.mq4
├── EA7_OriginalName.mq4
├── EA8_OriginalName.mq4
├── EA9_OriginalName.mq4
└── documentation.txt
```

### 2. Documentation File (1 file required)

Upload a TXT file (or any text format) that contains:
- Description of what each EA does
- Trading strategy explanation
- Original parameter meanings
- Any special requirements or dependencies
- Expected behavior
- Any known limitations

**Example filename:** `documentation.txt` or `EA_Description.txt`

## How to Upload Files to GitHub

### Method 1: Via GitHub Web Interface

1. Go to https://github.com/Jacksondias/BasketFX
2. Click on "Add file" → "Upload files"
3. Drag and drop your files or click "choose your files"
4. Add a commit message (e.g., "Add 9 EA files and documentation")
5. Click "Commit changes"

### Method 2: Via Git Command Line

```bash
# Clone the repository if you haven't
git clone https://github.com/Jacksondias/BasketFX.git
cd BasketFX

# Create a directory for source files (optional)
mkdir source_files

# Copy your files to the repository
cp /path/to/your/EA1.mq4 source_files/
cp /path/to/your/EA2.mq4 source_files/
# ... copy all 9 files
cp /path/to/your/documentation.txt .

# Add files to git
git add .

# Commit the changes
git commit -m "Add 9 EA source files and documentation"

# Push to GitHub
git push origin main
```

### Method 3: Via GitHub Desktop

1. Open GitHub Desktop
2. Clone the repository
3. Copy your files into the repository folder
4. GitHub Desktop will detect the changes
5. Add a commit message
6. Click "Commit to main"
7. Click "Push origin"

## File Naming Recommendations

Please name your files descriptively:
- ✅ Good: `MovingAverage_CrossOver_EA.mq4`
- ✅ Good: `RSI_Strategy_v2.mq4`
- ✅ Good: `Breakout_Trading_EA.mq4`
- ❌ Avoid: `EA1.mq4`, `test.mq4`, `untitled.mq4`

This helps in understanding what each strategy does.

## Additional Files (If Any)

If your EAs depend on other files, please also include:

- **Include files (.mqh):** Place in `/include/` folder
- **Custom indicators (.mq4 or .ex4):** Place in `/indicators/` folder
- **Libraries (.dll or .ex4):** Place in `/libraries/` folder
- **Configuration files (.set):** Place in `/config/` folder

Example structure:
```
/BasketFX
├── source_files/
│   ├── EA1.mq4
│   └── ...
├── include/
│   └── CustomLibrary.mqh
├── indicators/
│   └── CustomIndicator.mq4
└── libraries/
    └── TradingLib.ex4
```

## Information to Include in Documentation

Please include the following details in your documentation file:

### For Each EA:

1. **Name/Identifier**
   - What is this EA called?
   - What is its version?

2. **Strategy Description**
   - What trading strategy does it implement?
   - What are the entry conditions?
   - What are the exit conditions?

3. **Indicators Used**
   - Which technical indicators does it use?
   - What are the indicator parameters?

4. **Timeframes**
   - Which timeframe(s) does it work on?
   - Can it work on multiple timeframes?

5. **Risk Management**
   - How does it calculate lot sizes?
   - What are the stop loss/take profit rules?

6. **Parameters**
   - List all configurable parameters
   - Explain what each parameter does
   - Recommended ranges for each parameter

7. **Dependencies**
   - Does it require custom indicators?
   - Does it use any external libraries?
   - Any special MetaTrader settings needed?

8. **Trading Hours**
   - Does it trade 24/7?
   - Any time restrictions?
   - Any day-of-week restrictions?

9. **Special Notes**
   - Any known bugs or limitations?
   - Recommended symbol(s)?
   - Recommended account type (standard, ECN, etc.)?

### Example Documentation Format:

```
===========================================
EA #1: Moving Average Crossover Strategy
===========================================

Strategy: Buys when fast MA crosses above slow MA, sells when it crosses below
Entry: MA(10) crosses MA(20)
Exit: Opposite signal or stop loss/take profit
Indicators: 2x Moving Average (Simple)
Timeframe: H1 (can work on any)
Lot Size: Fixed lot or percentage of balance
Stop Loss: 50 pips
Take Profit: 100 pips

Parameters:
- FastMA: 10 (range: 5-50)
- SlowMA: 20 (range: 10-200)
- LotSize: 0.01 (range: 0.01-10)
- StopLoss: 50 pips
- TakeProfit: 100 pips

Dependencies: None
Special Notes: Works best on major pairs during London/NY session

===========================================
EA #2: RSI Oversold/Overbought Strategy
===========================================
... (repeat for all 9 EAs)
```

## Verification Checklist

Before uploading, verify:
- [ ] All 9 MQ4 files are ready
- [ ] Documentation file is complete
- [ ] Files are named descriptively
- [ ] Any dependent files (indicators, libraries) are included
- [ ] All files are in the correct format (.mq4, not .ex4)
- [ ] Documentation covers all 9 EAs

## What Happens Next?

Once you upload the files:
1. The integration process will begin
2. Each EA will be analyzed
3. All strategies will be merged into `UnifiedBasketFX.mq4`
4. Parameters will be configured for easy setup
5. The unified EA will be tested for compilation
6. Documentation will be updated with usage instructions

## Questions?

If you have any questions about what files to upload or how to prepare them, please:
1. Open an issue in this repository
2. Provide as much detail as possible
3. Include screenshots if helpful

## Timeline

Expected timeline after files are uploaded:
- Analysis of files: 1-2 hours
- Integration of strategies: 2-4 hours
- Testing and verification: 1-2 hours
- Documentation: 1 hour

Total estimated time: 5-9 hours

The actual time may vary depending on:
- Complexity of each EA
- Number of custom indicators/libraries
- Conflicts between strategies
- Testing requirements
