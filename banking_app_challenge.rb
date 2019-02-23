require 'date'
class Account

    # initializes balance and password
    # PASSWORD constant 
    #
    def initialize(balance, password)
        @balance = balance
        @password = password
        #Format: {account number => array[balance, password, history]}
        @account_data = nil
    end

        # Handles majority of input and output
        #
        def main_menu
            options = ["Balance", "Deposit", "Withdraw", "History", "Quit"]
            quit = false
            while !quit
                puts "Welcome to the banking app. What would you like to do?"
                options.each do |item|
                    puts " #{item}"
                end
                seperate_block
                input = gets.chomp.downcase
                write_history(input)
                if input == "balance" 
                    print_balance

                elsif input == "deposit"
                    deposit

                elsif input == "withdraw"
                    withdraw

                elsif input == "history"
                    print_history

                elsif input == "quit"
                    save_data()
                    quit = true
                else
                    puts "invalid input."
                end
            end
        end

        #checks to see if the input is a valid number (>0 && is Numeric)
        #
        def is_valid_number(input)
            raise "Not a valid number. Please enter a number greater than 0.0, making sure to not include any letters or symbols."  unless input.to_f.is_a? Numeric
        end

        # Gather input > sends to isValidNumber > updates @balance (+)
        #
        def deposit
            puts "How much would you like to deposit?"
            input = gets.chomp 
            write_history(input)
            is_valid_number(input)
            @balance += input.to_f
            print_balance
        end

        # Gather input > sends to is_valid_number > updates @balance (-)
        #
        def withdraw
            puts "How much would you like to withdraw?"
            input = gets.chomp
            write_history(input)
            is_valid_number(input)
            @balance -= input.to_f
            print_balance
        end

        #
        #
        def write_history(to_write)
            file_ref = File.new('out.txt', "a")
            file_ref.write(to_write + " " + DateTime.now.strftime("%d/%m/%Y %H:%M") + "\n")
            file_ref.close
        end

        #
        #
        def print_history
            file_ref = File.new('out.txt', "r")
            file_ref.each_line do |line|
                puts line
            end
            file_ref.close
            seperate_block
            puts "ANY KEY to move on"
            if gets.chomp
                clear_screen
            end
        end

        #
        #
        def print_balance
            puts "Your balance is: $#{sprintf('%.2f', @balance)}"
            seperate_block
            puts "ANY KEY to move on"
            if gets.chomp
                clear_screen
            end
        end

        #
        #
        def verify_password(pass, user)
            if pass == @password
            seperate_block
                return true
            else
                return false
            end
        end

        def seperate_block
            puts "----------------------------------------------------------------------"
        end

        def clear_screen
            system("clear")
        end

        def log_in
            puts "ACCOUNT NUMBER: "
            user = gets.chomp.downcase
            puts "PASSWORD: "
            pass = gets.chomp
            if verify_password(pass, user)
                clear_screen
                main_menu
            end
        end

        def save_data
            ##content##
        end

end # end of class

#
r = Account.new(0.0, "password")
#
r.log_in
