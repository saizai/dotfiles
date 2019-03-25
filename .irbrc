require 'readline'
def _cp(obj = Readline::HISTORY.entries[-2], *options)
  if obj.respond_to?(:join) && !options.include?(:a)
    if options.include?(:s)
      obj = obj.map { |element| ":#{element.to_s}" }
    end
    out = obj.join(", ")
  elsif obj.respond_to?(:inspect)
    out = obj.is_a?(String) ? obj : obj.inspect
  end

  if out
    IO.popen('pbcopy', 'w') { |io| io.write(out) }
    "copied!"
  end
end

class File
  def self.exts filename, extended = false
    return nil if File.directory?(filename)
    unless @mimetypes_hash
      @mimetypes_hash = {}
      File.read("/Applications/Backup and Sync.app/Contents/Resources/lib/python2.7/resources/mime/drive.mime.types").
      gsub(/^#.*$\n/,'').gsub(/^\s*$\n/,'').
      split("\n").map do |y|
        yy = y.split
        next if yy.empty?
        @mimetypes_hash[yy[0]] = yy[1..-1]
      end
    end
    if File.exist?(filename) && File.readable?(filename)
      filename = File.expand_path(filename)
      mimetypes = `file #{"-k" if extended} -b --mime-type "#{filename}"`.gsub('\012-',' ').split.map(&:strip)
      all_exts = {}
      mimetypes.each do |mt|
        exts = `grep #{mt} "/Applications/Backup and Sync.app/Contents/Resources/lib/python2.7/resources/mime/drive.mime.types"`
        exts.split("\n").each do |ext|
          xx = ext.split
          all_exts[xx[0]] = xx[1..-1]
        end
      end
      return all_exts
    else
      raise "File #{filename} not found"
    end
  end
  
  def self.ext_matches?(filename, extended = false)
    return true if File.directory?(filename)
    matches = File.exts(filename, extended).select{|k,v|
      v.include?(File.extname(filename).sub(/^\./,''))
    }.keys
    matches.empty? ? false : matches
  end
  
  def ext_matches?(extended = false)
    File.ext_matches?(self.to_path, extended)
  end
  
  def exts(extended = false)
    File.exts(self.to_path, extended)
  end
end

# # https://github.com/carlhuda/bundler/issues/183#issuecomment-1149953
# if defined?(::Bundler)
#   global_gemset = ENV['GEM_PATH'].split(':').grep(/ruby.*@global/).first
#   if global_gemset
#     all_global_gem_paths = Dir.glob("#{global_gemset}/gems/*")
#     all_global_gem_paths.each do |p|
#       gem_path = "#{p}/lib"
#       $LOAD_PATH << gem_path
#     end
#   end
# end

# Use Pry everywhere
require "rubygems"
require 'pry'
Pry.start
exit
