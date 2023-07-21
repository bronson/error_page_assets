require 'rake/error_page_assets_task'

# Use the Asset Pipeline to generate static error pages.
# For example, /app/assets/html/404.html.erb will be compiled to /public/404.html

Rake::ErrorPageAssetsTask.new

Rake::Task['assets:precompile'].enhance do
  Rake::Task['assets:precompile:error_pages'].invoke
end

Rake::Task['assets:clobber'].enhance ['assets:clobber:error_pages']