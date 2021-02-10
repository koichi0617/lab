instArray = Array.new
instValue = Array.new

flag = 1
File.open(ARGV[0], "r") do |f|
    f.each_line do |line|
      next if line.include?"//"
      if((flag == 0) && (line.length < 8))
        flag = 1
        inst = ""
        instValue.each{|tmp_value|
          inst = "#{inst}#{tmp_value}"
        }
        inst = "#{'0' * (128 - inst.length)}#{inst.reverse}"
        puts inst 
        next
      end

      if((flag == 1) && (line.length < 8))
        next
      end

      if((flag == 1) && (line.include?"INST"))
        flag = 0
      end
      tmp_inst = line.split(" ")[0]
      tmp_value = line.split(" ")[1].reverse
      if !instArray.include?tmp_inst
        instArray.push tmp_inst
        instValue.push tmp_value
      elsif
        index = instArray.index(tmp_inst)
        instValue[index] = tmp_value
      end
    end
end