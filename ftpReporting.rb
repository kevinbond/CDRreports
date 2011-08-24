require 'net/ftp'
require 'json'

ftp = Net::FTP.new
ftp.connect("ftp.voxeo.net")
ftp.login("kbond","kb032811")

#Go to the reporting directory
ftp.chdir("/reports")

#get a list - which are sorted by years
list = ftp.nlst

#Since you know that you want this year - go to the next directory
ftp.chdir(list[list.length-1])

#set the month variable
month = '08'

#entering that months directory
ftp.chdir(month)

#setting the begginning of the report
startDay = 1

#setting the end of the report
endDay = 13

#opening a new file to safe all of the data
file = File.open("reporting.txt", "a")

#listing all of the files
list = ftp.nlst

#read each file
list.each { |index|
  
  #extracting only the day of this file
  day = [index.split(//)[8], index.split(//)[9]].join
  
  #If that day is between startDay and endDay - save it
  if  day.to_i > (startDay - 1) && day.to_i < (endDay + 1)
    
    #Check to see if it is a json file
    if index == "2011-#{month}-#{day}.cdr.json" 
      #Save the file to your computer
      ftp.gettextfile(list[i])
      #open that file
      report = File.open("path/to/file/2011-#{month}-#{day}.cdr.json", "r")
      #get the contents of that file
      contents = report.read
      #got the contents - now close file
      report.close
      #save the contents to the new file
      file.write("2011-#{month}-#{day}.cdr.json:\n" + contents + "\n\n")
    end
  end
}
#close the newly made file
file.close

