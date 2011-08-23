require 'net/ftp'
require 'json'

ftp = Net::FTP.new
ftp.connect("ftp.voxeo.net")
ftp.login("kbond","kb032811")
ftp.chdir("/reports")


list = ftp.nlst
ftp.chdir(list[list.length-1])

month = '08'
ftp.chdir(month)

startDay = 1
endDay = 13

list = ftp.nlst
file = File.open("reporting.txt", "a")
i = 0

list.each { |index|
  
  day = [index.split(//)[8], index.split(//)[9]].join
  
  if  day.to_i > (startDay - 1) && day.to_i < (endDay + 1)
    
    if index == "2011-#{month}-#{day}.cdr.json" 
      ftp.gettextfile(list[i])
      report = File.open("/Users/kevinbond/Sites/ruby/2011-#{month}-#{day}.cdr.json", "r")
      contents = report.read
      file.write("2011-#{month}-#{day}.cdr.json:\n" + contents + "\n\n")
    end
  end
  i = i + 1
}
puts "The file is done!"
