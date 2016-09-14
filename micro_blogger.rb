require 'jumpstart_auth'

class MicroBlogger
		attr_reader :client

		def initialize
			puts "Initializing..."
			@client = JumpstartAuth.twitter
		end

		def tweet(message)
			@client.update(message)
		end

		def dm(target, message)
			puts "trying to sent #{target} this direct message: "
			puts message

			screen_names = @client.followers.collect {|follower| @client.user(follower).screen_name }

			if (screen_names.include? target)
				puts "Found user"
				message = "d @#{target} #{message}"
				tweet(message)
				puts message
			else
				puts "Sorry, can only direct message people who are following you. "
			end
		end

		def run
			puts "Welcome to the JDL Twitter Client!"
			command = ""
			while command != "q"
				printf "enter command: "
				input = gets.chomp
				parts = input.split(" ")
				command = parts[0]

				case command
					when 'q' then puts "Goodbye!"
					when 't' then tweet(parts[1..-1].join(" "))
					when 'dm' then dm(parts[1], parts[2..-1].join(" "))
					else
						puts "Sorry, I don't know how to #{command}"
				end
			end
		end
end

blogger = MicroBlogger.new
blogger.run
#blogger.tweet("MicroBlogger Initialized")