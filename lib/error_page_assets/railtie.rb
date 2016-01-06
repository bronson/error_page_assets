require 'rails'

module ErrorPageAssets
  class Railtie < Rails::Railtie
    railtie_name :error_page_assets

    rake_tasks do
      load "tasks/error_page_assets.rake"
    end
  end
end

