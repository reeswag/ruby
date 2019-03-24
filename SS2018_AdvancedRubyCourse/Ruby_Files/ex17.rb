from_file, to_file = ARGV
indata = File.read(from_file) 
File.write(to_file, indata, mode: 'w')
