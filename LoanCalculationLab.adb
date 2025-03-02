with Ada.Text_IO; with Ada.Float_Text_IO;
with Ada.Numerics.Elementary_Functions;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
use Ada.Numerics.Elementary_Functions; 
use Ada.Text_IO; use Ada.Float_Text_IO;
with Ada.Float_Text_IO;  use Ada.Float_Text_IO;


procedure LoanCalculationLab is  
   interestRate : Float;  --initialize with user input in the initialize section
   years : Integer; --years the loan will be. Initialize with user input in the initialize section.
   oldBalance : Float;
   fileName : String(1..10);
   F : File_Type;

   procedure LoanCalculations(interestRate : in Float; years : in Integer; oldBalance : in out Float) is 
        balance: Float; --balance to pay off 
        monthlyRate : Float;   --in ur new procedude 
        mathPow : Float; 
        monthlyAmount : Float;
        numofPayments : Integer;

        monthlyInterest : Float;  
        monthlyPrinciple : Float;  

          
        numofPaymentsMade : Integer;  
        totalinterestpaidFloat : Float; 
        totalinterestpaidInteger : Integer;  
    begin 
        balance := oldBalance;
        numofPayments := 12 * years;
        numofPaymentsMade := 1;
        monthlyRate := interestRate/12.0;
        monthlyInterest := balance * monthlyRate;
        mathPow := ((1.0 + monthlyRate) ** numofPayments); 
        monthlyAmount := (monthlyRate * balance * mathPow) / (mathPow - 1.0); --must be rounded to nearest dollar
        monthlyPrinciple := monthlyAmount - monthlyInterest;
        totalinterestpaidFloat := 0.0;
      -----------------------------End of loanCal initaliztion---------------------------
      ----------------------------Start Table Header on Console---------------------------------
      New_Line;
      Put(Item => (1..45 => ' '));
      Put_Line("Truth in Lending Report");
      New_Line;
      Put_Line("Month  | Starting Loan Balance | Monthly Payment | Paid Toward Principle | Paid Toward Interest | New Loan Balance");
      --------------------------------End Console Table Header------------------------------------
      ------------------------------Table Header for Sequential File----------------------
      New_Line (F);
      Put(F, Item => (1..45 => ' '));
      Put_Line(F, "Truth in Lending Report");
      New_Line(F);
      Put_Line(F, "Month  | Starting Loan Balance | Monthly Payment | Paid Toward Principle | Paid Toward Interest | New Loan Balance");
      -----------------------------End Table Header For Sequential File-------------------
      --------------------------------------------for loop--------------------------------
      for I in 1..numofPayments loop --remember to change back to 1..60
      
      Ada.Integer_Text_IO.Put(numofPaymentsMade, width => 3); --Month #
      Ada.Integer_Text_IO.Put(F, numofPaymentsMade, width => 3); -- to File
      Put("    |               $");
      Put(F, "    |               $"); --to File
      Ada.Integer_Text_IO.Put(Integer(oldBalance), width => 6); --Put Line printing out balance before monthly payment in this line
      Ada.Integer_Text_IO.Put(F, Integer(oldBalance), width => 6); --to File
      Put(" |          $");
      Put(F, " |          $"); --to File

            if not (Integer(oldBalance) < Integer(monthlyAmount)) then   
               oldBalance := oldBalance - Float(monthlyPrinciple);
               balance := oldBalance;
            else 
               monthlyAmount := (oldBalance);
               monthlyInterest := (balance * monthlyRate);
               balance := oldBalance - monthlyAmount;
               monthlyPrinciple := (monthlyAmount - monthlyInterest);
            end if;
      Ada.Integer_Text_IO.Put(Integer(monthlyAmount), width => 2); -- add width specification
      Ada.Integer_Text_IO.Put(F, Integer(monthlyAmount), width => 2); --to File

      Put("   |                 $");
      Put(F, "   |                 $"); --to File

      Ada.Integer_Text_IO.Put(Integer(monthlyPrinciple), width => 4);
      Ada.Integer_Text_IO.Put(F, Integer(monthlyPrinciple), width => 4); --to File

      Put(" |                $");
      Put(F," |                $"); --to File

      Ada.Integer_Text_IO.Put(Integer(monthlyInterest), width => 4);
      Ada.Integer_Text_IO.Put(F,Integer(monthlyInterest), width => 4); --to File

      Put(" |           $"); 
      Put(F, " |           $"); --to File

      Ada.Integer_Text_IO.Put(Integer(balance), width => 5);
      Ada.Integer_Text_IO.Put(F, Integer(balance), width => 5); --to File 

      New_Line;
      New_Line(F);
      --------------------Update your Values per iteration--------------------
      totalinterestpaidFloat := totalinterestpaidFloat + monthlyInterest;
      monthlyInterest := balance * monthlyRate;
      monthlyPrinciple := monthlyAmount - monthlyInterest;
      numofPaymentsMade := numofPaymentsMade + 1;
      end loop;
      -----------------------------end for loop--------------------------------
      --------------------------output for total interest paid-----------------
      New_Line;
      New_Line(F);

      Put(Item => (1..45 => ' '));
      Put(F, Item => (1..45 => ' ')); --to File

      Put("Total Interest Paid: $");
      Put(F,"Total Interest Paid: $"); --to File

      Ada.Integer_Text_IO.Put(Integer(totalinterestpaidFloat), width => 2 );
      Ada.Integer_Text_IO.Put(F,Integer(totalinterestpaidFloat), width => 2 ); --to File

      New_Line;
      New_Line(F);

      Put(Item => (1..51 => ' '));
      Put(F, Item => (1..51 => ' ')); --to File

      Put("Interest Rate: ");
      Put(F, "Interest Rate: "); --to File

      Ada.Float_Text_IO.Put(interestRate * 100.0, Exp => 0, Aft => 2);
      Ada.Float_Text_IO.Put(F,interestRate * 100.0, Exp => 0, Aft => 2); --to File

      Put("%");
      Put(F, "%");

      New_Line;
      New_Line(F);

      Put(Item => (1..51 => ' '));
      Put(F, Item => (1..51 => ' '));

      Put("Years of Loan: ");
      Put(F, "Years of Loan: ");

      Ada.Integer_Text_IO.Put(years, width => 3);
      Ada.Integer_Text_IO.Put(F,years, width => 3);

      New_Line;
      New_Line;
      New_Line(F);
      New_Line(F);
      --------------------------end of output for interest paid----------------

--put in calculations and for loop and if else statement and the output (console and interest) for the program
    end LoanCalculations;

begin
---------------------------Begin of Initialization for the main Procedure
       -- create output file (file name)
       -- open output file
       -- call procedure loanCalculations
       -- output interest of years
       -- close file  
     -----------------------Print to Console-------------------
      Put_Line("Enter the desired name for your report (Must be 10 Characters): ");
      Ada.Text_IO.Get(fileName);
      Put_Line("Enter number of years: ");
      Ada.Integer_Text_IO.Get(years);
      Put_Line("Enter your interest rate (in decimal form): ");
      Ada.Float_Text_IO.Get(Float(interestRate));
      Put_Line("Enter your loan principle (in decimal form): ");
      Ada.Float_Text_IO.Get(oldBalance);
      Create(F, Out_File, fileName);
      LoanCalculations(interestRate, years, oldBalance); --Print to File & Console 
      Close(F);
      ----------------------End Print to Console---------------
    
-------------------End of Initialization for the main Procedure-------

    
end LoanCalculationLab;
--------------------------End Program-------------------------------------
