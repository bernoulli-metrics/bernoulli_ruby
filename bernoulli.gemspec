Gem::Specification.new do |s|
  s.name        = 'bernoulli'
  s.version     = '0.0.0'
  s.date        = '2014-02-17'
  s.summary     = "Ruby gem for Bernoulli"
  s.description = "Bernoulli a/b testing platform"
  s.authors     = ["Joe Gasiorek"]
  s.email       = 'joe.gasiorek@gmail.com'
  s.files       = ["lib/bernoulli.rb"]
  s.homepage    =
      'http://github.com/joeyg'
  s.license       = 'MIT'
  s.add_runtime_dependency 'http', '0.5.0'
end
