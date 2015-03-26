require 'rake'

describe 'assets:precompile:error_pages' do
  before do
    # create our rake task
    Rake.application = Rake::Application.new
    Rake.application.rake_require('stub_assets_precompile', ['spec'])
    Rake.application.rake_require('error_page_assets', ['lib/tasks'])

    stub_const('Rails', Class.new)
    allow(Rails).to receive_message_chain(:root, :join) { |*args| File.join(*args) }
  end

  it "copies the error pages" do
    Rake.application['assets:precompile:error_pages'].invoke
  end
end
