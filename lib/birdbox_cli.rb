#!/usr/bin/ruby
#

require 'xmpp4r'
require 'xmpp4r/muc'

require './config.rb'

PIPE_FILENAME = "/tmp/birdbox.1"

PHOTO_CMD = "/home/jan/prg/ruby/vogelhaus/lib/photo_p.sh"
PHOTO_CMD_RPT = "/home/jan/prg/ruby/vogelhaus/lib/photo_p_noscale.sh"
PHOTO_PAR_ENTERED = "entered"
PHOTO_PAR_SENSOR = "sensor"


class JabberComm
	def initialize
		@jabberclient = Jabber::Client.new(Jabber::JID.new(JABBER_ID))
	end

	# Connect to the jabber server and create all jabber
	# objects
	def connect
		# create a jabber client connection
		@jabberclient.connect( JABBER_SERVER, JABBER_PORT );
		@jabberclient.auth(JABBER_PASSWD)

		@jabberclient.send(Jabber::Presence.new(:chat, 'Birdbox is waiting since ' + Time.now.to_s))

		@jabberchatroom = Jabber::MUC::MUCClient.new(@jabberclient)
		@jabberchatroom.join(Jabber::JID::new( JABBER_CHATROOM + '/' + @jabberclient.jid.node))

		# create a new message object which will be used later on
		@jabbermsg = Jabber::Message.new( JABBER_TO );
		@jabbermsg.type = :chat
		@jabberReconnect = false
		@jabberRetryMessage = ''
	end


	# Send a message to the chat room
	# The message will be stored in order to allow a retry, if the connection was lost
	def send( a )
		begin
	        @jabbermsg.body = a
    	    @jabberchatroom.send( @jabbermsg )
    	rescue Jabber::ServerDisconnected
    		puts "Server disconnected. Trying reconnect"
    		@jabberReconnect = true
    		@jabberRetryMessage = a
    	rescue Jabber::JabberError => e
    		puts "Error for #{e.error.to_s.inspect}"
    		puts "Trying reconnect"
    		@jabberReconnect = true
    		@jabberRetryMessage = a
    	end
	end


	# Tries to reconnect if jabberReconnect was set and tries
	# to resend a qued message
	def check
		# if reconnect flag is set, we try to reconnect
		if @jabberReconnect then
			begin
				connectToJabber
	    	    if @jabberRetryMessage != '' then
	    	    	sendJabber( @jabberRetryMessage )
	    	    end
			rescue Jabber::JabberError => e
				puts "Reconnect failed: #{e.error.to_s.inspect}"
				puts "Maybe our network connection is down. Client will try to reconnect upon the next visit"
			end
			# Retry only once, even if failed
			@jabberRetryMessage = ''
		end
	end

end


class BirdboxClient

	def initialize
		@jabber = JabberComm.new
	end



	# Main Loop
	def mainLoop
		pipe = open( PIPE_FILENAME, "r+" )
		running = 1

		@jabber.connect

		while( running ) do
			puts "birdbox_cli: waiting for next event from sensor"
			event = pipe.gets
			puts "birdbox_cli: received event #{event}"

			case event.to_i
			when 0
				# Sensor triggered without direction (entering or leaving)
				# 
				puts "birdbox_cli: Sensor triggered"

				@jabber.send('Nistkasten wurde betreten oder verlassen')

				# take a photo
				sleep( PHOTO_DELAY_BEFORE );
				for i in PHOTO_RANGE
					if i == 0 then
						system PHOTO_CMD + " " + PHOTO_PAR_SENSOR + "_" + i.to_s
					else
						system PHOTO_CMD_RPT + " " + PHOTO_PAR_SENSOR + "_" + i.to_s
					end
					sleep( PHOTO_DELAY )
				end
			when 0xffff
				# Exit signal received
				puts "birdbox_cli: Received exit signal"
				running = 0
			end

			@jabber.check
		end

		close(pipe)
	end			
end

# Create a BirdBox Client object an run ist main loop
birdboxclient = BirdboxClient.new
birdboxclient.mainLoop
