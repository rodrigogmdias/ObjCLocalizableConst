class ObjCLocalizableConstGenerate 
  def self.running(constantFile, path)
    fail 'É necessário informar o arquivo de Constantes válido' if constantFile.nil? || !File.file?(constantFile)
    fail 'É necessário informar onde deseja salvar o arquivo' if path.nil?
    
    @contentConst = File.read(constantFile)
    regx = /"(.*)"\s*=\s*"(.*)"\s*;/
    @contentConst.gsub!(regx) do 
      key = $1
      "static NSString * const kLocalized#{key.gsub(".","_").camelcase} = @\"#{key}\";"
    end
    
    File.open(path, "w") {|file| file.puts @contentConst }
  end
  
end