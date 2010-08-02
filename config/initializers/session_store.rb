# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_book_assist_session',
  :secret      => '9ddc5a2a944e54aab43a302d438aadb59ef0c5eaaeef58c014b4e03d5f310b60f24cc977638c587859423a4ba863d63b3df74e18a68567a066b49874161c721e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
