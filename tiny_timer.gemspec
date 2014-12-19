require './tiny_timer'
Gem::Specification.new do |s|
  s.name        = 'tiny_timer'
  s.version     = TinyTimer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Łukasz Korecki'
  s.email       = 'lukasz@korecki.me'
  s.summary     = 'tiny_timer!'
  s.description = 'tiny_timer for simple measurements'

  s.files         = ['tiny_timer.rb']
  s.test_file     = 'tiny_timer_test.rb'
  s.require_path  = '.'
end
