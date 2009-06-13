task :publish do
    wares = YAML.load_file(File.join("data", "wares.yml"))

    questions = [
        "Who are you and what do you do?",
        "What hardware do you use?",
        "And what software?",
        "What would be your dream setup?"
    ]

    Dir.glob(File.join("interviews", "drafts", "*.markdown")) do |path|
        puts "Publishing #{path}..\n"
        
        contents = File.read(path)
    
        unless contents.empty?
            contents.sub!(/^(.+)/, '\1' + " @ #{DateTime.now.to_s}")
            contents.gsub!(/### Question (\d)/) do |match|
                "### #{questions[$1.to_i-1]}"
            end
        
            links = contents.scan(/\[([^\[\(\)]+)\]\[([a-z0-9\.\-]+)?\]/)
            if links.length > 0
                contents += "\n\n"
            
                links.each do |link|
                    slug = link[1] ? link[1] : link[0].downcase                        
                    if wares["#{slug}"]
                        contents += "[#{slug}]: #{wares[slug]['url']} \"#{wares[slug]['description']}\"\n"
                    end
                end
            end
        
            new_path = File.join("interviews", "published", File.basename(path))
            File.open(new_path, "w+") do |f|
                f.write(contents)
            end 
        
            File.unlink(path)
        end
    end
end