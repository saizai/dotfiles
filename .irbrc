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
