require 'odbc'
require 'table_print'
conn = ODBC.connect('demo','user')
conn.do("use bank")

BEGIN {
puts "Bank of India Welcome"
}

detail = Struct.new(:accno, :name, :balance, :lasttran)
details = Array.new
tdetail = Struct.new(:tid, :from, :to, :amout, :time)
tdetails = Array.new
begin
puts "==========================================================="		
print "1.ADD ACCONT \n2.TRANSFER MONEY \n3.SHOW ACCONTS \n4.EDIT ACCONTS \n5.SHOW TRANSATION \n6.DELETE ACCOUNT \n7.EXIT\n\n"
puts "SELECT ACTION : "
action = gets.chomp.to_i
puts "==========================================================="	

case action
when 1
	puts "==========================================================="	
	print "\nFILL ACCOUNT DETAILS :\n"
	puts"-----------------------------------------------------------"
	print "Accont Number : "
	accno =gets.chomp.to_i
	print "Holder Name : "
	nam =gets.chomp.to_s
	print "Accont Balance : "
	bal=gets.chomp.to_i
	stm = conn.prepare("exec spAddCust @accno=?, @name=?, @balance=?")
    stm.execute(accno, nam, bal)
    stm.drop()
    puts "==========================================================="	
    puts "Accont Created Successfully"
    puts "==========================================================="	

when 2
	puts "==========================================================="
	print "\nFILL TRANSATION DETAILS : \n"
	puts"-----------------------------------------------------------"
	print "From Accont : "
	frm =gets.chomp.to_i
	print "To Accont : "
	too =gets.chomp.to_i
	print "Amount : "
	amt=gets.chomp.to_i
	stm = conn.prepare("exec spTransation @frm=?, @too=?, @amt=?")
    stm.execute(frm,too,amt)
    stm.drop()
    puts "==========================================================="
    puts "Amount Transfred Successfully"
    puts "==========================================================="

when 3 
	puts "==========================================================="
	print "\n ACCOUNT DETAILS \n"
	puts"-----------------------------------------------------------"
	details.clear
	stm = conn.prepare("select * from accdetails")
    stm.execute()
    stm.fetch do |row|
    	details << detail.new(row[0], row[1], row[2], row[3])
    end
    stm.drop()
    puts "==========================================================="
    tp details
    puts "==========================================================="

when 4
	puts "==========================================================="	
	print "\n EDIT ACCOUNT DETAILS :\n"
	puts"-----------------------------------------------------------"
	print "Accont Number : "
	accno =gets.chomp.to_i
	print "Holder Name : "
	nam =gets.chomp.to_s
	print "Accont Balance : "
	bal=gets.chomp.to_i
	stm = conn.prepare("exec spEditAcc @accno=?, @name=?, @balance=?")
    stm.execute(accno, nam, bal)
    stm.drop()
    puts "==========================================================="	
    puts "Accont Updated Successfully"
    puts "==========================================================="


when 5 
	puts "==========================================================="
	print "\n TRANSATION  DETAILS \n"
	puts"-----------------------------------------------------------"
	tdetails.clear
	stm = conn.prepare("select * from transation")
    stm.execute()
    stm.fetch do |row|
    	tdetails << tdetail.new(row[0], row[1], row[2], row[3], row[4])
    end
    stm.drop()
    puts "==========================================================="
    tp tdetails
    puts "===========================================================" 

 when 6
	puts "==========================================================="	
	print "\n DELETE ACCOUNT DETAILS :\n"
	puts"-----------------------------------------------------------"
	print "Accont Number : "
	accno =gets.chomp.to_i
	stm = conn.prepare("exec spDelete @accno=?")
    stm.execute(accno)
    stm.drop()
    puts "==========================================================="	
    puts "Accont Deleted Successfully"
    puts "==========================================================="   

else
	puts "no action done"
end

end while action<7

END{
	puts "Thank you"
}


