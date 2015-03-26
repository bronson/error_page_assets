guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard :rspec, cmd: 'rspec' do
  # run all specs if any Ruby file is modified
  watch(%r{^lib/.+\.rb}) { "spec" }
  # watch(%r{.*\.rb})
  # watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }

  # re-run just the spec
  watch(%r{^spec/.+_spec\.rb$})

  # run all specs if the helper is modified
  watch(%r{spec/spec_helper\.rb})  { "spec" }
end
