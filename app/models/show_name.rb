class ShowName
  def self.after_commit(obj)
    puts "Name: #{obj.name}"
  end
end
