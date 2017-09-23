require 'rake'

describe 'assets:precompile:error_pages' do
  before(:all) do
    Rake.application = Rake::Application.new
    Rake.application.rake_require('stub_assets_precompile', ['spec'])
    Rake.application.rake_require('error_page_assets', ['lib/tasks'])
  end

  before do
    # allow rake task to call Rails.root.join
    stub_const('Rails', Class.new)
    allow(Rails).to receive_message_chain(:root, :join) { |*args| Pathname.new(File.join('spec', *args)) }
    allow(Rails).to receive_message_chain(:public_path) { Rails.root.join('public') }
    allow(Rails).to receive(:configuration).and_return(configuration)

    # ensure the rake task uses the most recent asset file
    expect(File).to receive(:mtime).with('spec/public/assets/404-digestnew.html').and_return(Time.now)
    expect(File).to receive(:mtime).with('spec/public/assets/404-digestold.html').and_return(Time.now - 3600)
    expect(File).to receive(:mtime).with('spec/public/assets/500.html').and_return(Time.now)

    # suppress our logging while testing
    expect(STDERR).to receive(:puts).twice
  end

  let(:configuration) do
    double('configuration').tap do |config|
      allow(config).to receive_message_chain(:assets, :prefix).and_return('/assets')
      allow(config).to receive_message_chain(:paths).and_return('public' => [Rails.public_path.to_s])
    end
  end

  it "copies the error pages" do
    expect(FileUtils).to receive(:cp).with('spec/public/assets/404-digestnew.html', 'spec/public/404.html')
    expect(FileUtils).to receive(:cp).with('spec/public/assets/500.html', 'spec/public/500.html')
    Rake.application['assets:precompile'].invoke
  end

  it "clobbers the error pages" do
    expect(FileUtils).to receive(:rm_f).with('spec/public/404.html')
    expect(FileUtils).to receive(:rm_f).with('spec/public/500.html')
    Rake.application['assets:clobber'].invoke
  end
end
