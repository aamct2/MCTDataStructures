Pod::Spec.new do |s|
  s.name = 'MCTDataStructures'
  s.version = '0.11.1'
  s.license = 'MIT'
  s.summary = 'Common data structures in Swift'
  s.homepage = 'https://github.com/aamct2/MCTDataStructures'
  s.authors = { 'Aaron McTavish' => 'aaron@mctavishsolutions.com' }
  s.source = { :git => 'https://github.com/aamct2/MCTDataStructures.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'

  s.source_files = 'Sources/MCTDataStructures/*.swift'

  s.requires_arc = true
end
