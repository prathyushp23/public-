require 'odbc'
conn = ODBC.connect('demo','user')
conn.do("use test")

conn.commit
#conn.do("CREATE TABLE DEPARTMENT(dept_id int,dept_name varchar(50))") 
#conn.do( "INSERT INTO stud VALUES ('Mohan', 20, 40)" )  
#puts "Record has been created"

=begin
sth = conn.prepare("SELECT * FROM stud")
   sth.execute()
   sth.fetch do |row|
   puts "#{row[0]}   #{row[1]}   #{row[2]}"
   end
   conn.commit
=end


conn.prepare("SHOW DATABASES") do |sth|
   sth.execute
   puts "Databases: " + sth.fetch_all.join(", ")
end