$LOAD_PATH.unshift File.dirname(__FILE__)

require 'rubygems'
require 'bundler/setup'
require 'sistema'
require 'pry'
require 'dotenv'

Dotenv.load!

# modes = 'update', 'update_and_associate', 'parse'
mode = ARGV[0] || ''
token = ENV['SISTEMA_AI_TOKEN']
if token.nil?
  puts "Your Sistema.ai token is not set"
  exit 1
end

extractor = Sistema::EntityExtractor.new(app_token: token)
if mode.include? 'update'
  puts "Updating entities"
  result = extractor.create_or_update_entities 'entity_extractor'
end

if mode.include? 'associate'
  puts "Associating intents with entities"
  result = extractor.associate 'intent_entities_relations'
end

if mode.include? 'parse'
  if ARGV.count < 3
    puts "Intent and/or text is missing."
    exit 1
  end

  intent = ARGV[1]
  text = ARGV[2..9999].join ' '
  puts "Parsing intent: #{intent}, text: #{text}"
  puts extractor.entities_for intent: intent, text: text
end

puts 'Done!'
