require 'fileutils'

# Use the Asset Pipeline to generate static error pages.
# For example, /app/assets/html/404.html.erb will be compiled to /public/404.html


Rake::Task['assets:precompile'].enhance do
  Rake::Task['assets:precompile:error_pages'].invoke
end

namespace :assets do
  namespace :precompile do
    desc 'Copies the newest error pages into /public'
    task :error_pages do
      pattern = Rails.root.join('public', 'assets', "[0-9][0-9][0-9]*.html")
      Dir[pattern].group_by { |s| s[0..2] }.each do |_, group|
        latest = group.sort_by { |f| File.mtime(f) }.last
        FileUtils.cp latest, Rails.root.join('public', "#{page}.html")
      end
    end
  end
end

