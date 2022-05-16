import pandas 
import numpy as np
import matplotlib.pyplot as plt


#load csv file
file=pandas.read_csv('wig20.csv')

#plot Data and Close columns
plt.figure(figsize=(12,7))
plt.plot(file["Data"],file["Zamkniecie"],label="Close")

#setting the plot
plt.title('Close price history')
plt.xlabel('Date')
plt.ylabel('Price [PLN]',labelpad=7)
plt.xticks(np.arange(0,len(file),step=len(file)//10),rotation=45)
plt.show()


#Calculating short and long EMA
ema12=file["Zamkniecie"].ewm(span=12,adjust=False).mean()
ema26=file["Zamkniecie"].ewm(span=26,adjust=False).mean()

#Calculating MACD and signal
MACD=ema12-ema26
signal=MACD.ewm(span=9,adjust=False).mean()

#plot MACD and signal
plt.figure(figsize=(12,7))
plt.title('MACD and signal')
plt.plot(file['Data'],MACD,label="WIG_20 MACD",color="blue")
plt.plot(file['Data'],signal,label="Signal",color="red")
plt.xticks(np.arange(0,len(file),step=len(file)//10),rotation=45)
plt.legend(loc="lower right")
plt.xlabel('Date')
plt.show()

#creating new columns for calculation
file["MACD"]=MACD
file["signal"]=signal



#function that interprets MACD and SIGNAL plot and decides when to buy and sell stock, writes data into loaded table
def Buy_Sell(signal):
    buy=[]
    sell=[]
    flag=-1

    for i in range(0,len(signal)):
        #MACD > signal
        if signal["MACD"][i] > signal["signal"][i]:
            sell.append(np.nan)
            if flag!=1:
                buy.append(signal["Zamkniecie"][i])
                flag=1
            else:
                buy.append(np.nan)
        #MACD < signal
        elif signal["MACD"][i] < signal["signal"][i]:
            buy.append(np.nan)
            if flag!=0:
                sell.append(signal["Zamkniecie"][i])
                flag=0
            else:
                sell.append(np.nan)
        #MACD=signal
        else:
            buy.append(np.nan)
            sell.append(np.nan)

    return(buy,sell)



decision=Buy_Sell(file)
file["Signal_Buy"]=decision[0]
file["Signal_Sell"]=decision[1]



#plot showing when to buy and sell stock on stock price plot
plt.figure(figsize=(12,7))
plt.title('When to buy and sell')

plt.scatter(file["Data"],file["Signal_Buy"],color="green",label="Buy",marker="^",alpha=1)
plt.scatter(file["Data"],file["Signal_Sell"],color="black",label="Sell",marker="v",alpha=1)

plt.plot(file["Zamkniecie"], label="Close price",alpha=0.4)
plt.xticks(np.arange(0,len(file),step=len(file)//10),rotation=45)
plt.legend(loc="lower right")

plt.xlabel('Date')
plt.ylabel('Price [PLN]',labelpad=7)
plt.show()

print(file)

#starting balance for MACD test using last 1000 records from wig20 stock
starting_balance=10000

print()

#buying and selling stocks using MACD strategy
def start_MACD(signal, starting_balance):
    balance=starting_balance
    stocks=0
    for i in range(0,len(signal)-1):
        #to buy
        if not np.isnan(signal["Signal_Buy"][i]) and balance-signal["Signal_Buy"][i]>0:
            amount=balance//signal["Signal_Buy"][i]
            stocks+=amount
            balance-=amount*signal["Signal_Buy"][i]

        #to sell
        elif not np.isnan(signal["Signal_Sell"][i]) and stocks>0:
            balance+=stocks*signal["Signal_Sell"][i]
            stocks=0
        if i%100==0 and i!=0:
            print("Majątek po",i,"dniach:",round(balance+stocks*signal["Zamkniecie"][i],2))

    if(stocks>0):
        balance+=stocks*signal["Zamkniecie"][len(signal)-1]
        stocks=0

    #results using MACD strategy
    print()
    print("Wyniki użycia strategii MACD: ")
    print("Kapitał początkowy: ",starting_balance)
    print("Kapitał po wykorzystaniu MACD przez",len(signal)-1,"dni: ",round(balance,2))
    print("Różnica bezwględna: ",round(balance-starting_balance,2))
    print("Różnica w %: ",round(balance-starting_balance,2)/starting_balance*100,"%")
    print()

    
start_MACD(file,starting_balance)


