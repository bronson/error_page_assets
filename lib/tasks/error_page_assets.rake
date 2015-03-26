require 'fileutils'

# Use the Asset Pipeline to generate static error pages.
# For example, /app/assets/html/404.html.erb will be compiled to /public/404.html


Rake::Task['assets:precompile'].enhance do
  Rake::Task['assets:precompile:error_pages'].invoke
end

Rake::Task['assets:clobber'].enhance do
  Rake::Task['assets:clobber:error_pages'].invoke
end


namespace :assets do
  def log msg
    # try to log like Sprockets even though their stuff is all private
    STDERR.puts msg
    Rails.logger.info(msg) if Rails.respond_to?(:logger)
  end

  def process_error_files
    pattern = Rails.root.join('public', 'assets', "[0-9][0-9][0-9]*.html")
    groups = Dir[pattern].group_by { |s| File.basename(s)[0..2] }
    groups.sort_by { |base,_| base }.each do |base, group|
      src = group.sort_by { |f| File.mtime(f) }.last
      dst = Rails.root.join('public', "#{base}.html")
      yield src, dst
    end
  end

  namespace :precompile do
    task :error_pages do
      process_error_files do |src,dst|
        log "copy #{src} to #{dst}"
        FileUtils.cp src, dst
      end
    end
  end

  namespace :clobber do
    task :error_pages do
      process_error_files do |src,dst|
        log "clobber #{dst}"
        FileUtils.rm dst
      end
    end
  end
end

