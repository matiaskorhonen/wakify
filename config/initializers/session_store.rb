# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wakify_session',
  :secret      => '21ef96d1754dbb7dcfa3c9dd50644a2212e92557be728740333e82778c691dfeb68500d147450198cbeebd05fa899bdb45c4aa2aa74d22a2da77ab851147b3aa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
