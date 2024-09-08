import random

class Settings(): ## Settings
    def __init__(self):
        self.AlwaysWin = False
        self.StartingBalance = 3000
        self.pickNum = 100      ## Possible winning numbers
        self.MultiPower = 1   ## Multiplyer Power
        
settings = Settings()

balance = settings.StartingBalance
fontBal = f'{balance:,}'

mul = [2, 4, 8, 12]
weights = [0.8, 0.6, 0.4, 0.2]

def gamble(bet):
    multiplyer = random.choices(mul, weights=weights, k=1)[0] * settings.MultiPower
    winning_number = random.randint(1,settings.pickNum)
    global balance
    global fontBal

    while True:
        try:
            choice = int(input(f"Please pick a number 1-{settings.pickNum}.\n"))
            if not settings.AlwaysWin:
                if choice >= 1 and choice <= settings.pickNum:
                    break
                else:
                    print("Invalid Number.")
            else:
                choice = winning_number
                break
        except ValueError:
            print("Invalid Number.")
        
    print(f"You picked: {choice}, Winning Number:{winning_number}.")
    
    if choice == winning_number:
            print(f"You won a {multiplyer}x multiplyer!")
            balance = balance + (bet * multiplyer)
    else:
        print(f"You lost ${f'{bet:,}'}")
        balance = balance - bet
        
    fontBal = f'{balance:,}'
    print(f"Your balance is now ${fontBal}")

while True:
    option = input("Input menu selection, H for help.")
    
    if option in ['G','g']:
        while True:
            gamBet = input("How much would you like to bet? Or Q to quit.\n")
            if gamBet in ['M','m']:
                gamBet = balance
                gamble(gamBet)
            elif gamBet in ['Q','q']:
                break
            elif int(gamBet) <= balance:
                gamBet = int(gamBet)
                gamble(gamBet)
            else:
                print(f"Invalid Bet, you only have ${fontBal}!")
    elif option in ['H','h']:
        print("""
            H -- Help/Commands
            G -- Gamble
            R -- Reset
            B -- Balance
            """)
    elif option in ['R','r']:
        balance = settings.StartingBalance
        fontBal = f'{balance:,}'
        print(f"Balance is now ${fontBal}.")
    elif option in ['B', 'b']:
        fontBal = f'{balance:,}'
        print(f'Your balance is ${fontBal}')
    elif option == 'admin':
        while True:
            print("""
            C - Change initial balance
            W - toggle AlwaysWin
            B - Back
            """)
            adminCommand = input('')
            if adminCommand in ['C','c']:
                try:
                    newbal = int(input('Enter new balance\n'))
                    settings.StartingBalance = newbal
                    balance = newbal
                    fontBal = f'{balance:,}'
                    print(f"balance is now ${fontBal}")
                except ValueError:
                    print("invalid number")
            elif adminCommand in ['W','w']:
                if settings.AlwaysWin == True:
                    settings.AlwaysWin = False
                    print('AlwaysWin has been toggled to False.')
                elif settings.AlwaysWin == False:
                    settings.AlwaysWin = True
                    print('AlwaysWin has been toggled to True.')
            elif adminCommand in ['B','b']:
                break