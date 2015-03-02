#Pry.commands.alias_command 'c', 'continue'
#Pry.commands.alias_command 's', 'step'
#Pry.commands.alias_command 'n', 'next'
#Pry.commands.alias_command 'f', 'finish'

# hirb
if defined? Hirb

#	Hirb.enable
#	old_print = Pry.config.print
#	Pry.config.print = proc do |output, value|
#	  Hirb::View.view_or_page_output(value) || old_print.call(output, value)
#	end

	Hirb.enable
	old_print = Pry.config.print
	Pry.config.print = proc do |*args|
	  Hirb::View.view_or_page_output(args[1]) || old_print.call(*args)
	end
end

