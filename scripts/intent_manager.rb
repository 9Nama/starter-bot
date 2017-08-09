$LOAD_PATH.unshift File.dirname(__FILE__)

require 'rubygems'
require 'bundler/setup'
require 'sistema'
require 'pry'
require 'dotenv'

Dotenv.load!

class IntentManager
  attr_reader :intent_identifier

  def initialize
    @intent_identifier =
      Sistema::IntentIdentifier.new(app_token: ENV.fetch('SISTEMA_AI_TOKEN'))
  end

  def update(examples_folder_path)
    intent_identifier.update_intents_from_path(examples_folder_path)
  end

  def train
    intent_identifier.train
  end

  def predict(text)
    intent_identifier.predict(text)
  end
end

mode = ARGV[0] || 'update'
intent_manager = IntentManager.new

puts 'Updating intentions on Sistema.ai servers...'
result = intent_manager.update('dl_training_data')

abort 'The update has failed. Server did not respond with 200 OK. Exiting...' if result.code != 200

puts 'ATTENTION - ACTION REQUIRED:'
puts 'You have just updated your intents, if you are using entity extraction on your bot, you MUST re-associate your entities. To do that run:'
puts 'ruby scripts/entities_manager.rb associate'
puts '------------------------------------------------------'

if mode == 'update_and_train'
  puts 'Requesting the DL model to be retrained...'
  result = intent_manager.train
  abort 'The request has failed. Server did not respond with 200 OK. Exiting...' if result.code != 200
end

if mode == 'predict'
  im = intent_manager
  binding.pry
end

puts 'Done!'
