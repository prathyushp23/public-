# Declare start wizard method
def start_wizard
	prompt = "> "
	puts "Hi welcome to Text File Creator 2000"
	puts prompt + "To get started, give a name to your file (without extension)"
	filename = $stdin.gets.chomp

	puts prompt + "Awesome, now provide the content of the file !"
	content = $stdin.gets.chomp

	puts """
	Alright, so your filename will be #{filename}.
	And the content will be #{content}.  Do you want to continue (Yes[y]/No[n])?
	"""
	
	# Confirm the creation of the file
	response = $stdin.gets.chomp

	case response
		# If confirm, create the file
		when 'Y', 'y', 'j', 'J', 'yes', 'Yes'
			out_file = File.new("#{filename}.txt", "w")
			out_file.puts(content)
			out_file.close
			
			puts "Your file has been succesfully created, come back soon !"
		# If not, ask if he wants to continue or just exit
		when 'No','N','no'
			puts prompt + "Oh :(, do you want to start again (Yes[y]/No[n])?"
			
			response = $stdin.gets.chomp

			case response
				when 'Y', 'y', 'j', 'J', 'yes', 'Yes'
					start_wizard()
				when 'No','N','no'
					exit
			end
	end
end

# Start execution 
begin
	start_wizard()
# Write a log in case of error
rescue Exception => e
	File.open("except.log") do |f|
		f.puts e.inspect
		f.puts e.backtrace
	end
end