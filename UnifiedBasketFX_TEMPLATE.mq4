//+------------------------------------------------------------------+
//|                                         UnifiedBasketFX.mq4      |
//|                                      Template for Unified EA     |
//|                        Combines 9 Expert Advisors into one       |
//+------------------------------------------------------------------+
#property copyright "BasketFX Unified EA"
#property link      "https://github.com/Jacksondias/BasketFX"
#property version   "1.00"
#property strict

//+------------------------------------------------------------------+
//| GLOBAL STRATEGY CONTROLS                                          |
//+------------------------------------------------------------------+
input string    Separator1 = "=== MASTER CONTROLS ===";        // ================
input bool      EnableEA = true;                                // Enable Master EA
input bool      TradeOnNewBarOnly = true;                       // Trade on New Bar Only
input int       MagicNumberBase = 10000;                        // Magic Number Base (each strategy adds 1-9)

//+------------------------------------------------------------------+
//| STRATEGY 1 PARAMETERS                                             |
//+------------------------------------------------------------------+
input string    Separator2 = "=== STRATEGY 1 ===";              // ================
input bool      Enable_Strategy1 = true;                         // Enable Strategy 1
input double    Lot_Strategy1 = 0.01;                           // Lot Size Strategy 1
input int       StopLoss_Strategy1 = 50;                        // Stop Loss (pips) Strategy 1
input int       TakeProfit_Strategy1 = 100;                     // Take Profit (pips) Strategy 1
input int       Param1_Strategy1 = 14;                          // Parameter 1 Strategy 1
input int       Param2_Strategy1 = 20;                          // Parameter 2 Strategy 1

//+------------------------------------------------------------------+
//| STRATEGY 2 PARAMETERS                                             |
//+------------------------------------------------------------------+
input string    Separator3 = "=== STRATEGY 2 ===";              // ================
input bool      Enable_Strategy2 = true;                         // Enable Strategy 2
input double    Lot_Strategy2 = 0.01;                           // Lot Size Strategy 2
input int       StopLoss_Strategy2 = 50;                        // Stop Loss (pips) Strategy 2
input int       TakeProfit_Strategy2 = 100;                     // Take Profit (pips) Strategy 2
input int       Param1_Strategy2 = 14;                          // Parameter 1 Strategy 2
input int       Param2_Strategy2 = 20;                          // Parameter 2 Strategy 2

//+------------------------------------------------------------------+
//| STRATEGY 3 PARAMETERS                                             |
//+------------------------------------------------------------------+
input string    Separator4 = "=== STRATEGY 3 ===";              // ================
input bool      Enable_Strategy3 = true;                         // Enable Strategy 3
input double    Lot_Strategy3 = 0.01;                           // Lot Size Strategy 3
input int       StopLoss_Strategy3 = 50;                        // Stop Loss (pips) Strategy 3
input int       TakeProfit_Strategy3 = 100;                     // Take Profit (pips) Strategy 3
input int       Param1_Strategy3 = 14;                          // Parameter 1 Strategy 3
input int       Param2_Strategy3 = 20;                          // Parameter 2 Strategy 3

//+------------------------------------------------------------------+
//| STRATEGY 4 PARAMETERS                                             |
//+------------------------------------------------------------------+
input string    Separator5 = "=== STRATEGY 4 ===";              // ================
input bool      Enable_Strategy4 = true;                         // Enable Strategy 4
input double    Lot_Strategy4 = 0.01;                           // Lot Size Strategy 4
input int       StopLoss_Strategy4 = 50;                        // Stop Loss (pips) Strategy 4
input int       TakeProfit_Strategy4 = 100;                     // Take Profit (pips) Strategy 4
input int       Param1_Strategy4 = 14;                          // Parameter 1 Strategy 4
input int       Param2_Strategy4 = 20;                          // Parameter 2 Strategy 4

//+------------------------------------------------------------------+
//| STRATEGY 5 PARAMETERS                                             |
//+------------------------------------------------------------------+
input string    Separator6 = "=== STRATEGY 5 ===";              // ================
input bool      Enable_Strategy5 = true;                         // Enable Strategy 5
input double    Lot_Strategy5 = 0.01;                           // Lot Size Strategy 5
input int       StopLoss_Strategy5 = 50;                        // Stop Loss (pips) Strategy 5
input int       TakeProfit_Strategy5 = 100;                     // Take Profit (pips) Strategy 5
input int       Param1_Strategy5 = 14;                          // Parameter 1 Strategy 5
input int       Param2_Strategy5 = 20;                          // Parameter 2 Strategy 5

//+------------------------------------------------------------------+
//| STRATEGY 6 PARAMETERS                                             |
//+------------------------------------------------------------------+
input string    Separator7 = "=== STRATEGY 6 ===";              // ================
input bool      Enable_Strategy6 = true;                         // Enable Strategy 6
input double    Lot_Strategy6 = 0.01;                           // Lot Size Strategy 6
input int       StopLoss_Strategy6 = 50;                        // Stop Loss (pips) Strategy 6
input int       TakeProfit_Strategy6 = 100;                     // Take Profit (pips) Strategy 6
input int       Param1_Strategy6 = 14;                          // Parameter 1 Strategy 6
input int       Param2_Strategy6 = 20;                          // Parameter 2 Strategy 6

//+------------------------------------------------------------------+
//| STRATEGY 7 PARAMETERS                                             |
//+------------------------------------------------------------------+
input string    Separator8 = "=== STRATEGY 7 ===";              // ================
input bool      Enable_Strategy7 = true;                         // Enable Strategy 7
input double    Lot_Strategy7 = 0.01;                           // Lot Size Strategy 7
input int       StopLoss_Strategy7 = 50;                        // Stop Loss (pips) Strategy 7
input int       TakeProfit_Strategy7 = 100;                     // Take Profit (pips) Strategy 7
input int       Param1_Strategy7 = 14;                          // Parameter 1 Strategy 7
input int       Param2_Strategy7 = 20;                          // Parameter 2 Strategy 7

//+------------------------------------------------------------------+
//| STRATEGY 8 PARAMETERS                                             |
//+------------------------------------------------------------------+
input string    Separator9 = "=== STRATEGY 8 ===";              // ================
input bool      Enable_Strategy8 = true;                         // Enable Strategy 8
input double    Lot_Strategy8 = 0.01;                           // Lot Size Strategy 8
input int       StopLoss_Strategy8 = 50;                        // Stop Loss (pips) Strategy 8
input int       TakeProfit_Strategy8 = 100;                     // Take Profit (pips) Strategy 8
input int       Param1_Strategy8 = 14;                          // Parameter 1 Strategy 8
input int       Param2_Strategy8 = 20;                          // Parameter 2 Strategy 8

//+------------------------------------------------------------------+
//| STRATEGY 9 PARAMETERS                                             |
//+------------------------------------------------------------------+
input string    Separator10 = "=== STRATEGY 9 ===";             // ================
input bool      Enable_Strategy9 = true;                         // Enable Strategy 9
input double    Lot_Strategy9 = 0.01;                           // Lot Size Strategy 9
input int       StopLoss_Strategy9 = 50;                        // Stop Loss (pips) Strategy 9
input int       TakeProfit_Strategy9 = 100;                     // Take Profit (pips) Strategy 9
input int       Param1_Strategy9 = 14;                          // Parameter 1 Strategy 9
input int       Param2_Strategy9 = 20;                          // Parameter 2 Strategy 9

//+------------------------------------------------------------------+
//| RISK MANAGEMENT                                                   |
//+------------------------------------------------------------------+
input string    Separator11 = "=== RISK MANAGEMENT ===";        // ================
input double    MaxRiskPercent = 2.0;                           // Max Risk Per Trade (%)
input double    MaxDailyLoss = 500.0;                           // Max Daily Loss ($)
input int       MaxOpenTrades = 10;                             // Max Open Trades (Total)
input int       MaxTradesPerStrategy = 3;                       // Max Trades Per Strategy

//+------------------------------------------------------------------+
//| GLOBAL VARIABLES                                                  |
//+------------------------------------------------------------------+
datetime LastBarTime = 0;
double   DailyPL = 0.0;
datetime LastDayChecked = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                    |
//+------------------------------------------------------------------+
int OnInit()
{
   Print("UnifiedBasketFX EA Initialized");
   Print("Master EA Enabled: ", EnableEA);
   Print("Strategies Enabled: S1:", Enable_Strategy1, " S2:", Enable_Strategy2, 
         " S3:", Enable_Strategy3, " S4:", Enable_Strategy4, " S5:", Enable_Strategy5,
         " S6:", Enable_Strategy6, " S7:", Enable_Strategy7, " S8:", Enable_Strategy8,
         " S9:", Enable_Strategy9);
   
   // Initialize variables
   LastBarTime = Time[0];
   ResetDailyPL();
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Print("UnifiedBasketFX EA Deinitialized. Reason: ", reason);
}

//+------------------------------------------------------------------+
//| Expert tick function                                              |
//+------------------------------------------------------------------+
void OnTick()
{
   // Check if EA is enabled
   if(!EnableEA) return;
   
   // Check for new bar if required
   if(TradeOnNewBarOnly && !IsNewBar()) return;
   
   // Update daily P&L
   UpdateDailyPL();
   
   // Check risk limits
   if(!CheckRiskLimits()) return;
   
   // Execute each enabled strategy
   if(Enable_Strategy1) ExecuteStrategy1();
   if(Enable_Strategy2) ExecuteStrategy2();
   if(Enable_Strategy3) ExecuteStrategy3();
   if(Enable_Strategy4) ExecuteStrategy4();
   if(Enable_Strategy5) ExecuteStrategy5();
   if(Enable_Strategy6) ExecuteStrategy6();
   if(Enable_Strategy7) ExecuteStrategy7();
   if(Enable_Strategy8) ExecuteStrategy8();
   if(Enable_Strategy9) ExecuteStrategy9();
}

//+------------------------------------------------------------------+
//| Check if new bar has formed                                       |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   if(Time[0] != LastBarTime)
   {
      LastBarTime = Time[0];
      return true;
   }
   return false;
}

//+------------------------------------------------------------------+
//| Check risk management limits                                      |
//+------------------------------------------------------------------+
bool CheckRiskLimits()
{
   // Check daily loss limit
   if(MaxDailyLoss > 0 && DailyPL < -MaxDailyLoss)
   {
      Comment("Daily loss limit reached: $", DoubleToString(DailyPL, 2));
      return false;
   }
   
   // Check max open trades
   int totalTrades = CountOpenTrades(0); // 0 = all strategies
   if(totalTrades >= MaxOpenTrades)
   {
      return false;
   }
   
   return true;
}

//+------------------------------------------------------------------+
//| Count open trades for a specific strategy (0 = all)              |
//+------------------------------------------------------------------+
int CountOpenTrades(int strategyNumber)
{
   int count = 0;
   int magicStart = MagicNumberBase + strategyNumber;
   int magicEnd = (strategyNumber == 0) ? MagicNumberBase + 9 : magicStart;
   
   for(int i = 0; i < OrdersTotal(); i++)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      {
         if(OrderSymbol() == Symbol())
         {
            int orderMagic = OrderMagicNumber();
            if(strategyNumber == 0)
            {
               if(orderMagic >= MagicNumberBase + 1 && orderMagic <= MagicNumberBase + 9)
                  count++;
            }
            else
            {
               if(orderMagic == magicStart)
                  count++;
            }
         }
      }
   }
   return count;
}

//+------------------------------------------------------------------+
//| Update daily P&L                                                  |
//+------------------------------------------------------------------+
void UpdateDailyPL()
{
   datetime today = iTime(Symbol(), PERIOD_D1, 0);
   if(today != LastDayChecked)
   {
      ResetDailyPL();
      LastDayChecked = today;
   }
   
   // Calculate current daily P&L
   DailyPL = 0;
   for(int i = 0; i < OrdersTotal(); i++)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      {
         if(OrderSymbol() == Symbol() && 
            OrderMagicNumber() >= MagicNumberBase + 1 && 
            OrderMagicNumber() <= MagicNumberBase + 9)
         {
            DailyPL += OrderProfit() + OrderSwap() + OrderCommission();
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Reset daily P&L                                                   |
//+------------------------------------------------------------------+
void ResetDailyPL()
{
   DailyPL = 0.0;
   LastDayChecked = iTime(Symbol(), PERIOD_D1, 0);
}

//+------------------------------------------------------------------+
//| Calculate lot size based on risk                                  |
//+------------------------------------------------------------------+
double CalculateLotSize(double riskPercent, int stopLossPips)
{
   if(stopLossPips <= 0) return 0.01;
   
   double tickValue = MarketInfo(Symbol(), MODE_TICKVALUE);
   double tickSize = MarketInfo(Symbol(), MODE_TICKSIZE);
   double lotStep = MarketInfo(Symbol(), MODE_LOTSTEP);
   double minLot = MarketInfo(Symbol(), MODE_MINLOT);
   double maxLot = MarketInfo(Symbol(), MODE_MAXLOT);
   
   double riskAmount = AccountBalance() * riskPercent / 100.0;
   double slAmount = stopLossPips * Point * 10; // Convert pips to price
   double lots = riskAmount / (slAmount / tickSize * tickValue);
   
   // Round to lot step
   lots = MathFloor(lots / lotStep) * lotStep;
   
   // Enforce limits
   if(lots < minLot) lots = minLot;
   if(lots > maxLot) lots = maxLot;
   
   return lots;
}

//+------------------------------------------------------------------+
//| STRATEGY 1 EXECUTION                                              |
//+------------------------------------------------------------------+
void ExecuteStrategy1()
{
   int magic = MagicNumberBase + 1;
   
   // Check if strategy can open more trades
   if(CountOpenTrades(1) >= MaxTradesPerStrategy) return;
   
   // TODO: Replace with actual Strategy 1 logic
   // This is a placeholder example
   
   // Example: Simple MA crossover
   // double ma1 = iMA(Symbol(), 0, Param1_Strategy1, 0, MODE_SMA, PRICE_CLOSE, 0);
   // double ma2 = iMA(Symbol(), 0, Param2_Strategy1, 0, MODE_SMA, PRICE_CLOSE, 0);
   // if(ma1 > ma2) OpenTrade(OP_BUY, Lot_Strategy1, StopLoss_Strategy1, TakeProfit_Strategy1, magic);
   // if(ma1 < ma2) OpenTrade(OP_SELL, Lot_Strategy1, StopLoss_Strategy1, TakeProfit_Strategy1, magic);
}

//+------------------------------------------------------------------+
//| STRATEGY 2 EXECUTION                                              |
//+------------------------------------------------------------------+
void ExecuteStrategy2()
{
   int magic = MagicNumberBase + 2;
   if(CountOpenTrades(2) >= MaxTradesPerStrategy) return;
   // TODO: Add Strategy 2 logic
}

//+------------------------------------------------------------------+
//| STRATEGY 3 EXECUTION                                              |
//+------------------------------------------------------------------+
void ExecuteStrategy3()
{
   int magic = MagicNumberBase + 3;
   if(CountOpenTrades(3) >= MaxTradesPerStrategy) return;
   // TODO: Add Strategy 3 logic
}

//+------------------------------------------------------------------+
//| STRATEGY 4 EXECUTION                                              |
//+------------------------------------------------------------------+
void ExecuteStrategy4()
{
   int magic = MagicNumberBase + 4;
   if(CountOpenTrades(4) >= MaxTradesPerStrategy) return;
   // TODO: Add Strategy 4 logic
}

//+------------------------------------------------------------------+
//| STRATEGY 5 EXECUTION                                              |
//+------------------------------------------------------------------+
void ExecuteStrategy5()
{
   int magic = MagicNumberBase + 5;
   if(CountOpenTrades(5) >= MaxTradesPerStrategy) return;
   // TODO: Add Strategy 5 logic
}

//+------------------------------------------------------------------+
//| STRATEGY 6 EXECUTION                                              |
//+------------------------------------------------------------------+
void ExecuteStrategy6()
{
   int magic = MagicNumberBase + 6;
   if(CountOpenTrades(6) >= MaxTradesPerStrategy) return;
   // TODO: Add Strategy 6 logic
}

//+------------------------------------------------------------------+
//| STRATEGY 7 EXECUTION                                              |
//+------------------------------------------------------------------+
void ExecuteStrategy7()
{
   int magic = MagicNumberBase + 7;
   if(CountOpenTrades(7) >= MaxTradesPerStrategy) return;
   // TODO: Add Strategy 7 logic
}

//+------------------------------------------------------------------+
//| STRATEGY 8 EXECUTION                                              |
//+------------------------------------------------------------------+
void ExecuteStrategy8()
{
   int magic = MagicNumberBase + 8;
   if(CountOpenTrades(8) >= MaxTradesPerStrategy) return;
   // TODO: Add Strategy 8 logic
}

//+------------------------------------------------------------------+
//| STRATEGY 9 EXECUTION                                              |
//+------------------------------------------------------------------+
void ExecuteStrategy9()
{
   int magic = MagicNumberBase + 9;
   if(CountOpenTrades(9) >= MaxTradesPerStrategy) return;
   // TODO: Add Strategy 9 logic
}

//+------------------------------------------------------------------+
//| Open a trade with specified parameters                            |
//+------------------------------------------------------------------+
bool OpenTrade(int type, double lots, int slPips, int tpPips, int magic)
{
   double price, sl, tp;
   string orderComment = "UnifiedBasketFX-S" + IntegerToString(magic - MagicNumberBase);
   
   // Calculate price
   if(type == OP_BUY)
   {
      price = Ask;
      if(slPips > 0) sl = price - slPips * Point * 10;
      else sl = 0;
      if(tpPips > 0) tp = price + tpPips * Point * 10;
      else tp = 0;
   }
   else // OP_SELL
   {
      price = Bid;
      if(slPips > 0) sl = price + slPips * Point * 10;
      else sl = 0;
      if(tpPips > 0) tp = price - tpPips * Point * 10;
      else tp = 0;
   }
   
   // Open order
   int ticket = OrderSend(Symbol(), type, lots, price, 3, sl, tp, orderComment, magic, 0, clrNONE);
   
   if(ticket > 0)
   {
      Print("Order opened successfully. Ticket: ", ticket);
      return true;
   }
   else
   {
      Print("Order failed. Error: ", GetLastError());
      return false;
   }
}

//+------------------------------------------------------------------+
//| Close trades for a specific strategy                              |
//+------------------------------------------------------------------+
void CloseStrategyTrades(int strategyNumber)
{
   int magic = MagicNumberBase + strategyNumber;
   
   for(int i = OrdersTotal() - 1; i >= 0; i--)
   {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      {
         if(OrderSymbol() == Symbol() && OrderMagicNumber() == magic)
         {
            if(OrderType() == OP_BUY)
               OrderClose(OrderTicket(), OrderLots(), Bid, 3, clrNONE);
            else if(OrderType() == OP_SELL)
               OrderClose(OrderTicket(), OrderLots(), Ask, 3, clrNONE);
         }
      }
   }
}
//+------------------------------------------------------------------+
