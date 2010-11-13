# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wakify_session',
  :secret      => '7a8a501a6cd68e46c5be879fedee612844d57adc120a9963ac456980384bf35be85329bfd34f7c582818f05d3e09030d7dce0c63383283dff3756ed93bbc237d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
