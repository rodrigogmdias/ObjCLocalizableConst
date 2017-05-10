class ObjCLocalizableConstReplace  
  def self.running(constantFile, path)
    if constantFile.nil? || !File.file?(constantFile)
      fail "É necessário informar do caminho do ClasseDeConstants.h Localize Válido"
    end
    
    @constantFile = constantFile
    @constants = getMatchConst
    
    if path.nil?
      puts "É necessário informar o caminho dos arquivos que deseja trocar para Constant"
      return false
    end
    
    path = path.chomp("/").chomp("\\")
    
    if File.directory?(path)
      replaceInFiles(Dir["#{path}/**/*.*"])
    elsif File.file?(path)
      replaceInFiles([path])
    else
      puts "Pasta ou arquivo inválido"
      return false
    end
    
  end
  
  def self.getMatchConst
    content = File.read(@constantFile)
    regx = /static NSString \* const (.+) = (@".+");/
    return content.scan(regx).map{|e| {e[0] => e[1]}}.inject(:merge)
  end
  
  def self.replaceInFiles(files)
    files.delete(@constantFile)
    files.each do |file|
      if File.file?(file)
        content = File.read(file)
        new_content = content.dup
        @constants.each do |key, value|
          if content.include?(value) 
            new_content.gsub!(value, key)
            regex = /(^.*?(\w+)?\s*=\s*#{key};.*$)/
            const_to_const = new_content.scan(regex)
            unless const_to_const.empty?
              new_content.gsub!(const_to_const[0][0], "")
              new_content.gsub!(/(\W)#{const_to_const[0][1]}(\W)/){"#{$1}#{key}#{$2}"}
              new_content.gsub!(/^$\n{2,}/, "\n")
            end
          end
        end
        if content != new_content
          File.open(file, "w") {|file| file.puts new_content }
          puts "[Alterado] - #{file}"
        else
          puts "[SEM Alteração] - #{file}"
        end
      end
    end
  end

end