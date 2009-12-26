# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_new_foosball_session',
  :secret      => '9c284323b94a9d30c6b738033cc01ead564bb71bda2965fb3fdccb5e46c1b66bb7e07caac50a157a5cfb29cbb36fc8df5560353b8333a2f0c04d3266fcee91bf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
