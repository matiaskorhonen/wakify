# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wakify_session',
  :secret      => '54164f039f22119079a360104ed2f2a7e2ca124d33af58855098983bc4c6ef3c0cb2f2ee5f8f91ec318a21216998e64f8ab5eeed0d2ccb55f75c8cb0e02dbdc6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
