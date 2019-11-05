#!/usr/bin/env ruby
require 'optparse'

def command?(name)
    `which #{name}`
    $?.success?
end

unless command?('xcodegen')
    p "Installing xcodegen ..."
    system("HOMEBREW_NO_AUTO_UPDATE=1 brew install xcodegen")
end

unless command?('pod')
    p "Installing cocoapods"
    system("sudo gem install cocoapods")
end

options = {}
OptionParser.new do |opt|
    opt.on('--mode FUNCTION') { |o| options[:mode] = o }
end.parse!

mode = options[:mode]

if "#{mode}" == "1"
    # Generate sample project: MyApp
    system('rm -rf temp && rm -rf output && mkdir temp && mkdir output')
    system('cp -r resources/EmptyApp temp/. && cp resources/* temp/.')
    system('cd temp && xcodegen generate && open Podfile')
elsif "#{mode}" == "2"
    # Pod install MyApp 
    system('cd temp && pod install && open ../output')
end