  
  require 'odbc'
  dbc=ODBC.connect('demo','user')

  dbc.do("use test")
  
  sth = dbc.prepare("exec spSelectAll")
  sth.execute()

   sth.fetch do |row|
   puts "#{row[0]}   #{row[1]}   #{row[2]}"
   end
   
   dbc.commit
   dbc.disconnect if dbc