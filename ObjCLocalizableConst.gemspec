Gem::Specification.new do |s|
  s.name        = 'ObjCLocalizableConst'
  s.version     = '1.0.4'
  s.date        = '2017-05-09'
  s.summary     = "Objective C Localizable to Constants!"
  s.description = "Objective C Localizable to Constants."
  s.authors     = ["Rodrigo Dias"]
  s.email       = 'rodrigogd@ciandt.com.br'
  s.files       = ["lib/ObjCLocalizableConstGenerate.rb", "lib/ObjCLocalizableConstReplace.rb"]
  s.homepage    =
    'http://rubygems.org/gems/ObjCLocalizableConst'
  s.license       = 'MIT'
  s.executables << 'ObjCLocalizableConst'
  
  s.add_dependency 'commander', '~> 4.4'
  s.add_dependency 'activesupport', '~> 5.1'
end
